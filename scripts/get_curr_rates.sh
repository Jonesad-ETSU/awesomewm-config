#!/bin/bash
# Why did I do this?
xrandr | awk " / connected/ {on=1}; {if(on==1) {a[NR]=\$0}}; /^[[:alpha:]]/ {p=0; for (i in a) print a[i]; delete a}" | grep *+ | awk '// {first=$1;$1="";gsub("[*+]","");print $0}' 2>/dev/null | cut -d ' ' -f 2- | sed 's/ /\n/g'
