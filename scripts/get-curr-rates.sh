#!/bin/bash
if [ $# -ge 1 ]; then
  xrandr | awk "/$1/,/connected/ {} {if (\$2 ~ /\*/) { for(i=2;i<=NF;i++) {gsub(\"[+*]\",\"\");print \$i}}}"
else
  # Hardwired for my screen... bc this should never be used.
  xrandr | awk "/eDP-1/,/connected/ {} {if (\$2 ~ /\*/) { for(i=2;i<=NF;i++) {gsub(\"[+*]\",\"\");print \$i}}}"
fi

# I want to leave this here as a reminder of why Stack Overflow must be used in moderation.
# xrandr | awk " / connected/ {on=1}; {if(on==1) {a[NR]=\$0}}; /^[[:alpha:]]/ {p=0; for (i in a) print a[i]; delete a}" | grep *+ | awk '// {first=$1;$1="";gsub("[*+]","");print $0}' 2>/dev/null | cut -d ' ' -f 2- | sed 's/ /\n/g'
