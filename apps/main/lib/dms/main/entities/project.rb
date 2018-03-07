# frozen_string_literal: true

require 'types'
require 'dms/main/entities/person'
require 'dms/main/entities/cause'
require 'dms/main/entities/project'

module Dms
  module Main
    module Entities
      class Project < Dry::Struct
        constructor_type :schema

        attribute :id, Types::Strict::Int
        attribute :name, Types::Strict::String
        attribute :description, Types::Strict::String
        attribute :code, Types::Strict::String
        attribute :location, Types::Strict::String # with a check of places we only deal in
        attribute :longitude, Types::Strict::String
        attribute :latitude, Types::Strict::String
        attribute :eligible_for_zakat, Types::Strict::Bool
        attribute :created_at, Types::Strict::Time
        attribute :updated_at, Types::Strict::Time
        attribute :active, Types::Strict::Bool
        attribute :target_total, Types::Strict::Int

        alias active? active
      end

      class ProjectWithCause < Project
        attribute :cause, ::Dms::Main::Entities::Cause
        def to_json_api
          {
            'data' => {
              'id' => code,
              'type' => 'projects',
              'attributes' => attributes,
              'relationships' => relationships
            }
          }.to_json
        end

        private

        def attributes
          {
            'name' => name, 'description' => description,
            'projectCode' => code, 'active' => active,
            'location' => location, 'latitude' => latitude,
            'longitude' => longitude, 'targetTotal' => target_total,
            'zakat' => eligible_for_zakat
          }
        end

        def relationships
          {
            'cause' => {
              'links' => {
                'self' => "http://example.com/causes/#{cause&.code}/relationships/cause",
                'related' => "http://example.com/causes/#{cause&.code}/cause"
              },
              'data' => { 'type' => 'cause', 'id' => cause&.code }
            }
          }
        end
      end
    end
  end
end
