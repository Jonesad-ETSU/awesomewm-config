#!/bin/bash
if [ $# -gt 0 ]; then
  if [ $1 == 'on' ]; then
    $HOME/.config/awesome/scripts/make-notif.sh 'Do Not Disturb' 'Turning On...' '/icons/bell.svg' && \
    sleep 3 && \
    awesome-client 'local n = require("naughty") n.suspended = true n.destroy_all_notifications()'
  else
    awesome-client 'require("naughty").suspended = false' && \
    $HOME/.config/awesome/scripts/make-notif.sh 'Do Not Disturb' 'Turned Off' '/icons/bell.svg'
  fi
fi
