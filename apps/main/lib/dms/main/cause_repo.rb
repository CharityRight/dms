require "dms/repository"
module Dms
  module Main
    class CauseRepo < Dms::Repository[:causes]
      struct_namespace Main::Entities

      def create(cause)
        saved_cause = causes.transaction do
          create_cause(cause)
        end
        causes.by_pk(saved_cause.id).one
      end

      def index
        causes
      end

      def cause_attrs(attrs)
        {
          name: attrs.fetch(:name),
          description: attrs.fetch(:description),
          code: attrs.fetch(:code),
          active: attrs.fetch(:active),
          location: attrs.fetch(:location)
        }
      end

      def query(conditions)
        causes.where(conditions)
      end

      def by_id(id)
        causes.by_pk(id).one!
      end

      private

      def create_cause(cause)
        causes.changeset(:create, cause_attrs(cause.fetch(:cause))).commit
      end
    end
  end
end
