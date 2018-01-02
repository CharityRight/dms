require "dms/repository"
module Dms
  module Main
    class DonationRepo < Dms::Repository[:donations]
      def create_with_donor(donation)
        saved_donation = donations.transaction do
          new_donation = donations.changeset(
            :create, donation_attrs(donation.fetch(:donation))
          ).associate(find_or_create_donor(donation))

          new_donation.commit
        end
        Dms::Main::Entities::Donation::WithDonor.new(
          aggregate(:donor).by_pk(saved_donation.id).one
        )
      end

      def donation_attrs(attrs)
        {
          amount: attrs.fetch(:amount),
          currency: attrs.fetch(:currency),
          start_date: attrs.fetch(:startDate),
          end_date: attrs.fetch(:endDate),
          donation_type: 1, # TODO: lookup donation type
          zakat: attrs.fetch(:zakat)
        }
      end

      def donor_attrs(attrs)
        {
          email: attrs.fetch(:email),
          first_name: attrs.fetch(:firstName),
          last_name: attrs.fetch(:lastName)
        }
      end

      def query(conditions)
        donations.where(conditions)
      end

      def by_id(id)
        donations.by_pk(id).one!
      end

      private
      # TODO Move to donor repo
      def find_or_create_donor(donation)
        donor = find_donor_with_email(donation.dig(:donor, :email))
        donor || create_donor_from_donation(donation)
      end

      def find_donor_with_email(email)
        donors.where(email: email).one
      end

      def create_donor_from_donation(donation)
        donors.changeset(:create, donor_attrs(donation.fetch(:donor))).commit
      end
    end
  end
end
