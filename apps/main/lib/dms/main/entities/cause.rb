require "types"

module Dms
  module Main
    module Entities
      class Cause < ROM::Struct
        constructor_type :schema

        attribute :id, Types::Strict::Int
        attribute :name, Types::Strict::String
        attribute :description, Types::Strict::String
        attribute :location, Types::Strict::String
        attribute :created_at, Types::Strict::Time
        attribute :updated_at, Types::Strict::Time
        attribute :active, Types::Strict::Bool
        attribute :code, Types::Strict::String

        alias_method :active?, :active

        def self.collection_to_json_api(causes)
          causes.map(&:json_api_hash).to_json
        end

        def to_json_api
          json_api_hash.to_json
        end

        def json_api_hash
          {
            'data' => {
              'id' => id,
              'type' => 'causes',
              'attributes' => {
                'name' => name,
                'description' => description,
                'location' => location,
                'active' => active,
                'code' => code
              }
            }
          }
        end
      end
    end
  end
end
