# frozen_string_literal: true

require 'dms/main/import'
require 'dms/main/entities/cause'
require 'dms/main/causes/validations/cause'
require 'dms/matcher'

module Dms
  module Main
    module Causes
      module Operations
        class Get
          include Dms::Matcher
          include Dms::Main::Import['cause_repo']

          def call(code)
            cause = cause_repo.get_by_code(code)
            if cause
              Dry::Monads::Right(cause)
            else
              Dry::Monads::Left(errors: "Cause #{code} not found")
            end
          end
        end
      end
    end
  end
end
