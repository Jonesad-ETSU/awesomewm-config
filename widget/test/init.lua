local t = require ('widget.util.select_textbox')
--
return t {
  pre_pop = '',
  post_pop = '',
  pop_cmd = [[echo -e '1\n2\n3']],
  setter_cmd = [[ /home/jonesad/t.sh ]]
}
