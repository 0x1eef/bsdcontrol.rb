# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class SysDefFeatureTest < BSD::Control::Test
    def test_sysdef_pageexec
      assert_equal true,
                   BSD::Control.feature(:pageexec).enable!(file)
      assert_equal :enabled,
                   BSD::Control.feature(:pageexec).status(file)
      assert_equal true,
                   BSD::Control.feature(:pageexec).sysdef!(file)
      assert_equal :sysdef,
                   BSD::Control.feature(:pageexec).status(file)
    end

    def test_enable_pageexec_nonexistent_file
      rm(file)
      assert_raises(Errno::ENOENT) do
        BSD::Control.feature(:pageexec).sysdef!(file)
      end
    end
  end
end
