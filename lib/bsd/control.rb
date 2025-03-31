# frozen_string_literal: true

module BSD
end unless defined?(BSD)

module BSD::Control
  Error = Class.new(RuntimeError)

  ##
  # @return [BSD::Control::Context]
  #  Returns an instance of {BSD::Control::Context BSD::Control::Context}
  def self.context
    @context ||= BSD::Control::Context.new
  end

  ##
  # @return [String]
  #  Returns the version of libhbsdcontrol
  def self.library_version
    context.library_version
  end

  ##
  # @param [#to_s] namespace
  #  Either "user" or "system"
  # @raise [ArgumentError]
  #  When an invalid namespace was given
  # @return [void]
  def self.set_namespace(namespace)
    context.set_namespace(namespace.to_s)
  end

  ##
  # @return [String]
  #  Returns the current namespace
  def self.namespace
    context.namespace
  end

  ##
  # @return [Array<BSD::Control::Feature>]
  #  Returns an array of available features
  def self.available_features
    context.available_features
  end

  ##
  # @example
  #   # This works
  #   BSD::Control
  #     .feature(:mprotect)
  #     .enable!("/usr/local/bin/emacs-29.2")
  #   # This also works
  #   BSD::Control[:mprotect].enable!("/usr/local/bin/emacs-29.2")
  # @param [String] name
  #  The name of a feature
  # @raise [BSD::Control::Error]
  #  When a feature wasn't found
  # @return [BSD::Control::Feature]
  #  Returns an instance of {BSD::Control::Feature BSD::Control::Feature}
  def self.feature(name)
    feature = available_features.find { _1.name == name.to_s }
    feature || raise(Error, "'#{name}' wasn't found")
  end

  class << self
    alias_method :[], :feature
  end

  require_relative "control/context"
  require_relative "control/feature"
  require_relative "../bsdcontrol.rb.so"
end
