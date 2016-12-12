require 'spec_helper'

describe YelpFusion::Response::Base do
  describe '#initialize' do
    let(:json) { {'a' => 10, 'b' => 20} }

    subject(:base) { YelpFusion::Response::Base.new(json) }

    it { is_expected.to be_a YelpFusion::Response::Base }

    it 'should create variables' do
      expect(base.instance_variable_get(:@a)).to eq 10
      expect(base.instance_variable_get(:@b)).to eq 20
    end

    context 'when json is nil' do
      let(:json) { nil }

      it { is_expected.to be_a YelpFusion::Response::Base }

      it 'should not have variables' do
        expect(base.instance_variable_get(:@a)).to be nil
      end
    end
  end
end
