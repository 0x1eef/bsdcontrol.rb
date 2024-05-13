# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class EnableFeatureTest < BSD::Control::Test
    def test_enable_pageexec
      assert_equal true,
                   BSD::Control.feature(:pageexec).enable!(file)
    end

    def test_enable_pageexec_mode_zero
      chmod(0, file)
      assert_equal true,
                   BSD::Control.feature(:pageexec).enable!(file)
    end

    def test_enable_pageexec_nonexistent_file
      rm(file)
      assert_raises(Errno::ENOENT) do
        BSD::Control.feature(:pageexec).enable!(file)
      end
    end
  end
end
