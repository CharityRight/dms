require 'spec_helper'
# TODO: Add when cause does not exist context

RSpec.describe Dms::Web do
  describe 'PUT /projects' do
    context 'when valid' do
      context "when cause exists" do
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
                'targetTotal' => 10000,
                'zakat' => true,
                'projectCode' => project_code
              }
            }
          }.to_json
        end

        let(:expected_json_api_response) do
          {
            'data' => {
              'id' => project_code,
              'type' => 'projects',
              'attributes' => {
                'name' => updated_name,
                'description' => updated_description,
                'projectCode' => project_code,
                'active' => true,
                'location' => 'SUDAN CAMP',
                'latitude' => '22222',
                'longitude' => '33333',
                'targetTotal' => 10000,
                'zakat' => true
              },
              'relationships' => {
                'cause' => {
                  'links' => {
                    "self" => "http://example.com/causes/#{parsed_cause_id}/relationships/cause",
                    "related" => "http://example.com/causes/#{parsed_cause_id}/cause"
                  },
                  'data' => { 'type' => 'cause', 'id' => parsed_cause_id}
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

        let(:update_payload) do
          create_json.merge(updated_attributes)
        end

        let(:updated_attributes) do
          {
            'data' => {
              'project' => {
                'name' => updated_name,
                'description' => updated_description
              }
            }
          }.to_json
        end

        let(:updated_name) { 'Updated Name' }
        let(:updated_description) { 'Updated Description' }
        let(:project_code) { 'SCHOOL_1' }

        before do
          post_with_json('/causes', create_cause_json)
          post_with_json('/projects', valid_json)
          put_with_json("/projects/#{project_code}", updated_attributes)
        end

        it 'returns a successful response' do
          expect(last_response.status).to eq 200
        end

        it 'returns expected json-api response' do
          expect(parsed_response).to eq expected_json_api_response
        end
      end
    end

    def parsed_cause_id
      parsed_response.dig 'data', 'relationships', 'cause', 'data', 'id'
    end
  end
end
