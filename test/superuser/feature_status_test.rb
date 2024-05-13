# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class FeatureStatusTest < BSD::Control::Test
    def test_pageexec_sysdef_status
      assert_equal :sysdef,
                   BSD::Control.feature(:pageexec).status(file)
    end

    def test_pageexec_enabled_status
      BSD::Control.feature(:pageexec).enable!(file)
      assert_equal :enabled,
                   BSD::Control.feature(:pageexec).status(file)
    end

    def test_pageexec_disabled_status
      BSD::Control.feature(:pageexec).disable!(file)
      assert_equal :disabled,
                   BSD::Control.feature(:pageexec).status(file)
    end
  end
end
