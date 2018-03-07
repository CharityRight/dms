# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dms::Web do
  describe 'GET /causes' do
    let(:valid_json) do
      {
        'data' => {
          'cause' => {
            'name' => 'New Cause',
            'description' => 'Description of the cause',
            'code' => 'FOOD',
            'active' => true,
            'location' => 'SUDAN'
          }
        }
      }.to_json
    end

    let(:expected_json_api_response) do
      [{
        'data' => {
          'id' => first_parsed_cause_id,
          'type' => 'causes',
          'attributes' => {
            'name' => 'New Cause',
            'description' => 'Description of the cause',
            'code' => 'FOOD',
            'active' => true,
            'location' => 'SUDAN'
          }
        }
      }]
    end

    before do
      post_with_json('/causes', valid_json)
    end

    it 'returns expected collection of causes' do
      get('causes')
      expect(parsed_response).to eq(expected_json_api_response)
    end

    it 'returns correct amount of causes' do
      post_with_json('/causes', valid_json)
      get('causes')
      expect(parsed_response.size).to eq 2
    end

    def first_parsed_cause_id
      parsed_response.first.dig('data', 'id')
    end
  end
end
