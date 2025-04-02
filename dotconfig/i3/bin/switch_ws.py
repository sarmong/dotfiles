#!/usr/bin/env python3

import json
import subprocess
import re
import sys


def main():
    direction = sys.argv[1].lower()

    def extract_number(ws_name):
        match = re.match(r"^(\d+)", ws_name)
        if match:
            return int(match.group(1))
        return 0

    workspace_data = json.loads(
        subprocess.check_output(["i3-msg", "-t", "get_workspaces"]).decode()
    )

    current_ws = None
    active_output = None

    for workspace in workspace_data:
        if workspace["focused"]:
            current_ws = workspace["name"]
            active_output = workspace["output"]
            break

    workspaces_on_output = []
    for workspace in workspace_data:
        if workspace["output"] == active_output:
            workspaces_on_output.append(workspace["name"])

    workspaces_on_output.sort(key=extract_number)

    current_num = extract_number(current_ws)

    target_ws = None

    if direction == "next":
        for ws in workspaces_on_output:
            if extract_number(ws) > current_num:
                target_ws = ws
                break

        if not target_ws:
            target_ws = workspaces_on_output[0]
    else:
        prev_workspaces = [
            ws for ws in workspaces_on_output if extract_number(ws) < current_num
        ]
        if prev_workspaces:
            target_ws = prev_workspaces[-1]
        else:
            target_ws = workspaces_on_output[-1]

    subprocess.run(["i3-msg", "workspace", target_ws])


if __name__ == "__main__":
    main()
