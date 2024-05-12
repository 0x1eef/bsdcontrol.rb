# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class EnableFeatureTest < Test::Unit::TestCase
    require "fileutils"
    include FileUtils

    def test_enable_pageexec
      touch(file)
      assert BSD::Control.feature(:pageexec).enable!(file),
             "The enable! method should have returned true"
    ensure
      rm(file)
    end

    def test_enable_pageexec_zero_permissions
      touch(file)
      chmod(0, file)
      assert BSD::Control.feature(:pageexec).enable!(file),
             "The enable! method should have returned true"
    ensure
      rm(file)
    end

    def test_enable_pageexec_nonexistent_file
      assert_raises(Errno::ENOENT) do
        BSD::Control.feature(:pageexec).enable!(file)
      end
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
