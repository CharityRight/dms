require 'spec_helper'

RSpec.describe Dms::Web do

  describe 'POST /projects' do
    context 'when valid' do
      let(:valid_json) do
        {
          'data' => {
            'project' => {
              'name' => 'New Projcet',
              'description' => 'Description of the project',
              'causeCode' => 'SUDAN',
              'active' => true,
              'location' => 'SUDAN CAMP',
              'latitude' => '22222',
              'longitude' => '33333',
              'targetTotal' => '10000',
              'zakat' => true,
              'projectCode' => ' School-1'
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
              'code' => 'School-1',
              'active' => true,
              'location' => 'SUDAN CAMP',
              'latitude' => '22222',
              'longitude' => '33333',
              'targetTotal' => '10000',
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

      before { post_with_json('/projects', valid_json) }

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

    context "when invalid" do
      let(:invalid_json) do
        {
          'data' => {}
        }.to_json
      end

      before { post_with_json('/projects', invalid_json) }

      it 'errors on cause fields' do
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
