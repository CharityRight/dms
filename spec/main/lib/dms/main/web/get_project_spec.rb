require 'spec_helper'

RSpec.describe Dms::Web do

  describe 'GET /projects/:project_code' do
    let(:project_code) { "SCHOOL_1" }
    let(:valid_json) do
      {
        'data' => {
          'project' => attributes
        }
      }.to_json
    end

    let(:attributes) do
      {
        'name' => 'New Project',
        'description' => 'Description',
        'projectCode' => project_code,
        'active' => true,
        'location' => 'SUDAN CAMP',
        'latitude' => '22222',
        'longitude' => '33333',
        'targetTotal' => 10000,
        'zakat' => true,
        'causeCode' => cause_code
      }
    end

    let(:expected_json_api_response) do
      {
        'data' => {
          'id' => project_code,
          'type' => 'projects',
          'attributes' => attributes.reject { |k, _v| k == 'causeCode' },
          'relationships' => {
            'cause' => {
              'links' => {
                "self" => "http://example.com/causes/#{cause_code}/relationships/cause",
                "related" => "http://example.com/causes/#{cause_code}/cause"
              },
              'data' => { 'type' => 'cause', 'id' => cause_code}
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

    context "with valid project code" do
      before do
        post_with_json('/causes', create_cause_json)
        post_with_json('/projects', valid_json)
        get("projects/#{project_code}")
      end

      it 'returns expected causes' do
        expect(parsed_response).to eq(expected_json_api_response)
      end
    end

    context "when project does not exist" do
      let(:project_code) { "INVALID_CODE" }
      let(:expected_invalid_json_response) do
        { 'errors' => "Project #{project_code} not found" }
      end

      it 'returns correct response when not found' do
        get("projects/#{project_code}")
        expect(parsed_response).to eq(expected_invalid_json_response)
      end
    end

    def parsed_project_id
      return unless parsed_response.key?('data')
      parsed_response.dig('data', 'id')
    end
  end
end
