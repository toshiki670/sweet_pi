# frozen_string_literal: true

require 'sweet_pi/pi'

require 'bigdecimal'
require 'bigdecimal/util'

module SweetPi
  class Generator
    def initialize(process_count = 1)
      @pi = SweetPi::PI.new
      @pi.process_count = process_count

      @from = 0
      @to = 2
    end

    def process_count=(count)
      @pi.process_count = count
    end

    def range(from: 0, to:)
      @from = from
      @to = to
      self
    end

    def calc
      @value = @pi.calc(@to)
      self
    end

    def each_char
      calc.to_s.each_char do |c|
        yield c
      end

      self
    end

    def to_s
      from = @from + 1 if @from >= 1
      to = @to + 2

      @value ||= Math::PI.to_d
      @value.to_s('f')[from..to]
    end
  end
end
