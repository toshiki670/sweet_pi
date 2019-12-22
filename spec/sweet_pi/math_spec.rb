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
        expect(100.!).to eq(93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000)
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
        expect{10.!(-1)}.to raise_error('ArgumentError')
      end

      it "isn't Integer" do
        expect{10.!('2')}.to raise_error('ArgumentError')
        expect{10.!(1.5)}.to raise_error('ArgumentError')
      end
    end
  end
end

