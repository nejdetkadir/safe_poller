# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SafePoller::Base do
  let(:poller) { SafePoller::Base.new(interval: 0.1) {} }

  describe '#start' do
    it 'executes the block repeatedly' do
      counter = 0

      poller.instance_variable_set(:@block, proc { counter += 1 })

      poller.start
      sleep 0.5
      poller.stop

      expect(counter).to be >= 4
    end

    it 'stops when until option is reached' do
      counter = 0

      poller.instance_variable_set(:@until, Time.now + 0.3)
      poller.instance_variable_set(:@block, proc { counter += 1 })

      poller.start
      sleep 0.5

      expect(counter).to be <= 3
    end

    it 'stops when stop method is called' do
      counter = 0

      poller.instance_variable_set(:@block, proc { counter += 1 })

      poller.start
      sleep 0.5
      poller.stop

      expect(counter).to be >= 4
    end

    it 'pauses and resumes when pause and resume methods are called' do
      counter = 0

      poller.instance_variable_set(:@block, proc { counter += 1 })

      poller.start
      sleep 0.2
      poller.pause
      sleep 0.2
      poller.resume
      sleep 0.2
      poller.stop

      expect(counter).to be >= 2
    end
  end

  describe '#running?' do
    it 'returns true when poller is running' do
      poller.start

      expect(poller.running?).to eq(true)

      poller.stop
    end

    it 'returns false when poller is stopped' do
      poller.start
      poller.stop

      expect(poller.running?).to eq(false)
    end
  end

  describe '#paused?' do
    it 'returns true when poller is paused' do
      poller.start
      poller.pause

      expect(poller.paused?).to eq(true)

      poller.stop
    end

    it 'returns false when poller is not paused' do
      poller.start

      expect(poller.paused?).to eq(false)

      poller.stop
    end
  end
end
