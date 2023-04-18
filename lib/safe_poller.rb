# frozen_string_literal: true

require_relative 'safe_poller/base'
require_relative 'safe_poller/version'

module SafePoller
  def self.poll(**options, &block)
    poller = SafePoller::Base.new(**options, &block)
    poller.start
    poller
  end

  def self.poll_until(until_time, **options, &block)
    options[:until] = until_time
    poll(**options, &block)
  end

  def self.poll_for(duration, **options, &block)
    options[:until] = Time.now + duration
    poll(**options, &block)
  end
end
