# frozen_string_literal: true

module Persistence
  module Relations
    class Projects < ROM::Relation[:sql]
      schema(:projects, infer: true) do
        associations do
          belongs_to :cause
        end
      end
    end
  end
end
