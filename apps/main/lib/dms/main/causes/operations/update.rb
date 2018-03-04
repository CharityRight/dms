require 'dms/main/import'
require 'dms/main/entities/cause'
require 'dms/main/causes/validations/cause'
require 'dms/matcher'

module Dms
  module Main
    module Causes
      module Operations
        class Update
          include Dms::Matcher
          include Dms::Main::Import["cause_repo"]

          def call(attrs:, code:)
            #binding.pry
            validation = Validations::UpdateSchema.(
              prepare_attributes(attrs, code)
            )
            if validation.success?
              cause = cause_repo.update_by_code(
                code: code, attrs: validation.output
              )
              Dry::Monads::Right(cause)
            else
              Dry::Monads::Left(validation)
            end
          end
          private

          def prepare_attributes(attrs, code)
            attrs.merge(code: code)
          end
        end
      end
    end
  end
end
