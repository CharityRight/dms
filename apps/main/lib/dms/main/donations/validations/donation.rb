# frozen_string_literal: true

require 'dry-validation'
module Dms
  module Main
    module Donations
      module Validations
        DonationSchema = Dry::Validation.Form do
          required(:donation).schema do
            required(:amount).filled
            required(:currency).filled
            required(:startDate).filled
            required(:endDate).filled
            required(:donationType).filled
            required(:zakat).filled
          end
          required(:donor).schema do
            required(:email).filled
            required(:firstName).filled
            required(:lastName).filled
          end
          required(:cause).schema do
            required(:project).filled
            required(:causeCode).filled
          end
        end
      end
    end
  end
end
__END__
{
  donation: {
    amount: 200.00,
    currency: "GBP",
    start_date: "12/12/2017",
    end_date: "12/12/2017",
    donation_type: "one-off",
    zakat: false,
  },
  donor: {
    email: "jon@do.com",
    first_name: "Jon",
    last_name: "Do",
  },
  cause: {
    project: "SUDAN",
    code: "SCHOOL-MEALS",
  },
}
