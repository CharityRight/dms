# frozen_string_literal: true

require 'dms/main/view/controller'

module Dms
  module Main
    module Views
      class Welcome < View::Controller
        configure do |config|
          config.template = 'welcome'
        end
      end
    end
  end
end
