require "dms/main/import"
require "dms/main/entities/donation"
require "dms/main/donations/validations/donation"
require "dms/matcher"

module Dms
  module Main
    module Donations
      module Operations
        class Create
          include Dms::Matcher
          include Dms::Main::Import["donation_repo"]

          def call(attributes)
            validation = Validations::DonationSchema.(attributes)
            if validation.success?
              donation = donation_repo.create_with_donor(validation.output)
              Dry::Monads::Right(donation)
            else
              Dry::Monads::Left(validation)
            end
          end
        end
      end
    end
  end
end
