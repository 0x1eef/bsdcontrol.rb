## About

hbsdctl.rb is a Ruby C extension that binds libhbsdcontrol from the
[hardenedbsd](https://hardenedbsd.org) project. Through this library,
you can query what features are available and if root, enable or disable
those features for given binaries.

## Examples

__Available features__

As a regular user account, you can obtain a list of available features.
But to enable or disable those features a superuser account is required:

``` ruby
#!/usr/bin/env ruby
# As a regular user account
require 'hbsdctl'
BSD::Control
  .available_features
  .each do
  print "The ", _1.name, " feature is available", "\n"
end
```

__Enable feature__

As a superuser account, you can enable or disable features for a given executable.
The example enables the mprotect feature for the emacs binary:

``` ruby
#!/usr/bin/env ruby
# As a root account
require 'hbsdctl'
BSD::Control
  .feature!("mprotect")
  .enable!("/usr/local/bin/emacs")
```

## License

[BSD Zero Clause](https://choosealicense.com/licenses/0bsd/).
<br>
See [LICENSE](./LICENSE).

