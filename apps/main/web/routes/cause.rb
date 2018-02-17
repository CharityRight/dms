module Dms
  module Main
    class Web
      route "causes" do |r|
        r.post do
          r.resolve "causes.operations.create" do |create|
            create.(r["data"]) do |m|
              m.success do |created_cause|
                response.status = 201
                created_cause.to_json_api
              end
              m.failure do |validation|
                response.status = 400 # Malformed request
                validation.errors.to_hash.to_json
              end
            end
          end
        end
        r.get do
          r.resolve "causes.operations.index" do |index|
            results = index.call
            results.mapper.model.collection_to_json_api(results.to_a)
          end
        end
      end
    end
  end
end