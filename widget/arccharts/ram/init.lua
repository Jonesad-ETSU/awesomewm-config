local arcchart = require ('widget.arccharts.chart')
return arcchart {
  cmd = [[free -m | awk 'NF==7 {print $3/$2*100}']],
  image = 'ram.svg'
}
