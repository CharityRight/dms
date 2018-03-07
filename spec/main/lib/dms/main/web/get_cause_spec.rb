# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dms::Web do
  describe 'GET /causes/:code' do
    let(:code) { 'FOOD' }
    let(:valid_json) do
      {
        'data' => {
          'cause' => {
            'name' => 'New Cause',
            'description' => 'Description of the cause',
            'code' => code,
            'active' => true,
            'location' => 'SUDAN'
          }
        }
      }.to_json
    end

    let(:expected_json_api_response) do
      {
        'data' => {
          'id' => parsed_cause_id,
          'type' => 'causes',
          'attributes' => {
            'name' => 'New Cause',
            'description' => 'Description of the cause',
            'code' => code,
            'active' => true,
            'location' => 'SUDAN'
          }
        }
      }
    end
    context 'with valid code' do
      before do
        post_with_json('/causes', valid_json)
        get("causes/#{code}")
      end

      it 'returns expected causes' do
        expect(parsed_response).to eq(expected_json_api_response)
      end
    end

    context 'when cause does not exist' do
      let(:expected_invalid_json_response) do
        { 'errors' => "Cause #{code} not found" }
      end

      it 'returns correct response when not found' do
        get("causes/#{code}")
        expect(parsed_response).to eq(expected_invalid_json_response)
      end
    end

    def parsed_cause_id
      return unless parsed_response.key?('data')
      parsed_response.dig('data', 'id')
    end
  end
end
