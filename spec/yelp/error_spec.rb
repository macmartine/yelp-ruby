require 'spec_helper'

describe YelpFusion::Error do
  context 'from_request' do
    let(:response_body) { '{"error": {"text": "error message", "id": "INTERNAL_ERROR"}}' }
    let(:good_response) { double('response', status: 200) }
    let(:bad_response)  { double('response', status: 400, body: response_body) }

    it 'should not raise an error' do
      expect {
        YelpFusion::Error.check_for_error(good_response)
      }.to_not raise_error
    end

    it 'should raise an internal error' do
      expect {
        YelpFusion::Error.check_for_error(bad_response)
      }.to raise_error(YelpFusion::Error::InternalError)
    end
  end

  context 'invalid parameter' do 
    let(:response_body) { '{"error": {"text": "One or more parameters are invalid in request", "id": "INVALID_PARAMETER", "field": "oauth_token"}}' }
    let(:bad_response)  { double('response', status: 400, body: response_body) }

    it 'should raise an invalid response error' do 
      expect {
        YelpFusion::Error.check_for_error(bad_response)
      }.to raise_error(YelpFusion::Error::InvalidParameter)
    end

    it 'should expose the field parameter' do 
      begin
        YelpFusion::Error.check_for_error(bad_response)
      rescue YelpFusion::Error::InvalidParameter => e 
        # verifies that StandardError message attribute is available
        expect(e.message).to eq('One or more parameters are invalid in request: oauth_token')
        # verifies that we can get access to the specific field that was invalid
        expect(e.field).to eq('oauth_token')
      end        
    end

  end
end
