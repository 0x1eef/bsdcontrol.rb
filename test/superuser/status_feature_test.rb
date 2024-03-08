require_relative "../setup"
module BSD::Control
  class EnableFeatureTest < Test::Unit::TestCase
    require 'fileutils'
    include FileUtils

    def test_mprotect_sysdef_status
      touch(file)
      assert_equal :sysdef,
                   BSD::Control.feature!(:mprotect).status(file)
    ensure
      rm(file)
    end

    def test_mprotect_enabled_status
      touch(file)
      BSD::Control.feature!(:mprotect).enable!(file)
      assert_equal :enabled,
                   BSD::Control.feature!(:mprotect).status(file)
    ensure
      rm(file)
    end


    def test_mprotect_disabled_status
      touch(file)
      BSD::Control.feature!(:mprotect).disable!(file)
      assert_equal :disabled,
                   BSD::Control.feature!(:mprotect).status(file)
    ensure
      rm(file)
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
