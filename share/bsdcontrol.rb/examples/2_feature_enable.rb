#!/usr/bin/env ruby
# frozen_string_literal: true

# Required privileges: superuser
require "bsdcontrol"
BSD::Control
  .feature(:mprotect)
  .enable! File.realpath("/usr/local/bin/emacs")
