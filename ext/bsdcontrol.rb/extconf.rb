require 'mkmf'
$LIBS << ' -lhbsdcontrol'
create_makefile("bsdcontrol.rb")
