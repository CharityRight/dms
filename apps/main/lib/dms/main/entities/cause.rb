require "types"

module Dms
  module Main
    module Entities
      class Cause < Dry::Struct
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

        def to_json_api
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
          }.to_json
        end
      end
    end
  end
end
