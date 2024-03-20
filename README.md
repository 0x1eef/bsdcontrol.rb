## About

bsdcontrol.rb provides Ruby bindings for libhbsdcontrol from the
[hardenedbsd](https://hardenedbsd.org) project. Through
this library, you can query what features are available and if
root: enable or disable a feature for a given file, or restore
the system default for a given file.

## Examples

__Features__

As an unprivileged user or as a superuser, you can obtain a list of
available features:

``` ruby
#!/usr/bin/env ruby
# Required privileges: unprivileged user or superuser.
require "hbsdctl"
BSD::Control
  .available_features
  .each do
  print "The ", _1.name, " feature is available", "\n"
end
```

__Enable__

As a superuser, you can enable or disable a feature for a given file.
The example enables the mprotect feature for the emacs binary. When
a feature is enabled for a given file, that setting takes precendence
over the system default (sysctl):

``` ruby
#!/usr/bin/env ruby
# Required privileges: superuser.
require "hbsdctl"
BSD::Control
  .feature(:mprotect)
  .enable!("/usr/local/bin/emacs-29.2")
```

__Status__

As a superuser, you can query the status of a feature for a given file.
There are five recognized statuses: `unknown`, `enabled`, `disabled`,
`sysdef`, and `invalid`. The `sysdef` status indicates that a feature takes
its settings from the system default (sysctl), and is the most common status:

``` ruby
#!/usr/bin/env ruby
# Required privileges: superuser.
require "hbsdctl"
BSD::Control
  .feature(:mprotect)
  .status("/bin/ls") # => :sysdef
```

## Documentation

A complete API reference is available at
[0x1eef.github.io/x/bsdcontrol.rb](https://0x1eef.github.io/x/bsdcontrol.rb).

## Install

**Rubygems.org**

bsdcontrol.rb can be installed via rubygems.org.

    gem install bsdcontrol.rb

## Sources

* [GitHub](https://github.com/0x1eef/bsdcontrol.rb)
* [GitLab](https://gitlab.com/0x1eef/bsdcontrol.rb)
* [git.hardenedbsd.org](https://git.hardenedbsd.org/0x1eef/bsdcontrol.rb)

## License

[BSD Zero Clause](https://choosealicense.com/licenses/0bsd/).
<br>
See [LICENSE](./LICENSE).

