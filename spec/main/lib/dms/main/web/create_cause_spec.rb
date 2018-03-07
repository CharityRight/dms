# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dms::Web do
  describe 'POST /causes' do
    context 'when valid' do
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
        {
          'data' => {
            'id' => parsed_cause_id,
            'type' => 'causes',
            'attributes' => {
              'name' => 'New Cause',
              'description' => 'Description of the cause',
              'code' => 'FOOD',
              'active' => true,
              'location' => 'SUDAN'
            }
          }
        }
      end

      before { post_with_json('/causes', valid_json) }

      it 'returns a successful created response' do
        expect(last_response.status).to eq 201
      end
      it 'returns expected json-api response' do
        expect(parsed_response).to eq expected_json_api_response
      end
      it 'creates cause' do
        expect(parsed_cause_id).to_not be_nil
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
