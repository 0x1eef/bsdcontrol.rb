# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class FeatureStatusTest < BSD::Control::Test
    def test_pageexec_sysdef_status
      assert_equal :sysdef, feature(:pageexec).status(file)
    end

    def test_pageexec_enabled_status
      feature(:pageexec).enable!(file)
      assert_equal :enabled, feature(:pageexec).status(file)
    end

    def test_pageexec_disabled_status
      feature(:pageexec).disable!(file)
      assert_equal :disabled, feature(:pageexec).status(file)
    end

    private

    def feature(name)
      BSD::Control.feature(name)
    end
  end
end
