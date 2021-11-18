#!/bin/bash
if [ $# -eq 3 ]; then
  title=$1
  message=$2
  image=$3
elif [ $# -eq 2 ]; then
  title=$1
  message=$2
elif [ $# -eq 1 ]; then
  message=$1
else
  echo 'Usage: make-notif.sh [title] [message] [image]'
fi

awesome-client "local n = require('naughty') local b = require('beautiful') local n = require('naughty') local g = require ('gears') n.notification { title = '$title', message = '$message', icon = g.color.recolor_image(g.filesystem.get_configuration_dir()..'$image',b.wibar_fg)}"

