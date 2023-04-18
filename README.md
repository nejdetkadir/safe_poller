[![Gem Version](https://badge.fury.io/rb/safe_poller.svg)](https://badge.fury.io/rb/safe_poller)
![test](https://github.com/nejdetkadir/safe_poller/actions/workflows/test.yml/badge.svg?branch=main)
![rubocop](https://github.com/nejdetkadir/safe_poller/actions/workflows/rubocop.yml/badge.svg?branch=main)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version->=_2.7.0-blue.svg)

# Safe Poller

SafePoller is a Ruby gem that provides a safe and reliable way to perform periodic polling operations in multi-threaded environments. It offers a simple and intuitive API for running a block of code at a defined interval, while ensuring thread safety and preventing potential race conditions. SafePoller allows developers to focus on implementing their logic without worrying about thread safety issues.


## Installation

Install the gem and add to the application's Gemfile by executing:
```bash
$ bundle add safe_poller
```

Or add the following line to the application's Gemfile:
```ruby
gem 'safe_poller', github: 'nejdetkadir/safe_poller', branch: 'main'
```

If bundler is not being used to manage dependencies, install the gem by executing:
```bash
gem install safe_poller
```


## Usage

To use SafePoller, simply call the `SafePoller.poll` method, passing in a block of code to be executed at the specified interval:
```ruby
poller = SafePoller.poll(interval: 2.0) do
  # Code to be executed at 2-second intervals
end
```

By default, the interval is set to 1 second. You can also specify the duration of the poll by using the `SafePoller.poll_for` method:
```ruby
poller = SafePoller.poll_for(30, interval: 2.0) do
  # Code to be executed every 2 seconds for 30 seconds
end
```

Or, you can specify the end time of the poll using the `SafePoller.poll_until` method:
```ruby
end_time = Time.now + 60
poller = SafePoller.poll_until(end_time, interval: 2.0) do
  # Code to be executed every 2 seconds until 1 minute from now
end
```

You can pause and resume the poller using the `pause` and `resume` methods, respectively:
```ruby
poller.pause # Pauses the poller
poller.resume # Resumes the poller
```

You can check if the poller is currently running or paused using the `running?` and `paused?` methods, respectively:
```ruby
poller.running? # Returns true if the poller is running, false otherwise
poller.paused? # Returns true if the poller is paused, false otherwise
```

You can stop the poller using the `stop` method:
```ruby
poller.stop # Stops the poller
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nejdetkadir/safe_poller. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nejdetkadir/safe_poller/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).

## Code of Conduct

Everyone interacting in the SafePoller project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nejdetkadir/safe_poller/blob/main/CODE_OF_CONDUCT.md).
