require "types"
require "dms/main/entities/person"
require "dms/main/entities/cause"
require "dms/main/entities/project"

module Dms
  module Main
    module Entities
      class Project < Dry::Struct
        attribute :title, Types::Strict::String
        attribute :description, Types::Strict::String
        attribute :location, Types::Strict::String # with a check of places we only deal in
        attribute :longitude, Types::Strict::String
        attribute :latitude, Types::Strict::String
        attribute :eligible_for_zakat, Types::Strict::Bool
        attribute :created_at, Types::Strict::Time
        attribute :updated_at, Types::Strict::Time
        attribute :active, Types::Strict::Bool
        attribute :total_target_in_pence, Types::Strict::Int
        attribute :cause, Types::Strict::Array.member(::Dms::Main::Entities::Cause)
        alias_method :active?, :active
      end
    end
  end
end

