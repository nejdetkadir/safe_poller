# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SafePoller do
  describe '.poll' do
    it 'runs the block periodically' do
      count = 0
      interval = 0.1

      poller = SafePoller.poll(interval: interval) do
        count += 1
      end

      sleep interval * 3

      expect(count).to be_within(1).of(3)

      poller.stop
    end

    it 'returns a SafePoller::Base instance' do
      poller = SafePoller.poll {}

      expect(poller).to be_instance_of(SafePoller::Base)

      poller.stop
    end
  end

  describe '.poll_until' do
    it 'runs the block periodically until a specified time' do
      start_time = Time.now
      end_time = start_time + 0.3

      count = 0
      interval = 0.1

      poller = SafePoller.poll_until(end_time, interval: interval) do
        count += 1
      end

      sleep interval * 3

      expect(count).to be_within(1).of(3)
      expect(Time.now).to be >= end_time

      poller.stop
    end

    it 'returns a SafePoller::Base instance' do
      poller = SafePoller.poll_until(Time.now) {}

      expect(poller).to be_instance_of(SafePoller::Base)

      poller.stop
    end
  end

  describe '.poll_for' do
    it 'runs the block periodically for a specified duration' do
      duration = 0.3

      count = 0
      interval = 0.1

      poller = SafePoller.poll_for(duration, interval: interval) do
        count += 1
      end

      sleep interval * 3

      expect(count).to be_within(1).of(3)

      poller.stop
    end

    it 'returns a SafePoller::Base instance' do
      poller = SafePoller.poll_for(0, interval: 1) {}

      expect(poller).to be_instance_of(SafePoller::Base)

      poller.stop
    end
  end
end
