# frozen_string_literal: true

module Persistence
  module Relations
    class Donations < ROM::Relation[:sql]
      schema(:donations, infer: true) do
        associations do
          belongs_to :donor
        end
      end
    end
  end
end
