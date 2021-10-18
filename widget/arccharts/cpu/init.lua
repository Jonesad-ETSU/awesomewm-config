local arcchart = require('widget.arccharts.chart')
return arcchart {
  cmd = [[mpstat | awk '// {print 100-$13}' | tail -n1]],
  image = 'cpu.svg'
}
