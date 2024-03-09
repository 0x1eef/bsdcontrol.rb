require_relative "../setup"
module BSD::Control
  class DisableFeatureTest < Test::Unit::TestCase
    require 'fileutils'
    include FileUtils

    def test_disable_mprotect_nonexistent_file
      assert_raises Errno::ENOENT do
        BSD::Control.feature(:mprotect).disable!(file)
      end
    end

    private

    def file
      File.join(__dir__, "file")
    end
  end
end
