require 'spec_helper'

RSpec.describe Dms::Web do
  let(:valid_json) do
    {
      'data' => {
        'donation' => {
          'amount' => 20.00,
          'currency' => 'GBP',
          'startDate' => '12/12/2009',
          'endDate' => '12/12/2019',
          'donationType' => 'one-off',
          'zakat' => 'no'
        },
        'cause' => {
          'project' => 'SUDAN',
          'causeCode' => 'FOOD'
        },
        'donor' => {
          'email' => 'hamza@khan-cheema.com',
          'firstName' => 'Hamza',
          'lastName' => 'Khan'
        }
      }
    }.to_json
  end

  let(:expected_json_api_response) do
    {
      'data' => {
        'id' => parsed_donation_id,
        'type' => 'donations',
        'attributes' => {
          'amount' => 20,
          'currency' => 'GBP',
          'zakat' => false,
          'start_date' => nil,
          'end_date' => nil,
          'donation_type' => 'monthly'
        },
        'relationships' => {
          'donor' => {
            'links' => {
              "self" => "http://example.com/donations/#{parsed_donation_id}/relationships/donor",
              "related" => "http://example.com/donations/#{parsed_donation_id}/donor"
            },
            'data' => { 'type' => 'people', 'id' => parsed_donor_id }
          }
        }
      }
    }
  end

  context 'with valid input' do
    before do
      post_with_json('/donations', valid_json)
    end

    it 'returns a successful response' do
      expect last_response.ok?
    end

    it 'returns a 202 http status' do
      expect last_response.status == 202
    end

    it 'returns expected json-api response' do
      expect(parsed_response).to eq expected_json_api_response
    end

    it 'creates donation' do
      expect(parsed_donation_id).to_not be_nil
    end

    it 'creates donor' do
      expect(parsed_donor_id).to_not be_nil
    end
  end

  context "when invalid" do
    let(:invalid_json) do
      {
        'data' => {}
      }.to_json
    end

    before do
      post_with_json('/donations', invalid_json)
    end

    it 'errors on donation and donor fields' do
      expect(parsed_response.fetch('donation')).to include('is missing')
      expect(parsed_response.fetch('donor')).to include('is missing')
    end

    it 'returns a 400' do
      expect last_response.status == 400
    end
  end

  def parsed_response
    JSON.parse(last_response.body)
  end

  def parsed_donation_id
    parsed_response.dig('data', 'id')
  end

  def parsed_donor_id
    parsed_response.dig('data', 'relationships', 'donor', 'data', 'id')
  end

  def post_with_json(uri, json)
    post(uri, json, 'CONTENT_TYPE' => 'application/json')
  end
end
