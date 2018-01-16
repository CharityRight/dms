require 'spec_helper'

RSpec.describe Dms::Web do
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

  describe 'POST /causes' do
    context 'when valid' do
      before do
        post_with_json('/causes', valid_json)
      end
      it 'returns a successful created response' do
        expect(last_response.status).to eq 201
      end
    end

    def post_with_json(uri, json)
      post(uri, json, 'CONTENT_TYPE' => 'application/json')
    end
  end
end
