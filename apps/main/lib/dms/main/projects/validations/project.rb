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
            optional(:longitude)
            optional(:latitude)
          end
        end
      end
    end
  end
end
