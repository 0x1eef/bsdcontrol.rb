# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class AvailableFeaturesTest < Test::Unit::TestCase
    def test_available_features_not_empty
      refute available_features.empty?,
             "There should have been at least one available feature"
    end

    def test_available_features_instance_of
      assert available_features.all? { _1.instance_of?(BSD::Control::Feature) },
             "All available features should be an instance of `BSD::Control::Feature`"
    end

    private

    def available_features
      BSD::Control.available_features
    end
  end
end
