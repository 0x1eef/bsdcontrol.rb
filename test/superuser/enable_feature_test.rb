require_relative "../setup"
module BSD::Control
  class EnableFeatureTest < Test::Unit::TestCase
    require 'fileutils'
    include FileUtils

    def test_enable_mprotect
      touch(file)
      assert BSD::Control.feature(:mprotect).enable!(file),
             "The enable! method should have returned true"
    ensure
      rm(file)
    end

    def test_enable_mprotect_zero_permissions
      touch(file)
      chmod(0, file)
      assert BSD::Control.feature(:mprotect).enable!(file),
             "The enable! method should have returned true"
    ensure
      rm(file)
    end

    def test_enable_mprotect_nonexistent_file
      assert_raises(Errno::ENOENT) do
        BSD::Control.feature(:mprotect).enable!(file)
      end
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
