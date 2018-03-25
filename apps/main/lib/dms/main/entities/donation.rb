# frozen_string_literal: true

require 'types'
require 'dms/main/entities/person'
require 'dms/main/entities/cause'
require 'dms/main/entities/project'

module Dms
  module Main
    module Entities
      class Donation < Dry::Struct
        constructor_type :schema
        Donation_Types = Types::Strict::String.enum('one-off', 'monthly', 'yearly')

        attribute :id, Types::Strict::Int
        attribute :correlation_id, Types::Strict::String
        attribute :amount, Types::Strict::Int
        attribute :currency, Types::Strict::String
        attribute :zakat, Types::Bool
        attribute :start_date, Types::Strict::Time
        attribute :end_date, Types::Strict::Time
        attribute :created_at, Types::Strict::Time
        attribute :updated_at, Types::Strict::Time
        attribute :donation_type, Donation_Types

        class WithDonor < Donation
          attribute :donor, Entities::Person

          def to_json_api
            {
              'data' => {
                'id' => correlation_id,
                'type' => 'donations',
                'attributes' => attributes,
                'relationships' => relationships
              }
            }.to_json
          end

          private

          def attributes
            {
              'amount' => amount,
              'currency' => currency,
              'zakat' => zakat,
              'start_date' => start_date,
              'end_date' => end_date,
              'donation_type' => donation_type
            }
          end

          def relationships
            {
              'donor' => {
                'links' => {
                  'self' => "http://example.com/donations/#{correlation_id}/relationships/donor",
                  'related' => "http://example.com/donations/#{correlation_id}/donor"
                },
                'data' => { 'type' => 'people', 'id' => donor.id }
              }
            }
          end
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
