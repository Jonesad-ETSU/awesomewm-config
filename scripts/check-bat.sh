#!/bin/bash
search_result=$(upower -e | grep BAT)
power=$(upower -i $search_result)

echo "$power" | awk '/percentage/ {gsub("%",""); print $2}'
