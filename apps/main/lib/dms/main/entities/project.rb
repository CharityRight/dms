require "types"
require "dms/main/entities/person"
require "dms/main/entities/cause"
require "dms/main/entities/project"

module Dms
  module Main
    module Entities
      class Project < Dry::Struct
        constructor_type :schema

        attribute :name, Types::Strict::String
        attribute :description, Types::Strict::String
        attribute :project_code, Types::Strict::String
        attribute :location, Types::Strict::String # with a check of places we only deal in
        attribute :longitude, Types::Strict::String
        attribute :latitude, Types::Strict::String
        attribute :eligible_for_zakat, Types::Strict::Bool
        attribute :created_at, Types::Strict::Time
        attribute :updated_at, Types::Strict::Time
        attribute :active, Types::Strict::Bool
        attribute :target_total, Types::Strict::Int

        alias_method :active?, :active
      end

      class ProjectWithCause < Project
        attribute :cause, Types::Strict::Array.member(::Dms::Main::Entities::Cause)
      end
    end
  end
end

