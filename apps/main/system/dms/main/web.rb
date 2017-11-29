require "dry/web/roda/application"
require_relative "container"

module Dms
  module Main
    class Web < Dry::Web::Roda::Application
      configure do |config|
        config.container = Container
        config.routes = "web/routes".freeze
      end

      opts[:root] = Pathname(__FILE__).join("../../..").realpath.dirname

      use Rack::Session::Cookie, key: "dms.main.session", secret: self["core.settings"].session_secret

      #plugin :csrf, raise: true #TODO: Put Auth Header Check
      plugin :csrf, skip_middleware: true
      plugin :dry_view
      plugin :error_handler
      plugin :flash
      plugin :multi_route
      plugin :json_parser

      route do |r|
        r.multi_route
        r.root do
          r.view "welcome"
        end
      end

      # Request-specific options for dry-view context object
      def view_context_options
        {
          flash:        flash,
          csrf_token:   Rack::Csrf.token(request.env),
          csrf_metatag: Rack::Csrf.metatag(request.env),
          csrf_tag:     Rack::Csrf.tag(request.env),
        }
      end

      load_routes!
    end
  end
end
