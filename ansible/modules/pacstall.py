#!/usr/bin/python

# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from ansible.module_utils.basic import AnsibleModule
from ansible.module_utils.urls import open_url
import json
import shlex
import tarfile
import os
import os.path
import shutil
import tempfile
import urllib.parse


DOCUMENTATION = """
---
module: aur
short_description: Manage packages from the AUR
description:
    - Manage packages from the Arch User Repository (AUR)
author:
    - Kewl <xrjy@nygb.rh.bet(rot13)>
options:
    name:
        description:
            - Name or list of names of the package(s) to install or upgrade.

    state:
        description:
            - Desired state of the package.
        default: present
        choices: [ present, latest ]

    extra_args:
        description:
            - Arguments to pass to the tool.
              Requires that the 'use' option be set to something other than 'auto'.
        type: str

notes:
  - When used with a `loop:` each package will be processed individually,
    it is much more efficient to pass the list directly to the `name` option.
"""

RETURN = """
msg:
    description: action that has been taken
helper:
    description: the helper that was actually used
"""

EXAMPLES = """
- name: Install trizen using makepkg, skip if trizen is already installed
  aur: name=trizen use=makepkg state=present
  become: yes
  become_user: aur_builder
"""

def_lang = ["env", "LC_ALL=C", "LANGUAGE=C"]

cmds = {
    "add_repo": ["pacstall", "--add-repo"],
    "check_installed": ["pacstall", "--query-info"],
    "install": ["pacstall", "--install", "--disable-prompts"],
    "update_cache": ["pacstall", "--update"],  # update pacstall
    "upgrade": ["pacstall", "--upgrade", "--disable-prompts"],  # upgrade packages
}


def package_installed(module, package):
    """
    Determine if the package is already installed
    """
    cmd = cmds["check_installed"] + [package]
    rc, _, _ = module.run_command(cmd, check_rc=False)
    return rc == 0


def check_packages(module, packages):
    """
    Inform the user what would change if the module were run
    """
    would_be_changed = [
        package for package in packages if not package_installed(module, package)
    ]
    diff = {
        "before": "",
        "after": "\n".join(package for package in would_be_changed if module._diff),
    }

    if would_be_changed:
        status = True
        message = "{} package(s) would be installed".format(len(would_be_changed))
    else:
        status = False
        message = "all packages are already installed"
    module.exit_json(changed=status, msg=message, diff=diff)


def build_command_prefix(
    cmd,
    extra_args,
    local_pkgbuild=None,
):
    """
    Create the prefix of a command that can be used by the install and upgrade functions.
    """
    command = def_lang + cmd

    if local_pkgbuild:
        command.append(local_pkgbuild)
    if extra_args:
        command += shlex.split(extra_args)

    return command


def install_with_makepkg(module, package, extra_args, local_pkgbuild=None):
    """
    Install the specified package or a local PKGBUILD with makepkg
    """
    if not local_pkgbuild:
        module.get_bin_path("fakeroot", required=True)
        f = open_url(
            "https://aur.archlinux.org/rpc/?v=5&type=info&arg={}".format(
                urllib.parse.quote(package)
            )
        )
        result = json.loads(f.read().decode("utf8"))
        if result["resultcount"] != 1:
            return (1, "", "package {} not found".format(package))
        result = result["results"][0]
        f = open_url("https://aur.archlinux.org/{}".format(result["URLPath"]))
    with tempfile.TemporaryDirectory() as tmpdir:
        if local_pkgbuild:
            shutil.copytree(local_pkgbuild, tmpdir, dirs_exist_ok=True)
            command = build_command_prefix("makepkg", extra_args)
            rc, out, err = module.run_command(command, cwd=tmpdir, check_rc=True)
        else:
            tar = tarfile.open(mode="r|*", fileobj=f)
            tar.extractall(tmpdir)
            tar.close()
            command = build_command_prefix(
                "makepkg",
                extra_args,
            )
            rc, out, err = module.run_command(
                command, cwd=os.path.join(tmpdir, result["Name"]), check_rc=True
            )
    return (rc, out, err)


def upgrade(module, extra_args):
    """
    Upgrade the whole system
    """
    command = build_command_prefix(cmds["install"], extra_args)
    command.append("-u")

    rc, out, err = module.run_command(command, check_rc=True)

    module.exit_json(
        changed=not (
            out == "" or "nothing to do" in out.lower() or "No AUR updates found" in out
        ),
        msg="upgraded system",
    )


def install_packages(
    module,
    packages,
    extra_args,
    state,
):
    """
    Install the specified packages
    """
    changed_iter = False

    for package in packages:
        if state == "present" and package_installed(module, package):
            rc = 0
            continue
        command = build_command_prefix(cmds["install"], extra_args)
        command.append(package)
        rc, out, err = module.run_command(command, check_rc=True)

        changed_iter |= not (
            out == ""
            or "up-to-date -- skipping" in out
            or "nothing to do" in out.lower()
        )

    message = "installed package(s)" if changed_iter else "package(s) already installed"

    module.exit_json(
        changed=changed_iter,
        msg=message if not rc else err,
        rc=rc,
    )


def make_module():
    module = AnsibleModule(
        argument_spec={
            "name": {
                "type": "list",
            },
            "state": {
                "default": "present",
                "choices": ["present", "latest"],
            },
            "extra_args": {
                "default": None,
                "type": "str",
            },
        },
        supports_check_mode=True,
    )

    params = module.params

    if params["name"] == []:
        module.fail_json(msg="'name' cannot be empty.")

    return module


def apply_module(module):
    params = module.params

    if module.check_mode:
        check_packages(module, params["name"])
    else:
        install_packages(
            module,
            params["name"],
            params["extra_args"],
            params["state"],
        )


def main():
    module = make_module()
    apply_module(module)


if __name__ == "__main__":
    main()
