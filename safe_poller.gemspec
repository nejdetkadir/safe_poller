# frozen_string_literal: true

require_relative 'lib/safe_poller/version'

# rubocop:disable Layout/LineLength
Gem::Specification.new do |spec|
  spec.name = 'safe_poller'
  spec.version = SafePoller::VERSION
  spec.authors = ['nejdetkadir']
  spec.email = ['nejdetkadir.550@gmail.com']

  spec.summary = "SafePoller is a thread-safe Ruby gem that simplifies the process of periodic polling.
                 It provides a reliable and efficient way to run a block of code at a set interval without the need for complex threading logic.
                 With SafePoller, developers can ensure their polling operations are safe and reliable in multi-threaded environments."
  spec.description = "SafePoller is a Ruby gem that provides a safe and reliable way to perform periodic polling operations in multi-threaded environments.
                     It offers a simple and intuitive API for running a block of code at a defined interval, while ensuring thread safety and preventing potential race conditions.
                     SafePoller allows developers to focus on implementing their logic without worrying about thread safety issues."
  spec.homepage = "https://github.com/nejdetkadir/#{spec.name}"
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
# rubocop:enable Layout/LineLength
