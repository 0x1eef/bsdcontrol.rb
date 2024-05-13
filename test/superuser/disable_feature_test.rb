# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class DisableFeatureTest < BSD::Control::Test
    def test_disable_pageexec
      assert_equal true,
                   BSD::Control.feature(:pageexec).disable!(file)
      assert_equal :disabled,
                   BSD::Control.feature(:pageexec).status(file)
    end

    def test_disable_pageexec_nonexistent_file
      rm(file)
      assert_raises(Errno::ENOENT) do
        BSD::Control.feature(:pageexec).disable!(file)
      end
    end
  end
end
