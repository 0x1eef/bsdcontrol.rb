# frozen_string_literal: true

require 'bundler/setup'
require 'rake/extensiontask'
Rake::ExtensionTask.new('bsdcontrol.rb')
task default: %w[clobber compile test]

namespace :format do
  desc 'Run clang-format'
  task :clang do
    sh 'clang-format -style=file:.clang-format -i ext/bsdcontrol.rb/*.c'
  end

  desc 'Run rubocop'
  task :ruby do
    sh 'bundle exec rubocop -A'
  end
end

namespace :test do
  desc 'Run unprivileged tests'
  task :unprivileged do
    sh './bin/run-unprivileged-tests'
  end

  desc 'Run superuser tests'
  task :superuser do
    sh './bin/run-superuser-tests'
  end
end
