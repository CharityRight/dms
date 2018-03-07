# frozen_string_literal: true

module Dms
  module Main
    class Web
      route 'causes' do |r|
        r.post do
          r.resolve 'causes.operations.create' do |create|
            create.call(r['data']) do |m|
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
        r.on do
          r.on :code do |code|
            r.get do
              r.resolve 'causes.operations.get' do |cause|
                cause.call(code) do |m|
                  m.success(&:to_json_api)
                  m.failure do |errors|
                    response.status = 404 # Malformed request
                    errors.to_json
                  end
                end
              end
            end
            r.put do
              r.resolve 'causes.operations.update' do |update|
                update.call(code: code, attrs: r['data']) do |m|
                  m.success do |updated_cause|
                    response.status = 200
                    updated_cause.to_json_api
                  end
                  m.failure do |validation|
                    response.status = 400 # Malformed request
                    validation.errors.to_hash.to_json
                  end
                end
              end
            end
          end
          r.is do
            r.get do
              r.resolve 'causes.operations.index' do |index|
                results = index.call
                results.mapper.model.collection_to_json_api(results.to_a)
              end
            end
          end
        end
      end
    end
  end
end
