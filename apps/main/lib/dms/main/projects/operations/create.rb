# frozen_string_literal: true

require 'dms/main/import'
require 'dms/main/entities/project'
require 'dms/main/projects/validations/project'
require 'dms/matcher'

module Dms
  module Main
    module Projects
      module Operations
        class Create
          include Dms::Matcher
          include Dms::Main::Import['project_repo']

          def call(attributes)
            validation = Validations::ProjectSchema.call(attributes_with_cause_id(attributes))
            if validation.success?
              project = project_repo.create(validation.output)
              Dry::Monads::Right(project)
            else
              Dry::Monads::Left(validation)
            end
          end

          private

          def attributes_with_cause_id(attributes)
            cause = project_repo.find_cause(
              attributes.dig(:project, :causeCode)
            )
            attributes[:project][:cause] = cause.id if cause
            attributes
          end
        end
      end
    end
  end
end
