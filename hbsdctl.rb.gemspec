require_relative "lib/bsd/control/version"
Gem::Specification.new do |gem|
  gem.name = "hbsdctl.rb"
  gem.authors = ["0x1eef"]
  gem.email = ["0x1eef@protonmail.com"]
  gem.homepage = "https://git.hardenedbsd.org/0x1eef/hbsdctl.rb#readme"
  gem.version = BSD::Control::VERSION
  gem.licenses = ["0BSD"]
  gem.files = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
  gem.extensions = %w[ext/hbsdctl.rb/extconf.rb]
  gem.summary = "Ruby bindings for libhbsdcontrol"
  gem.description = gem.summary
  gem.add_development_dependency "rake-compiler", "= 1.2.0"
  gem.add_development_dependency "test-unit", "~> 3.6"
end
