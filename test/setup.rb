# frozen_string_literal: true

require "bundler/setup"
require "test/unit"
require "bsdcontrol"

module BSD::Control
  class Test < Test::Unit::TestCase
    require "fileutils"
    include FileUtils

    def setup
      File.exist?(file) ? rm(file) : nil
      touch(file)
    end

    def teardown
      File.exist?(file) ? rm(file) : nil
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
