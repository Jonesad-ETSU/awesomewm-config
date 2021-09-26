return require('widget.util.panel_slider') {
  getter = [[pamixer --default-source --get-volume]],
  setter = [[pamixer --default-source --set-volume]],
  -- tooltip = [[]],
  label = [[<b>MIC: </b>]],
}
