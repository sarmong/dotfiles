#!/usr/bin/env bash

# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of week (0 - 6) (Sunday to Saturday;
# │ │ │ │ │                                       7 is also Sunday on some systems)
# │ │ │ │ │
# │ │ │ │ │
# * * * * *  command_to_execute

jobs=(
  "1 * * * * $HOME/.local/bin/wrappers/run-cron luna.sh"
  "*/1 * * * * $HOME/.local/bin/wrappers/run-cron bat-notification"
)

(
  crontab -l 2>/dev/null
  printf "%s\n" "${jobs[@]}"
) | crontab -

sudojobs=(
  "36 * * * * /usr/bin/updatedb"
)

(
  sudo crontab -l 2>/dev/null
  printf "%s\n" "${sudojobs[@]}"
) | sudo crontab -
