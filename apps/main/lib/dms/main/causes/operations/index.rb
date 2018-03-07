# frozen_string_literal: true

require 'dms/main/import'
require 'dms/main/entities/cause'
require 'dms/main/causes/validations/cause'
require 'dms/matcher'

module Dms
  module Main
    module Causes
      module Operations
        class Index
          include Dms::Matcher
          include Dms::Main::Import['cause_repo']

          def call
            cause_repo.index
          end
        end
      end
    end
  end
end
