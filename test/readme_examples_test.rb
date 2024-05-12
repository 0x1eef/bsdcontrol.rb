require_relative "setup"

class ReadmeExamplesTest < Test::Unit::TestCase
  require "rbconfig"
  require "test/cmd"

  def test_available_features
    result = cmd(RbConfig.ruby, readme_example('1_available_features.rb'))
    assert_equal true, result.status.success?
    result.each_line { assert_match %r|The [a-zA-Z0-9_]+ feature is available|, _1 }
  end

  private

  def readme_example(name)
    File.join(Dir.getwd, 'share', 'bsdcontrol.rb', 'examples', name)
  end
end
