# frozen_string_literal: true

module SweetPi
  module Math

    # using SweetPi::Math::Fractorial
    module Factorial
      refine Integer do
        def single_fact
          (1..self).reduce(1, :*)
        end
        alias_method :!, :single_fact

        def doable_fact
          sum = 1
          self.downto(2).each_with_index do |n, idx|
            next if idx % 2 != 0
            sum *= n
          end
          sum
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
