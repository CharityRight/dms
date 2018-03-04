require 'dms/main/import'
require 'dms/main/entities/project'
require 'dms/main/projects/validations/project'
require 'dms/matcher'

module Dms
  module Main
    module Projects
      module Operations
        class Update
          include Dms::Matcher
          include Dms::Main::Import["project_repo"]

          def call(attrs:, project_code:)
            validation = Validations::UpdateSchema.(
              prepare_attributes(attrs, project_code)
            )
            if validation.success?
              project = project_repo.update_by_project_code(
                project_code: project_code, attrs: validation.output
              )
              Dry::Monads::Right(project)
            else
              Dry::Monads::Left(validation)
            end
          end

          private

          def prepare_attributes(attrs, project_code)
            attrs.tap do |attributes|
              attributes['project']['projectCode'] = project_code
            end
          end
        end
      end
    end
  end
end
