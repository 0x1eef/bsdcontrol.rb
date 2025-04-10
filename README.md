## About

bsdcontrol.rb provides Ruby bindings for
[libhbsdcontrol](https://git.hardenedbsd.org/hardenedbsd/HardenedBSD/-/tree/hardened/current/master/lib/libhbsdcontrol/).

## Examples

### BSD::Control

#### Features

The following example prints a list of HardenedBSD features that
can be enabled, disabled or restored to the system default
setting:

``` ruby
#!/usr/bin/env ruby
# Required privileges: user, superuser
require "bsdcontrol"
BSD::Control
  .available_features
  .each do
  print "The ", _1.name, " feature is available", "\n"
end
```

#### Enable

The next example enables the mprotect feature for the emacs binary. When
a feature is enabled for a given file, that setting takes precendence
over the system default. The system default can be restored with
[BSD::Control::Feature#sysdef!](http://0x1eef.github.io/x/bsdcontrol.rb/BSD/Control/Feature.html#sysdef!-instance_method):

``` ruby
#!/usr/bin/env ruby
# Required privileges: superuser
require "bsdcontrol"
BSD::Control
  .feature(:mprotect)
  .enable! File.realpath("/usr/local/bin/emacs")
```

#### Status

There are five recognized statuses: `unknown`, `enabled`, `disabled`,
`sysdef`, and `invalid`. The `sysdef` status indicates that a feature
is configured to use the system default, and it is the most common
status:

``` ruby
#!/usr/bin/env ruby
# Required privileges: superuser
require "bsdcontrol"
BSD::Control
  .feature(:mprotect)
  .status("/bin/ls") # => :sysdef
```

#### Namespaces

The libhbsdcontrol library is implemented via extended attribute namespaces
(see [extattr(2)](https://man.freebsd.org/extattr)), and the default namespace
is the "system" namespace. The "system" namespace requires root privileges if
you want to modify or read attributes, but the "user" namespace can be accessed by
unprivileged users.

At the moment the HardenedBSD kernel works purely with the system namespace, but
there are plans to add support for the user namespace in the future. Switching between
namespaces can be achieved with the [BSD::Control::Feature#set_namespace](http://0x1eef.github.io/x/bsdcontrol.rb/BSD/Control/Feature.html#namespace=-instance_method)
method:

``` ruby
#!/usr/bin/env ruby
# Required privileges: user
require "bsdcontrol"
BSD::Control.set_namespace(:user)
BSD::Control["mprotect"].status("/bin/ls") # => :sysdef
```

## Documentation

A complete API reference is available at
[0x1eef.github.io/x/bsdcontrol.rb](https://0x1eef.github.io/x/bsdcontrol.rb)

## Install

bsdcontrol.rb can be installed via rubygems.org:

    gem install bsdcontrol.rb

## Sources

* [GitHub](https://github.com/0x1eef/bsdcontrol.rb)
* [GitLab](https://gitlab.com/0x1eef/bsdcontrol.rb)
* [git.HardenedBSD.org/@0x1eef](https://git.HardenedBSD.org/0x1eef/bsdcontrol.rb)
* [brew.bsd.cafe/@0x1eef](https://brew.bsd.cafe/0x1eef/bsdcontrol.rb)

## License

[BSD Zero Clause](https://choosealicense.com/licenses/0bsd/)
<br>
See [LICENSE](./LICENSE)
