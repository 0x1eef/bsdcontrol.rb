## About

hbsdctl.rb is a C extension that binds libhbsdcontrol from the
[hardenedbsd](https://hardenedbsd.org) project to Ruby. Through
this library, you can query what features are available and if
root: enable, disable or query the status of a feature for a
given file.

## Examples

__Features__

As a regular user account, you can obtain a list of available features:

``` ruby
#!/usr/bin/env ruby
# As a regular user account
require "hbsdctl"
BSD::Control
  .available_features
  .each do
  print "The ", _1.name, " feature is available", "\n"
end
```

__Enable__

As a superuser account, you can enable or disable a feature for a given file.
The example enables the mprotect feature for the emacs binary:

``` ruby
#!/usr/bin/env ruby
# As a superuser account
require "hbsdctl"
BSD::Control
  .feature(:mprotect)
  .enable!("/usr/local/bin/emacs-29.2")
```

__Status__

As a superuser account, you can query whether or not a feature is enabled or disabled
for a given file. There are four statuses that can be returned: `conflict`, `sysdef`,
`enabled`, and `disabled`. The first status (conflict) is rare and indicates that a
feature is both enabled and disabled. The other three are more common. The `sysdef`
status indicates that a feature takes its settings from the system default (sysctl):

``` ruby
#!/usr/bin/env ruby
# As a superuser account
require "hbsdctl"
BSD::Control
  .feature(:mprotect)
  .status("/bin/ls") # => :sysdef
```

## Documentation

A complete API reference is available at
[0x1eef.github.io/x/hbsdctl.rb](https://0x1eef.github.io/x/hbsdctl.rb).

## Install

**Rubygems.org**

hbsdctl.rb can also be installed via rubygems.org.

    gem install hbsdctl.rb

## Sources

* [GitHub](https://github.com/0x1eef/hbsdctl.rb)
* [GitLab](https://gitlab.com/0x1eef/hbsdctl.rb)
* [git.hardenedbsd.org](https://git.hardenedbsd.org/0x1eef/hbsdctl.rb)

## License

[BSD Zero Clause](https://choosealicense.com/licenses/0bsd/).
<br>
See [LICENSE](./LICENSE).

