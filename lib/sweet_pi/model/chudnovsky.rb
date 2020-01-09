# frozen_string_literal: true
require 'bigdecimal'
require 'bigdecimal/util'
require 'sweet_pi/model/math'
require 'sweet_pi/model/child_process'

module SweetPi
  class Chudnovsky
    A = 13591409.freeze
    B = 545140134.freeze
    C = 640320.freeze

    DIGIT_PER_ACCURACY = 14.1816474627.freeze
    private_constant :A, :B, :C, :DIGIT_PER_ACCURACY

    using SweetPi::Math::Factorial


    def single_process(digit)
      accuracy = calc_accuracy(digit)

      sum = SweetPi::Math.sum(0, accuracy) do |k|
        Rational(numerator(k), denominator(k))
      end

      result = '1.0'.to_d / (12 * sum)
      fix(digit, result)
    end

    def multi_process(digit, process_size)
      accuracy = calc_accuracy(digit)

      processes = []
      process_size.times do |p_n|
        processes << SweetPi::ChildProcess.new(accuracy, process_size, p_n) do |a, p_s, p_n|
          each_process(a, p_s, p_n)
        end
      end

      result = '1.0'.to_d / processes.map(&:value).reduce(:+)
      fix(digit, result)
    end

    private

    def each_process(accuracy, process_size, process_num)
      f = Proc.new do |x|
        base = process_size * x
        a = (process_size - 1) * (x % 2)
        b = process_num * (1 - (x % 2) * 2)
        base + a + b
      end

      sum = 0
      x = 0
      k = f.call(x)
      while k <= accuracy do
        sum += Rational(numerator(k), denominator(k))
        x += 1
        k = f.call(x)
      end
      12 * sum
    end

    def calc_accuracy(digit)
      (digit / DIGIT_PER_ACCURACY).ceil.to_i
    end

    def numerator(k)
      (-1)**k * (6 * k).! * (A + B * k)
    end

    def denominator(k)
      k.!**3 * (3 * k).! * C**(3 * k + '1.5'.to_d)
    end

    def fix(digit, pi)
      pi.floor(digit)
    end


  end
end
