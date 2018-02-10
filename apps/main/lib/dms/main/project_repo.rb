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
    end
  end
end
