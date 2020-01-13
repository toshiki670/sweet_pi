# frozen_string_literal: true
require 'sweet_pi/version'
require 'sweet_pi/runner'
require 'sweet_pi/pi'

require 'bigdecimal'
require 'bigdecimal/util'


module SweetPi
  class Generator

    def initialize(process_size = 1)
      raise ArgumentError unless process_size.is_a?(Integer) and 1 <= process_size
      @pi = SweetPi::PI.new(process_size)

      @from = 0
      @to = 2
    end

    def range(from = 0, to)
      @from = from
      @to = to
      self
    end

    def calc
      @value = @pi.calc(@to)
      self
    end

    def each_char
      self.calc.to_s.each_char do |c|
        yield c
      end

      self
    end

    def to_s
      from = @from + 1 if 1 <= @from
      to = @to + 2

      @value ||= Math::PI.to_d
      @value.to_s('f')[from..to]
    end
  end
end
