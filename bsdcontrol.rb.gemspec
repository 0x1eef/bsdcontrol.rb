# frozen_string_literal: true

require 'English'
require_relative 'lib/bsd/control/version'
Gem::Specification.new do |gem|
  gem.name = 'bsdcontrol.rb'
  gem.authors = ['0x1eef']
  gem.email = ['0x1eef@protonmail.com']
  gem.homepage = 'https://git.hardenedbsd.org/0x1eef/bsdcontrol.rb#readme'
  gem.version = BSD::Control::VERSION
  gem.licenses = ['0BSD']
  gem.files = Dir[
    File.join(__dir__, "lib", "*.rb"),
    File.join(__dir__, "lib", "**", "*.rb"),
    File.join(__dir__, "ext", "bsdcontrol.rb", "*.{c,h,rb}"),
    File.join(__dir__, "share", "bsdcontrol.rb", "examples", "*.rb"),
    "README.md", "LICENSE"
  ]
  gem.require_paths = ['lib']
  gem.extensions = %w[ext/bsdcontrol.rb/extconf.rb]
  gem.summary = 'Ruby bindings for libhbsdcontrol'
  gem.description = gem.summary
  gem.add_development_dependency 'rake-compiler', '~> 1.2'
  gem.add_development_dependency 'standard', '~> 1.35'
  gem.add_development_dependency 'test-cmd.rb', '~> 0.12'
  gem.add_development_dependency 'test-unit', '~> 3.6'
  gem.add_development_dependency 'irb', '~> 1.15'
end
