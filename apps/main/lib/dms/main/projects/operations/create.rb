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
          include Dms::Main::Import["project_repo"]

          def call(attributes)
            validation = Validations::ProjectSchema.(attributes)
            if validation.success?
              project = project_repo.create(validation.output)
              Dry::Monads::Right(project)
            else
              Dry::Monads::Left(validation)
            end
          end
        end
      end
    end
  end
end
