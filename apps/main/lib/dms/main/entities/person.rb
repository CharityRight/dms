require "types"

module Dms
  module Main
    module Entities
      class Person < Dry::Struct
        attribute :email, Types::Strict::String
        attribute :title, Types::Strict::String
        attribute :first_name, Types::Strict::String
        attribute :last_name,  Types::Strict::String
        attribute :address_1,  Types::Strict::String
        attribute :address_2,  Types::Strict::String
        attribute :address_3,  Types::Strict::String
        attribute :post_code,  Types::Strict::String
        attribute :county,  Types::Strict::String
        attribute :country,  Types::Strict::String
        attribute :created_at, Types::Strict::Time
        attribute :updated_at, Types::Strict::Time
      end
    end
  end
end



