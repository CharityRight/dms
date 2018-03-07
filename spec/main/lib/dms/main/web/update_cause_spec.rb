# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dms::Web do
  describe 'PUT /causes/:id' do
    context 'when valid' do
      let(:create_json) do
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
        }
      end

      let(:expected_json_api_response) do
        {
          'data' => {
            'id' => parsed_cause_id,
            'type' => 'causes',
            'attributes' => {
              'name' => updated_name,
              'description' => updated_description,
              'code' => code,
              'active' => true,
              'location' => 'SUDAN'
            }
          }
        }
      end
      let(:code) { 'FOOD' }
      let(:updated_name) { 'Updated Name' }
      let(:updated_description) { 'Updated Description' }
      let(:updated_attributes) do
        {
          'data' => {
            'cause' => {
              'name' => updated_name,
              'description' => updated_description
            }
          }
        }
      end

      let(:update_payload) do
        create_json.merge(updated_attributes)
      end

      before do
        post_with_json('/causes', create_json.to_json)
        put_with_json("/causes/#{code}", update_payload.to_json)
      end

      it 'returns a successful response' do
        expect(last_response.status).to eq 200
      end

      it 'returns expected json-api response' do
        expect(parsed_response).to eq expected_json_api_response
      end
    end

    context 'when invalid' do
      let(:invalid_json) do
        {
          'data' => {}
        }.to_json
      end

      before { post_with_json('/causes', invalid_json) }

      it 'errors on cause fields' do
        expect(parsed_response.fetch('cause')).to include('is missing')
      end

      it 'returns a 400' do
        expect last_response.status == 400
      end
    end

    def parsed_cause_id
      parsed_response.dig('data', 'id')
    end
  end
end
