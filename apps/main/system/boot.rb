# frozen_string_literal: true

require_relative 'dms/main/container'

Dms::Main::Container.finalize!

require 'dms/main/web'
