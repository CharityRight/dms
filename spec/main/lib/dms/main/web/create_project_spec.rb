# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dms::Web do
  describe 'POST /projects' do
    context 'when valid' do
      context 'when cause exists' do
        let(:valid_json) do
          {
            'data' => {
              'project' => {
                'name' => 'New Project',
                'description' => 'Description of the project',
                'causeCode' => cause_code,
                'active' => true,
                'location' => 'SUDAN CAMP',
                'latitude' => '22222',
                'longitude' => '33333',
                'targetTotal' => 10_000,
                'zakat' => true,
                'projectCode' => 'School-1'
              }
            }
          }.to_json
        end

        let(:expected_json_api_response) do
          {
            'data' => {
              'id' => parsed_project_id,
              'type' => 'projects',
              'attributes' => {
                'name' => 'New Project',
                'description' => 'Description of the project',
                'projectCode' => 'School-1',
                'active' => true,
                'location' => 'SUDAN CAMP',
                'latitude' => '22222',
                'longitude' => '33333',
                'targetTotal' => 10_000,
                'zakat' => true
              },
              'relationships' => {
                'cause' => {
                  'links' => {
                    'self' => "http://example.com/causes/#{parsed_cause_id}/relationships/cause",
                    'related' => "http://example.com/causes/#{parsed_cause_id}/cause"
                  },
                  'data' => { 'type' => 'cause', 'id' => parsed_cause_id }
                }
              }
            }
          }
        end

        let(:cause_code) { 'FOOD' }
        let(:create_cause_json) do
          {
            'data' => {
              'cause' => {
                'name' => 'New Cause',
                'description' => 'Description of the cause',
                'code' => cause_code,
                'active' => true,
                'location' => 'SUDAN'
              }
            }
          }.to_json
        end

        before do
          post_with_json('/causes', create_cause_json)
          post_with_json('/projects', valid_json)
        end

        it 'returns a successful created response' do
          expect(last_response.status).to eq 201
        end
        it 'returns expected json-api response' do
          expect(parsed_response).to eq expected_json_api_response
        end
        it 'creates project' do
          expect(parsed_project_id).to_not be_nil
        end
        it 'creates cause' do
          expect(parsed_cause_id).to_not be_nil
        end
      end
    end

    context 'when invalid' do
      let(:invalid_json) do
        {
          'data' => {}
        }.to_json
      end

      before { post_with_json('/projects', invalid_json) }

      it 'errors on project field' do
        expect(parsed_response.fetch('project')).to include('is missing')
      end

      it 'returns a 400' do
        expect last_response.status == 400
      end
    end

    def parsed_project_id
      parsed_response.dig('data', 'id')
    end

    def parsed_cause_id
      parsed_response.dig('data', 'relationships', 'cause', 'data', 'id')
    end
  end
end
