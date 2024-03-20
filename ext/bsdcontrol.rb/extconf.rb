require 'mkmf'
$LIBS << ' -lsbuf -lhbsdcontrol'
create_makefile("bsdcontrol.rb")
