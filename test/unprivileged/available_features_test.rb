# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class AvailableFeaturesTest < BSD::Control::Test
    def test_available_features_not_empty
      assert_equal false, available_features.empty?
    end

    def test_available_features_instance_of
      assert_equal true,
                   available_features.all? { _1.instance_of?(BSD::Control::Feature) }
    end

    private

    def available_features
      BSD::Control.available_features
    end
  end
end
