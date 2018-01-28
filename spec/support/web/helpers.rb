module Test
  module WebHelpers
    module_function

    def app
      Dms::Web.app
    end

    def post_with_json(uri, json)
      post(uri, json, 'CONTENT_TYPE' => 'application/json')
    end

    def parsed_response
      JSON.parse(last_response.body)
    end

  end
end
