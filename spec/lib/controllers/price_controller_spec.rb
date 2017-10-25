require 'spec_helper'

describe GameOfShutl::Price do

    let(:price) do
      GameOfShutl::Price.new
    end

  describe 'basic price' do
    it 'converts the postcodes to base-32 and subtracts delivery from pickup' do

        pickup_postcode =  'SW1A 1AA'
        delivery_postcode = 'EC2A 3LT'

        expect(price.calculBasicPrice(pickup_postcode, delivery_postcode)).to eq 679
    end
  end
end
