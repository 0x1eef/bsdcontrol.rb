#!/usr/bin/env ruby
# frozen_string_literal: true

# Required privileges: superuser
require "bsdcontrol"
BSD::Control
  .feature(:mprotect)
  .status("/bin/ls") # => :sysdef
