require 'spec_helper'

describe YelpFusion do
  describe '::client' do
    subject { YelpFusion.client }

    it { is_expected.to be_a YelpFusion::Client }
    its(:configuration) { is_expected.to be nil }
  end
end
