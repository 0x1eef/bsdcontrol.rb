require "bundler/setup"
require "rake/extensiontask"
Rake::ExtensionTask.new("hbsdctl.rb")
task default: %w[clobber compile test]
