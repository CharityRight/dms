require "types"

module Dms
  module Main
    module Entities
      class Cause < Dry::Struct
        attribute :title, Types::Strict::String
        attribute :description, Types::Strict::String
        attribute :location, Types::Strict::String
        attribute :created_at, Types::Strict::Time
        attribute :updated_at, Types::Strict::Time
        attribute :active, Types::Strict::Bool
        attribute :code, Types::Strict::String

        alias_method :active?, :active
      end
    end
  end
end




