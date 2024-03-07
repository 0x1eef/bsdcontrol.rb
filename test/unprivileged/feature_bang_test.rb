require_relative "../setup"
module BSD::Control
  class FeatureBangTest < Test::Unit::TestCase
    def test_mprotect_feature
      assert_instance_of BSD::Control::Feature,
                         BSD::Control.feature!(:mprotect)
    end

    def test_nonexistent_feature
      assert_raises(BSD::Control::Error) do
        BSD::Control.feature!(:non_existent_feature)
      end
    end
  end
end
