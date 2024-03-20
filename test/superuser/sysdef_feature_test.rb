require_relative "../setup"
module BSD::Control
  class SysDefFeatureTest < Test::Unit::TestCase
    require 'fileutils'
    include FileUtils

    def test_sysdef_pageexec
      touch(file)
      assert BSD::Control.feature(:pageexec).enable!(file),
             "The enable! method should have returned true"
      assert_equal(
        BSD::Control.feature(:pageexec).status(file),
        :enabled
      )
      assert BSD::Control.feature(:pageexec).sysdef!(file),
             "The sysdef! method should have returned true"
      assert_equal(
        BSD::Control.feature(:pageexec).status(file),
        :sysdef
      )
    ensure
      rm(file)
    end

    def test_enable_pageexec_nonexistent_file
      assert_raises(Errno::ENOENT) do
        BSD::Control.feature(:pageexec).sysdef!(file)
      end
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
