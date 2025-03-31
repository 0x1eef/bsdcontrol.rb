# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class SysDefFeatureTest < BSD::Control::Test
    def setup
      super
      BSD::Control.set_namespace(:user)
    end

    def test_sysdef_pageexec
      assert_equal true, feature(:pageexec).enable!(file)
      assert_equal :enabled, feature(:pageexec).status(file)
      assert_equal true, feature(:pageexec).sysdef!(file)
      assert_equal :sysdef, feature(:pageexec).status(file)
    end

    def test_enable_pageexec_nonexistent_file
      rm(file)
      assert_raises(Errno::ENOENT) { feature(:pageexec).sysdef!(file) }
    end

    private

    def feature(name)
      BSD::Control.feature(name)
    end
  end
end
