# frozen_string_literal: true

require 'spec_helper'

using SweetPi::Math::Factorial

RSpec.describe Math do
  describe "Factorial's" do
    context 'Single' do
      it 'is 0!' do
        expect(0.!).to eq(1)
      end

      it 'is 1!' do
        expect(1.!).to eq(1)
      end

      it 'is 100!' do
        expect(100.!).to eq(93_326_215_443_944_152_681_699_238_856_266_700_490_715_968_264_381_621_468_592_963_895_217_599_993_229_915_608_941_463_976_156_518_286_253_697_920_827_223_758_251_185_210_916_864_000_000_000_000_000_000_000_000)
      end
    end

    context 'Multi' do
      it 'is 0!!' do
        expect(0.!(2)).to eq(1)
      end

      it 'is 1!!' do
        expect(1.!(2)).to eq(1)
      end

      it 'is 9!!' do
        expect(9.!(2)).to eq(945)
      end

      it 'is 8!!' do
        expect(8.!(2)).to eq(384)
      end

      it 'is 10!!!' do
        expect(10.!(3)).to eq(280)
      end
    end

    context 'When argument' do
      it 'is minus' do
        expect { 10.!(-1) }.to raise_error('ArgumentError')
      end

      it "isn't Integer" do
        expect { 10.!('2') }.to raise_error('ArgumentError')
        expect { 10.!(1.5) }.to raise_error('ArgumentError')
      end
    end
  end
end
