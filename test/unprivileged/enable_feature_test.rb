# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class EnableFeatureTest < Test::Unit::TestCase
    require "fileutils"
    include FileUtils

    def test_enable_feature_lacks_privileges
      touch(file)
      assert_raises(Errno::EPERM) do
        BSD::Control.feature(:pageexec).enable!(file)
      end
    ensure
      rm(file)
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
