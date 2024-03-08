module BSD::Control
  class Feature < Struct.new(:name, :enable, :disable)
    ##
    # @return [Array<BSD::Control::Feature>]
    #   Returns an array of available features.
    def self.available
      BSD::Control::FFI.available_features
    end

    ##
    # @group Actions

    ##
    # Enables a feature for a given file.
    #
    # @param [String] path
    #  The path to a file.
    #
    # @raise [BSD::Control::Error]
    #  When the operation fails.
    #
    # @return [Boolean]
    #  Returns true on success.
    def enable!(path)
      set!(path, BSD::Control::Enable)
    end

    ##
    # Disables a feature for a given file.
    #
    # @param [String] path
    #  The path to a file.
    #
    # @raise [BSD::Control::Error]
    #  When the operation fails.
    #
    # @return [Boolean]
    #  Returns true on success.
    def disable!(path)
      set!(path, BSD::Control::Disable)
    end

    ##
    # Restore system defaults.
    #
    # @param [String] path
    #  The path to a file.
    #
    # @raise [BSD::Control::Error]
    #  When the operation fails.
    #
    # @return [Boolean]
    #  Returns true on success.
    def sysdef!(path)
      FFI.sysdef!(self, path)
    end

    ##
    # @return [Boolean]
    #  Returns true when a feature is enabled.
    def enabled?(path)
      status(path) == :enabled
    end

    ##
    # @return [Boolean]
    #  Returns true when a feature is disabled.
    def disabled?(path)
      status(path) == :disabled
    end

    ##
    # @return [Boolean]
    #  Returns true when a feature is configured to use the system default.
    def sysdef?(path)
      status(path) == :sysdef
    end

    ##
    # @return [Boolean]
    #  Returns true when a feature is in conflict
    #  (i.e: the feature is both enabled and disabled at the same time).
    def conflict?(path)
      status(path) == :conflict
    end

    ##
    # @param [String] path
    #  The path to a file.
    # @return [Symbol]
    #  Returns the feature status of a file.
    #  Status can be one of: `:conflict`, `:sysdef`, `:enabled`, `:disabled`.
    def status(path)
      FFI.status(self, path)
    rescue Errno::ENOATTR
      :sysdef
    end

    # @endgroup

    ##
    # @group Predicates

    ##
    # @return [Boolean]
    #  Returns true for the pageexec feature.
    def pageexec?
      name == "pageexec"
    end

    ##
    # @return [Boolean]
    #  Returns true for the mprotect feature.
    def mprotect?
      name == "mprotect"
    end

    ##
    # @return [Boolean]
    #  Returns true for the segv-guard feature.
    def segvguard?
      name == "segvguard"
    end

    ##
    # @return [Boolean]
    #  Returns true for the ASLR feature.
    def aslr?
      name == "aslr"
    end

    ##
    # @return [Boolean]
    #  Returns true for the shlibrandom feature.
    def shlibrandom?
      name == "shlibrandom"
    end

    ##
    # @return [Boolean]
    #  Returns true for the disallow-map32bit feature.
    def disallow_map32bit?
      name == "disallow_map32bit"
    end

    ##
    # @return [Boolean]
    #  Returns true for the insecure kmod feature.
    def insecure_kmod?
      name == "insecure_kmod"
    end

    ##
    # @return [Boolean]
    #  Returns true for the harden SHM feature.
    def harden_shm?
      name == "harden_shm"
    end

    ##
    # @return [Boolean]
    #  Returns true for the prohibit ptrace capsicum feature.
    def prohibit_ptrace_capsicum?
      name == "prohibit_ptrace_capsicum"
    end

    # @endgroup
  end
end
