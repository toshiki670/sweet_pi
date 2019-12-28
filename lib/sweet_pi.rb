# frozen_string_literal: true
require 'sweet_pi/version'
require 'sweet_pi/runner'
require 'thor'

# 実験用にRequireしているだけ
require 'sweet_pi/model/chudnovsky'
require 'sweet_pi/model/math'
require 'benchmark'


module SweetPi
  class << self

    def test1(options = {})
      @data = data
      p data
    end

    def test3
      x = 10
      y = 10

      r1 = Benchmark.realtime do
        x.times do
          SweetPi::Chudnovsky.single(y)
        end
      end

      r2 = Benchmark.realtime do
        x.times do
          SweetPi::Chudnovsky.single2(y)
        end
      end

      r3 = Benchmark.realtime do
        x.times do
          SweetPi::Chudnovsky.single3(y)
        end
      end

      p r1
      p r2
      p r3
    end

  end
end
