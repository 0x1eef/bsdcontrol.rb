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
  gem.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.require_paths = ['lib']
  gem.extensions = %w[ext/bsdcontrol.rb/extconf.rb]
  gem.summary = 'Ruby bindings for libhbsdcontrol'
  gem.description = gem.summary
  gem.add_development_dependency 'rake-compiler', '~> 1.2'
  gem.add_development_dependency 'standard', '~> 1.35'
  gem.add_development_dependency 'test-cmd.rb', '~> 0.8'
  gem.add_development_dependency 'test-unit', '~> 3.6'
end
