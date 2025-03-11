#!/usr/bin/env node

const util = require("node:util");
const path = require("path");
const exec = util.promisify(require("node:child_process").exec);

const main = async () => {
  const file = path.join(
    process.env.XDG_DOTFILES_DIR,
    "/ansible/tasks/software/build/vars/binary_packages.yml",
  );
  const json = await exec("yq .binary_packages " + file);
  const pkgs = JSON.parse(json.stdout);

  for (const pkg in pkgs) {
    const pkgSpec = pkgs[pkg];

    const repoSlug = pkgSpec.url.match("https://github.com/(.*)/releases")[1];

    const res = await fetch(
      `https://api.github.com/repos/${repoSlug}/releases/latest`,
    );
    const resJson = await res.json();

    if (!res.ok) {
      console.log("Seems like you are rate-limited. Try again in an hour.");
      console.log(resJson.message);
      process.exit(1);
    }

    const latestVersion = resJson.tag_name;

    if (
      pkgSpec.version !== latestVersion &&
      `v${pkgSpec.version}` !== latestVersion
    ) {
      console.log(
        `    ${pkg.padEnd(20, " ")} - ${pkgSpec.version.padEnd(10, " ")} ==> ${latestVersion}`,
      );
      console.log(resJson.html_url, "\n");
    }
  }
};
main();
