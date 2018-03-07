# frozen_string_literal: true

require 'dry-validation'
module Dms
  module Main
    module Projects
      module Validations
        ProjectSchema = Dry::Validation.Form do
          required(:project).schema do
            required(:name).filled
            required(:description).filled
            required(:causeCode).filled
            required(:active).filled
            required(:location).filled
            required(:zakat).filled
            required(:projectCode).filled
            required(:targetTotal).filled
            optional(:longitude).filled
            optional(:latitude).filled
          end
        end
        UpdateSchema = Dry::Validation.Form do
          required(:project).schema do
            optional(:name).filled
            optional(:description).filled
            optional(:causeCode).filled
            optional(:active).filled
            optional(:location).filled
            optional(:zakat).filled
            required(:projectCode).filled
            optional(:targetTotal).filled
            optional(:longitude).filled
            optional(:latitude).filled
          end
        end
      end
    end
  end
end
