# frozen_string_literal: true

module SafePoller
  class Base
    def initialize(**options, &block)
      @block = block
      @running = false
      @paused = false
      @thread = nil
      @mutex = Mutex.new
      @pause_cv = ConditionVariable.new
      @interval = options.fetch(:interval, 1.0)
      @until = options.fetch(:until, nil)
    end

    def start
      return if @running

      @running = true

      @thread = Thread.new do
        loop do
          @mutex.synchronize do
            @pause_cv.wait(@mutex) if @paused
          end

          break unless @running
          break if @until && Time.now >= @until

          @block.call

          sleep @interval
        end
      end
    end

    def stop
      return unless @running

      @mutex.synchronize do
        @running = false
        @paused = false
        @pause_cv.signal
      end

      @thread.join
      @thread = nil
    end

    def pause
      return unless @running

      @mutex.synchronize do
        @paused = true
      end
    end

    def resume
      return unless @running

      @mutex.synchronize do
        @paused = false
        @pause_cv.signal
      end
    end

    def running?
      @running
    end

    def paused?
      @paused
    end
  end
end
