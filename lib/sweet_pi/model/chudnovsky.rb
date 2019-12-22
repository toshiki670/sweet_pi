# frozen_string_literal: true
require 'bigdecimal'
require 'bigdecimal/util'
require 'sweet_pi/model/math'

module SweetPi
  class Chudnovsky
    A = 13591409.freeze
    B = 545140134.freeze
    C = 640320.freeze
    private_constant :A, :B, :C

    using SweetPi::Math::Factorial

    def self.single2(accuracy)
      sum = SweetPi::Math.sum(0, accuracy) do |k|
        Rational(numerator(k), denominator(k))
      end

      '1.0'.to_d / (12 * sum)
    end

    def self.single3(accuracy)
      sum = SweetPi::Math.sum(0, accuracy) do |k|
        numerator = numerator(k)
        denominator = denominator(k)
        Rational(numerator, denominator)
      end

      '1.0'.to_d / (12 * sum)
    end



    def self.numerator(k)
      (-1)**k * (6 * k).! * (A + B * k)
    end

    def self.denominator(k)
      k.!**3 * (3 * k).! * C**(3 * k + '1.5'.to_d)
    end
    private_class_method :numerator, :denominator
  end
end
