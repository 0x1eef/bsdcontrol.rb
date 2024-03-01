Gem::Specification.new do |gem|
  gem.name = "hbsdctl.rb"
  gem.authors = ["0x1eef"]
  gem.email = ["0x1eef@protonmail.com"]
  gem.homepage = "https://github.com/0x1eef/hbsdctl.rb#readme"
  gem.version = "0.1.0"
  gem.licenses = ["0BSD"]
  gem.files = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
  gem.extensions = %w[ext/hbsdctl.rb/extconf.rb]
  gem.summary = "A Ruby interface for libhbsdcontrol"
  gem.description = gem.summary
  gem.add_development_dependency "rake-compiler", "= 1.2.0"
end