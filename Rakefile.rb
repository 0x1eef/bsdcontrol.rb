require "bundler/setup"
require "rake/extensiontask"
Rake::ExtensionTask.new("hbsdctl.rb")
task default: %w[clobber compile test]

desc "Run C linter"
task :styleguide do
  sh "uncrustify -c .styleguide.cfg --no-backup ext/hbsdctl.rb/*.c"
end

namespace :test do
  desc "Run unprivileged tests"
  task :unprivileged do
    sh "./bin/run-unprivileged-tests"
  end

  desc "Run superuser tests"
  task :superuser do
    sh "./bin/run-superuser-tests"
  end
end
