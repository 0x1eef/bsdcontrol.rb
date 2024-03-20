require "bundler/setup"
require "rake/extensiontask"
Rake::ExtensionTask.new("hbsdctl.rb")
task default: %w[clobber compile test]

desc "Run C linter"
namespace :clang do
  task :format do
    sh "clang-format -style=file:.clang-format -i ext/hbsdctl.rb/*.c"
  end
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
