# frozen_string_literal: true

# auto_register: false

require 'rom-repository'
require 'dms/container'
require 'dms/import'

module Dms
  class Repository < ROM::Repository::Root
    include Import.args['persistence.rom']
  end
end
