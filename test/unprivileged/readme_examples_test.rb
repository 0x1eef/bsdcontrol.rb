# frozen_string_literal: true

require_relative "../setup"

module BSD::Control
  class ReadmeExamplesTest < BSD::Control::Test
    require "test/cmd"

    def test_available_features_success
      assert_equal true,
                   cmd("ruby", readme_example("1_available_features.rb")).success?
    end

    def test_available_features_stdout
      assert_match %r|\A(The [a-zA-Z0-9_]+ feature is available\n){9}\z|,
                   cmd("ruby", readme_example("1_available_features.rb")).stdout
    end

    private

    def readme_example(path)
      dir = File.join(Dir.getwd, "share", "bsdcontrol.rb", "examples")
      File.join(dir, path)
    end
  end
end
