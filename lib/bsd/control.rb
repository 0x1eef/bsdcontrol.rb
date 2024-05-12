# frozen_string_literal: true

module BSD::Control
  require_relative "control/context"
  require_relative "control/feature"
  Error = Class.new(RuntimeError)

  ##
  # @return [BSD::Control::Context]
  #  Returns an instance of {BSD::Control::Context BSD::Control::Context}.
  def self.context
    @context ||= BSD::Control::Context.new
  end

  ##
  # @return [String]
  #  Returns the version of libhbsdcontrol.
  def self.library_version
    context.library_version
  end

  ##
  # @return [Array<BSD::Control::Feature>]
  #  Returns an array of available features.
  def self.available_features
    context.available_features
  end

  ##
  # @example
  #   BSD::Control
  #     .feature(:mprotect)
  #     .enable!("/usr/local/bin/emacs-29.2")
  #
  # @param [String] name
  #  The name of a feature.
  #
  # @raise [BSD::Control::Error]
  #  When a feature is not found.
  #
  # @return [BSD::Control::Feature]
  #  Returns an instance of {BSD::Control::Feature BSD::Control::Feature}.
  def self.feature(name)
    feature = available_features.find { _1.name == name.to_s }
    feature || raise(Error, "feature '#{name}' wasn't found")
  end
end
