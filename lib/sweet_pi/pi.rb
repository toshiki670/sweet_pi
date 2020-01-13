# frozen_string_literal: true
require 'bigdecimal'
require 'bigdecimal/util'
require 'sweet_pi/math'
require 'sweet_pi/process'

# Chudnovskyを用いたPI class
module SweetPi
  class PI
    A = 13591409.freeze
    B = 545140134.freeze
    C = 640320.freeze

    DIGIT_PER_ACCURACY = 14.1816474627.freeze
    private_constant :A, :B, :C, :DIGIT_PER_ACCURACY

    using SweetPi::Math::Factorial

    def initialize(process_size = 1)
      raise ArgumentError unless process_size.is_a?(Integer) and 1 <= process_size
      @process_size = process_size
    end

    def calc(digit)
      raise ArgumentError unless digit.is_a?(Integer) and 1 <= digit
      accuracy = calc_accuracy(digit)

      result = if @process_size == 1
        single_process(accuracy)
      else
        multi_process(accuracy, @process_size)
      end

      @prev_acc = accuracy
      @prev_result = result

      fix(digit, result)
    end

    def calc_next(digit)
      raise ArgumentError unless digit.is_a?(Integer) and 1 <= digit
      accuracy = calc_accuracy(digit)

      if @prev_result == nil
        calc(digit)
      elsif @prev_acc&.< accuracy
        result = @prev_result + single_process(@prev_acc + 1, accuracy)

        @prev_acc = accuracy
        @prev_result = result

        fix(digit, result)
      else
        fix(digit, @prev_result)
      end
    end

    private

    def single_process(prev_acc = 0, accuracy)
      sum = SweetPi::Math.sum(prev_acc, accuracy) do |k|
        Rational(numerator(k), denominator(k))
      end

      12 * sum
    end

    def multi_process(accuracy, process_size)
      processes = []
      process_size.times do |p_n|
        processes << SweetPi::Process.new(accuracy, process_size, p_n) do |a, p_s, p_n|
          each_process(a, p_s, p_n)
        end
      end

      processes.map(&:value).reduce(:+)
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

    def numerator(k)
      (-1)**k * (6 * k).! * (A + B * k)
    end

    def denominator(k)
      k.!**3 * (3 * k).! * C**(3 * k + '1.5'.to_d)
    end

    def fix(digit, pi)
      pi = '1.0'.to_d / pi
      pi.truncate(digit)
    end
  end
end
