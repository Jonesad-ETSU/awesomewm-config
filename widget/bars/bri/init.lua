return require('widget.util.panel_slider') {
  getter = [[brightnessctl i | awk '/Current/ {gsub("[()%]",""); print $4}']],
  setter = [[brightnessctl s]],
  setter_post = [[%]],
  minimum = 5,
  -- tooltip = [[]],
  label = [[<b>BRI: </b>]],
}
