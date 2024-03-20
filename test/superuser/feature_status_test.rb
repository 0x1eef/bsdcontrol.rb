require_relative "../setup"
module BSD::Control
  class FeatureStatusTest < Test::Unit::TestCase
    require 'fileutils'
    include FileUtils

    def test_pageexec_sysdef_status
      touch(file)
      assert_equal :sysdef,
                   BSD::Control.feature(:pageexec).status(file)
    ensure
      rm(file)
    end

    def test_pageexec_enabled_status
      touch(file)
      BSD::Control.feature(:pageexec).enable!(file)
      assert_equal :enabled,
                   BSD::Control.feature(:pageexec).status(file)
    ensure
      rm(file)
    end


    def test_pageexec_disabled_status
      touch(file)
      BSD::Control.feature(:pageexec).disable!(file)
      assert_equal :disabled,
                   BSD::Control.feature(:pageexec).status(file)
    ensure
      rm(file)
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
