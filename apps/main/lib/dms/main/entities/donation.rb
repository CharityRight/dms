require "types"
require "dms/main/entities/person"
require "dms/main/entities/cause"
require "dms/main/entities/project"

module Dms
  module Main
    module Entities
      class Donation < Dry::Struct

        Donation_Types = Types::Strict::String.enum('one-off', 'monthly', 'yearly')

        attribute :id, Types::Strict::Int
        attribute :amount_in_pence, Types::Strict::Int
        attribute :currency, Types::Strict::String
        attribute :zakat, Types::Bool
        attribute :admin_fee_contribution_in_pence, Types::Strict::Int
        attribute :start_date, Types::Strict::Time
        attribute :end_date, Types::Strict::Time
        attribute :created_at, Types::Strict::Time
        attribute :updated_at, Types::Strict::Time
        attribute :donation_type, Donation_Types

        class WithDonor < Donation
          attribute :donor, Entities::Person
        end

        class WithDonorAndCause < Donation
          attribute :donor, Entities::Person
          attribute :cause, Types::Strict::Array.member(Entities::Cause)
        end

        class WithDonorAndProject < Donation
          attribute :donor, Entities::Person
          attribute :cause, Types::Strict::Array.member(Entities::Cause)
          attribute :project, Types::Strict::Array.member(Entities::Project)
        end
      end
    end
  end
end
