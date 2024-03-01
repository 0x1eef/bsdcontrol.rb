require 'mkmf'
$LIBS << ' -lsbuf -lhbsdcontrol'
create_makefile("hbsdctl.rb")
