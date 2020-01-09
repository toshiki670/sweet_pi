# frozen_string_literal: true
require 'sweet_pi/model/math'

module SweetPi
  class PrevFactorial
    using SweetPi::Math::Factorial

    def initialize
      @prev_value = 1
      @prev_result = 1
    end

    def calc(value)
      raise ArgumentError unless value.is_a?(Integer) and 0 <= value

      if @prev_value + 1 == value
        @prev_result *= value

      elsif @prev_value < value
        @prev_result *= ((@prev_value + 1)..value).reduce(1, :*)

      elsif @prev_value > value 
        @prev_result = value.!

      end

      @prev_value = value
      @prev_result
    end
  end
end
