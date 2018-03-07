# frozen_string_literal: true

require 'dry-validation'
module Dms
  module Main
    module Causes
      module Validations
        CauseSchema = Dry::Validation.Form do
          required(:cause).schema do
            required(:name).filled
            required(:description).filled
            required(:active).filled
            required(:code).filled
            required(:location).filled
          end
        end
        UpdateSchema = Dry::Validation.Form do
          required(:cause).schema do
            required(:code).filled
            optional(:name).filled
            optional(:description).filled
            optional(:active).filled
            optional(:code).filled
            optional(:location).filled
          end
        end
      end
    end
  end
end
