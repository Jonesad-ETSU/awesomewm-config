return require('widget.util.panel_slider') {
  getter = [[pamixer --get-volume]],
  setter = [[pamixer --set-volume]],
  -- tooltip = [[]],
  label = [[<b>VOL: </b>]],
}
