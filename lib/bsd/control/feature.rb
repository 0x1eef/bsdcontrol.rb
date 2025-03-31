# frozen_string_literal: true

module BSD::Control
  class Feature < Struct.new(:name, :context)
    ##
    # @return [Array<BSD::Control::Feature>]
    #  Returns an array of available features
    def self.available
      BSD::Control.available_features
    end

    ##
    # @group Actions

    ##
    # Enables a feature for a given file
    # @param [String] path
    #  The path to a file
    # @raise [SystemCallError]
    #  Might raise a number of Errno exceptions
    # @return [Boolean]
    #  Returns true on success
    def enable!(path)
      set!(path, ENABLED)
    end

    ##
    # Disables a feature for a given file
    # @param [String] path
    #  The path to a file
    # @raise [SystemCallError]
    #  Might raise a number of Errno exceptions
    # @return [Boolean]
    #  Returns true on success
    def disable!(path)
      set!(path, DISABLED)
    end

    ##
    # @!method sysdef!(path)
    #   Restores the system default for a given file
    #   @param [String] path
    #     The path to a file
    #   @raise [SystemCallError]
    #     Might raise a number of Errno exceptions
    #   @return [Boolean]
    #     Returns true on success

    # @endgroup

    ##
    # @group Queries

    ##
    # @param [String] path
    #  The path to a file
    # @return [Boolean]
    #  Returns true when a feature is enabled
    def enabled?(path)
      status(path) == :enabled
    end

    ##
    # @param [String] path
    #  The path to a file.
    # @return [Boolean]
    #  Returns true when a feature is disabled
    def disabled?(path)
      status(path) == :disabled
    end

    ##
    # @param [String] path
    #  The path to a file
    # @return [Boolean]
    #  Returns true when the system default setting is used
    def sysdef?(path)
      status(path) == :sysdef
    end

    ##
    # @param [String] path
    #  The path to a file
    # @return [Boolean]
    #  Returns true when a feature is in an invalid state
    #  (eg: the feature is both enabled and disabled at the same time)
    def invalid?(path)
      status(path) == :invalid
    end

    ##
    # @!method status(path)
    #   @param [String] path
    #     The path to a file
    #   @raise [SystemCallError]
    #     Might raise a number of Errno exceptions
    #   @return [Symbol]
    #     Returns the status of a feature for a given file.
    #     Status could be: `:unknown`, `:enabled`, `:disabled`,
    #     `:sysdef`, or `:invalid`.

    # @endgroup

    ##
    # @group Predicates

    ##
    # @return [Boolean]
    #  Returns true for `pageexec`
    def pageexec?
      name == "pageexec"
    end

    ##
    # @return [Boolean]
    #  Returns true for `mprotect`
    def mprotect?
      name == "mprotect"
    end

    ##
    # @return [Boolean]
    #  Returns true for `segvguard`
    def segvguard?
      name == "segvguard"
    end

    ##
    # @return [Boolean]
    #  Returns true for `aslr`
    def aslr?
      name == "aslr"
    end

    ##
    # @return [Boolean]
    #  Returns true for `shlibrandom`
    def shlibrandom?
      name == "shlibrandom"
    end

    ##
    # @return [Boolean]
    #  Returns true for `disallow_map32bit`
    def disallow_map32bit?
      name == "disallow_map32bit"
    end

    ##
    # @return [Boolean]
    #  Returns true for `insecure_kmod`
    def insecure_kmod?
      name == "insecure_kmod"
    end

    ##
    # @return [Boolean]
    #  Returns true for `harden_shm`
    def harden_shm?
      name == "harden_shm"
    end

    ##
    # @return [Boolean]
    #  Returns true for `prohibit_ptrace_capsicum`
    def prohibit_ptrace_capsicum?
      name == "prohibit_ptrace_capsicum"
    end

    # @endgroup
  end
end
