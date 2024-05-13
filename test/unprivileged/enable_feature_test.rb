# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class EnableFeatureTest < BSD::Control::Test
    def test_enable_feature_insufficient_permissions
      assert_raises(Errno::EPERM) do
        BSD::Control.feature(:pageexec).enable!(file)
      end
    end
  end
end
