require "dry/web/container"
require "dry/system/components"

module Dms
  class Container < Dry::Web::Container
    configure do
      config.name = :dms
      config.listeners = true
      config.default_namespace = "dms"
      config.auto_register = %w[lib/dms]
    end

    load_paths! "lib"
  end
end
