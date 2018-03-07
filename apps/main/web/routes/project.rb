# frozen_string_literal: true

module Dms
  module Main
    class Web
      route 'projects' do |r|
        r.post do
          r.resolve 'projects.operations.create' do |create|
            create.call(r['data']) do |m|
              m.success do |created_project|
                response.status = 201
                created_project.to_json_api
              end
              m.failure do |validation|
                response.status = 400 # Malformed request
                validation.errors.to_hash.to_json
              end
            end
          end
        end
        r.on do
          r.on :project_code do |project_code|
            r.get do
              r.resolve 'projects.operations.get' do |project|
                project.call(project_code) do |m|
                  m.success(&:to_json_api)
                  m.failure do |errors|
                    response.status = 404
                    errors.to_json
                  end
                end
              end
            end
            r.put do
              r.resolve 'projects.operations.update' do |update|
                update.call(project_code: project_code, attrs: r['data']) do |m|
                  m.success do |updated_project|
                    response.status = 200
                    updated_project.to_json_api
                  end
                  m.failure do |validation|
                    response.status = 400
                    validation.errors.to_hash.to_json
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
