# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class DisableFeatureTest < BSD::Control::Test
    def test_disable_pageexec
      assert_equal true, feature(:pageexec).disable!(file)
      assert_equal :disabled, feature(:pageexec).status(file)
    end

    def test_disable_pageexec_nonexistent_file
      rm(file)
      assert_raises(Errno::ENOENT) { feature(:pageexec).disable!(file) }
    end

    private

    def feature(name)
      BSD::Control.feature(name)
    end
  end
end
