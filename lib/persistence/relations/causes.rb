# frozen_string_literal: true

module Persistence
  module Relations
    class Causes < ROM::Relation[:sql]
      schema(:causes, infer: true)
    end
  end
end
