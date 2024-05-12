#!/usr/bin/env ruby
# Required privileges: user, superuser
require "bsdcontrol"
BSD::Control
  .available_features
  .each do
  print "The ", _1.name, " feature is available", "\n"
end
