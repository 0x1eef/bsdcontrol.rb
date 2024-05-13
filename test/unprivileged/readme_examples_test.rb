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
      cmd("ruby", readme_example("1_available_features.rb"))
        .stdout
        .each_line { assert_match %r{The [a-zA-Z0-9_]+ feature is available}, _1 }
    end

    private

    def readme_example(name)
      File.join(Dir.getwd, "share", "bsdcontrol.rb", "examples", name)
    end
  end
end
