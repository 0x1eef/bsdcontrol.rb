# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class FeatureStatusTest < BSD::Control::Test
    def setup
      super
      BSD::Control.set_namespace(:user)
    end

    def test_pageexec_sysdef_status
      assert_equal :sysdef, feature(:pageexec).status(file)
    end

    private

    def feature(name)
      BSD::Control.feature(name)
    end
  end
end
