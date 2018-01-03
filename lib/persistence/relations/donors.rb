module Persistence
  module Relations
    class Donors < ROM::Relation[:sql]
      schema(:donors, infer: true) do
        associations do
          has_many :donations
        end
      end
    end
  end
end
