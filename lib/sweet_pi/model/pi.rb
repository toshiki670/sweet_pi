# frozen_string_literal: true
require 'sweet_pi/model/chudnovsky'

module SweetPi
  class PI

    def initialize(thread_size = 1)
      raise ArgumentError unless thread_size.is_a?(Integer) and 1 <= thread_size
      @thread_size = thread_size

      @algorithm = SweetPi::Chudnovsky.new
    end

    def calc(digit)
      if @thread_size == 1
        @algorithm.single_thread(digit)
      else
        @algorithm.multi_thread(digit, @thread_size)
      end
    end
  end
end
