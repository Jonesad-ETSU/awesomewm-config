#!/bin/bash
screen_res=$(xrandr | awk '// {if(NR==1) print $8,$9,$10}' | tr -d ',')
width=$(echo $screen_res | cut -d ' ' -f 1)
height=$(echo $screen_res | cut -d ' ' -f 3)

width_sq=$(echo "scale=0;$width^2" | bc)
height_sq=$(echo "scale=0;$height^2" | bc)

screen_sides=$(xrandr | grep -Eo '[[:digit:]]+mm' | tr -d '[[:alpha:]]')
screen_width_mm=$(echo "$screen_sides" | head -n1)
screen_height_mm=$(echo "$screen_sides" | tail -n1)
screen_diag=$(echo "scale=10;sqrt(($screen_width_mm/25.4)^2+($screen_height_mm/25.4)^2)" | bc)

dpi=$(echo "scale=0;(sqrt($width_sq+$height_sq)/$screen_diag)" | bc)
echo "Xft.dpi: $dpi" >> ~/.Xresources
