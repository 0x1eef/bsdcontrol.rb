## About

bsdcontrol.rb provides Ruby bindings for libhbsdcontrol from the
[hardenedbsd](https://hardenedbsd.org) project. Through
this library, you can query what features are available and if
root: enable, disable or query the status of a feature for a
given file.

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
The example enables the mprotect feature for the emacs binary:

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
There are four statuses that can be returned: `conflict`, `sysdef`,
`enabled`, and `disabled`. The first status (conflict) is rare and indicates that a
feature is both enabled and disabled. The other three are more common. The `sysdef`
status indicates that a feature takes its settings from the system default (sysctl):

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

