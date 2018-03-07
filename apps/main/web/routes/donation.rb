# frozen_string_literal: true

module Dms
  module Main
    class Web
      route 'donations' do |r|
        r.post do
          r.resolve 'donations.operations.create' do |create|
            create.call(r['data']) do |m|
              m.success do |created_donation|
                response.status = 202 # Accepted and added to sidekick
                created_donation.to_json_api
              end
              m.failure do |validation|
                response.status = 400 # Malformed request
                validation.errors.to_hash.to_json
              end
            end
          end
        end
      end
    end
  end
end
