# frozen_string_literal: true

require_relative "setup"

class ReadmeExamplesTest < Test::Unit::TestCase
  require "rbconfig"
  require "test/cmd"

  def test_available_features_success
    assert_equal true,
                 cmd(RbConfig.ruby, readme_example("1_available_features.rb"))
                 .status.success?
  end

  def test_available_features_stdout
    cmd(RbConfig.ruby, readme_example("1_available_features.rb"))
    .stdout
    .each_line { assert_match %r{The [a-zA-Z0-9_]+ feature is available}, _1 }
  end

  private

  def readme_example(name)
    File.join(Dir.getwd, "share", "bsdcontrol.rb", "examples", name)
  end
end
