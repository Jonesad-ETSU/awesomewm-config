#!/bin/bash
value=$(checkupdates 2>/dev/null | wc -l)
if [ $value == '0' ]; then
  echo 100
else
  echo $value
fi
