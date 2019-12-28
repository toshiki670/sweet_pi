# frozen_string_literal: true
require 'bigdecimal'
require 'bigdecimal/util'
require 'sweet_pi/model/math'

module SweetPi
  class Chudnovsky
    A = 13591409.freeze
    B = 545140134.freeze
    C = 640320.freeze

    DIGIT_PER_ACCURACY = 14.1816474627.freeze
    private_constant :A, :B, :C, :DIGIT_PER_ACCURACY

    using SweetPi::Math::Factorial

    def initialize(thread = 1)
      @thread = thread
    end

    private

    def single_thread(digit)
      accuracy = calc_accuracy(digit)

      sum = SweetPi::Math.sum(0, accuracy) do |k|
        Rational(numerator(k), denominator(k))
      end

      '1.0'.to_d / (12 * sum)
    end

    def multi_thread(digit)

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

    # WIP インデックスを往復
    # もし、一方向にxを配置した場合、最初と最後の配列に以下のような差が発生する
    # 配置する数値の最大をMAXとする
    #
    def round_trip(x, idx)
      if x / idx % 2 == 0
        x % idx
      else
        (idx - 1) - x % idx
      end
    end

  end
end
