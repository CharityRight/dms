require 'dms/main/import'
require 'dms/main/entities/cause'
require 'dms/main/causes/validations/cause'
require 'dms/matcher'

module Dms
  module Main
    module Causes
      module Operations
        class Create
          include Dms::Matcher
          include Dms::Main::Import["cause_repo"]

          def call(attributes)
            validation = Validations::CauseSchema.(attributes)
            if validation.success?
              cause = cause_repo.create(validation.output)
              Dry::Monads::Right(cause)
            else
              Dry::Monads::Left(validation)
            end
          end
        end
      end
    end
  end
end
