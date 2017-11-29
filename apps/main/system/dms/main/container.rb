require "pathname"
require "dry/web/container"
require "dry/system/components"

module Dms
  module Main
    class Container < Dry::Web::Container
      require root.join("system/dms/container")
      import core: Dms::Container

      configure do |config|
        config.root = Pathname(__FILE__).join("../../..").realpath.dirname.freeze
        config.logger = Dms::Container[:logger]
        config.default_namespace = "dms.main"
        config.auto_register = %w[lib/dms/main]
      end

      load_paths! "lib"
    end
  end
end
