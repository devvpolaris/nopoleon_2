module Spa
  class UploadDonor
    def initialize(payload)
      @row = payload[:row]
      @org = payload[:org]
    end

    def process!
      donor = Donor.find_by_email(@row['email'])

      unless donor.present?
        if  @row['email'].present?
          donor = Donor.create(
            email: @row['email'],
            name: "#{@row['first_name']} #{@row['last_name']}",
            first_name: @row['first_name'],
            last_name: @row['last_name'],
            phone: @row['phone'],
            address: @row['address1'],
            address_line_2: @row['address2'],
            city: @row['city'],
            state: @row['state'],
            zip_code: @row['zip'],
            country: @row['country'],
            password: ENV['TEMP_PASSWORD'],
          )
          raise Exceptions::DonorCreationError unless donor.save!
        end
      end

      if donor.present?
        donation = donor.donations.create(
          campaign_id: campaign.id
        )

        raise Exceptions::DonationCreationError unless donation.save!
      end
    end

    private

    def campaign
      @org.campaigns.where(goal: 'general').first
    end
  end
end
