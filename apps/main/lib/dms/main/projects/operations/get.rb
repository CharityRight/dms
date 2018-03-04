require 'dms/main/import'
require 'dms/main/entities/project'
require 'dms/main/projects/validations/project'
require 'dms/matcher'

module Dms
  module Main
    module Projects
      module Operations
        class Get
          include Dms::Matcher
          include Dms::Main::Import["project_repo"]

          def call(project_code)
            project = project_repo.get_by_project_code(project_code, true)
            if project.id.nil?
              Dry::Monads::Left(errors: "Project #{project_code} not found")
            else
              Dry::Monads::Right(project)
            end
          end
        end
      end
    end
  end
end
