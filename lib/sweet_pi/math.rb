# frozen_string_literal: true

module SweetPi
  module Math

    # using SweetPi::Math::Factorial
    module Factorial
      refine Integer do

        def !(step = 1)
          raise ArgumentError unless step.is_a?(Integer) and 1 <= step

          if step == 1
            (1..self).reduce(1, :*)
          else
            sum = 1
            self.downto(2).each_with_index do |n, idx|
              next if idx % step != 0
              sum *= n
            end
            sum
          end
        end
      end
    end

    # Summation
    def self.sum(first, last)
      sum = 0
      first.upto(last) { |k| sum += yield(k) }
      sum
    end
  end
end
