#!/bin/bash
if [ $# -gt 0 ]; then
  if [ $1 == 'on' ]; then
  rfkill block $(rfkill | awk '{if($2!="TYPE")print $2}') && \
    $HOME/.config/awesome/scripts/make-notif.sh 'Airplane Mode' 'On' '/icons/airplane.svg'
  elif [ $1 == 'off' ]; then
  rfkill unblock $(rfkill | awk '{if($2!="TYPE")print $2}') && \
    $HOME/.config/awesome/scripts/make-notif.sh 'Airplane Mode' 'Off' '/icons/airplane.svg'
  fi
fi
