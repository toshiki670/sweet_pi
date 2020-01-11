# frozen_string_literal: true
require 'bigdecimal'
require 'bigdecimal/util'
require 'sweet_pi/model/math'
require 'sweet_pi/model/child_process'
require 'sweet_pi/model/prev_factorial'

module SweetPi
  class Chudnovsky
    A = 13591409.freeze
    B = 545140134.freeze
    C = 640320.freeze

    DIGIT_PER_ACCURACY = 14.1816474627.freeze
    private_constant :A, :B, :C, :DIGIT_PER_ACCURACY

    using SweetPi::Math::Factorial


    def single_process2(digit)
      accuracy = calc_accuracy(digit)

      fact_1 = SweetPi::PrevFactorial.new
      fact_3 = SweetPi::PrevFactorial.new
      fact_6 = SweetPi::PrevFactorial.new
      sum = SweetPi::Math.sum(0, accuracy) do |k|
        Rational(numerator2(k, fact_6), denominator2(k, fact_1, fact_3))
      end

      result = '1.0'.to_d / (12 * sum)
      fix(digit, result)
    end

    def single_process(digit)
      accuracy = calc_accuracy(digit)

      sum = SweetPi::Math.sum(0, accuracy) do |k|
        Rational(numerator(k), denominator(k))
      end

      result = '1.0'.to_d / (12 * sum)
      fix(digit, result)
    end

    def multi_process2(digit, process_size)
      accuracy = calc_accuracy(digit)

      processes = []
      process_size.times do |p_n|
        processes << SweetPi::ChildProcess.new(accuracy, process_size, p_n) do |a, p_s, p_n|
          each_process2(a, p_s, p_n)
        end
      end

      result = '1.0'.to_d / processes.map(&:value).reduce(:+)
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

    def each_process2(accuracy, process_size, process_num)
      fact_1 = SweetPi::PrevFactorial.new
      fact_3 = SweetPi::PrevFactorial.new
      fact_6 = SweetPi::PrevFactorial.new

      base = accuracy / process_size
      mod = accuracy % process_size

      first = base * process_num
      last = base * (process_num + 1) - 1

      if process_num < mod
        first += process_num
        last += process_num + 1
      else
        first += mod
        last += mod
      end

      sum = SweetPi::Math.sum(first, last) do |k|
        Rational(numerator2(k, fact_6), denominator2(k, fact_1, fact_3))
      end
      12 * sum
    end

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

    def numerator2(k, fact_6)
      (-1)**k * fact_6.calc(6 * k) * (A + B * k)
    end

    def denominator2(k, fact_1, fact_3)
      fact_1.calc(k)**3 * fact_3.calc(3 * k) * C**(3 * k + '1.5'.to_d)
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
