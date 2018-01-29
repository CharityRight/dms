module Dms
  module Main
    class Web
      route "projects" do |r|
        r.post do
          r.resolve "projects.operations.create" do |create|
            create.(r["data"]) do |m|
              m.success do |created_project|
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
      end
    end
  end
end
