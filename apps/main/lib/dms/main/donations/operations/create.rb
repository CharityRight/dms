require "dms/main/entities/donation"
require "dms/main/donations/validations/donation"

require 'dry-monads'
require "dry/matcher"
require "dry/matcher/either_matcher"
module Dms
  module Main
    module Donations
      module Operations
        class Create
          include Dry::Matcher.for(:call, with: Dry::Matcher::EitherMatcher)

          def call(attributes)
            # Validation
            validation = Validations::DonationSchema.(attributes)
            if validation.success?
              puts "PASSED VALIDATION"
              Dry::Monads::Right(validation)
            else
              puts "FAILED VALIDATION"
              Dry::Monads::Left(validation)
            end
          end
        end
      end
    end
  end
end
