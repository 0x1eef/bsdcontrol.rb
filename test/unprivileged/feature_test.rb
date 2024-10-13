# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class FeatureTest < BSD::Control::Test
    def test_pageexec_feature
      assert_instance_of BSD::Control::Feature, feature(:pageexec)
    end

    def test_nonexistent_feature
      assert_raises(BSD::Control::Error) { feature(:non_existent_feature) }
    end

    private

    def feature(name)
      BSD::Control.feature(name)
    end
  end
end
