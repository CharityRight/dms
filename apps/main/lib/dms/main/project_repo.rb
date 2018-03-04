require "dms/repository"
module Dms
  module Main
    class ProjectRepo < Dms::Repository[:projects]
      def create(project)
        saved_project = projects.transaction do
          new_project = projects.changeset(
            :create, project_attrs(project.fetch(:project))
          ).associate(find_cause(project.dig(:project, :causeCode)))
          new_project.commit
        end
        Dms::Main::Entities::ProjectWithCause.new(
          aggregate(:cause).by_pk(saved_project.id).one
        )
      end

      def update_by_project_code(project_code:, attrs:)
        project = get_by_project_code(project_code)
        return unless project
        projects.transaction { update_project(attrs[:project]) }
        Dms::Main::Entities::ProjectWithCause.new(
          aggregate(:cause).by_pk(project.id).one
        )
      end

      def project_attrs(attrs)
        {
          name: attrs.fetch(:name),
          description: attrs.fetch(:description),
          active: attrs.fetch(:active),
          location: attrs.fetch(:location),
          longitude: attrs.fetch(:longitude, ''),
          latitude: attrs.fetch(:latitude, ''),
          eligible_for_zakat: attrs.fetch(:zakat),
          target_total: attrs.fetch(:targetTotal),
          code: attrs.fetch(:projectCode)
        }
      end

      def query(conditions)
        projects.where(conditions)
      end

      def by_id(id)
        projects.by_pk(id).one!
      end

      def find_cause(code)
        causes.where(code: code).one
      end

      def get_by_project_code(project_code, convert = false)
        if convert
          Dms::Main::Entities::ProjectWithCause.new(
            aggregate(:cause).where(code: project_code).one
          )
        else
          query(code: project_code).one
        end
      end

      def update_project(project)
        projects.changeset(:update, project).commit
      end
    end
  end
end
