module Test
  module DatabaseHelpers
    module_function

    def rom
      Dms::Container["persistence.rom"]
    end

    def db
      Dms::Container["persistence.db"]
    end
  end
end
