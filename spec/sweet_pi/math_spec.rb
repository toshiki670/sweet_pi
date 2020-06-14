# frozen_string_literal: true

require 'spec_helper'

using SweetPi::Math::Factorial

RSpec.describe Math do
  describe "Factorial's" do
    context 'Single' do
      subject { num.! }
      context 'when 0!' do
        let(:num) { 0 }
        it { is_expected.to eq(1) }
      end
      context 'when 1!' do
        let(:num) { 1 }
        it { is_expected.to eq(1) }
      end
      context 'when 100!' do
        let(:num) { 100 }
        it { is_expected.to eq(93_326_215_443_944_152_681_699_238_856_266_700_490_715_968_264_381_621_468_592_963_895_217_599_993_229_915_608_941_463_976_156_518_286_253_697_920_827_223_758_251_185_210_916_864_000_000_000_000_000_000_000_000) }
      end
    end

    context 'Multi' do
      subject { num.!(multi) }
      let(:multi) { 2 }
      context 'when 0!!' do
        let(:num) { 0 }
        it { is_expected.to eq(1) }
      end
      context 'when 1!!' do
        let(:num) { 1 }
        it { is_expected.to eq(1) }
      end
      context 'when 9!!' do
        let(:num) { 9 }
        it { is_expected.to eq(945) }
      end
      context 'when 8!!' do
        let(:num) { 8 }
        it { is_expected.to eq(384) }
      end
      context 'when 10!!!' do
        let(:num) { 10 }
        let(:multi) { 3 }
        it { is_expected.to eq(280) }
      end
    end

    context 'When argument' do
      subject { -> { num.!(multi) } }
      let(:num) { 10 }
      context 'when minus' do
        let(:multi) { -1 }
        it { is_expected.to raise_error('ArgumentError') }
      end
      context 'when String' do
        let(:multi) { 'String' }
        it { is_expected.to raise_error('ArgumentError') }
      end
      context 'when Float' do
        let(:multi) { 1.5 }
        it { is_expected.to raise_error('ArgumentError') }
      end
    end
  end
end
