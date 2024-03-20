require_relative "../setup"
module BSD::Control
  class SysDefTest < Test::Unit::TestCase
    require "fileutils"
    include FileUtils

    def test_sysdef!_lacks_privileges
      touch(file)
      assert_raises(Errno::EPERM) do
        BSD::Control.feature(:pageexec).sysdef!(file)
      end
    ensure
      rm(file)
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
