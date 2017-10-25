require 'spec_helper'

describe GameOfShutl::Price do

  let(:price) do
    GameOfShutl::Price.new
  end

  describe 'calculatBasicPrice method' do
    it 'converts the postcodes to base-32 and subtracts delivery from pickup and calculate basic price' do

        pickup_postcode =  'SW1A 1AA'
        delivery_postcode = 'EC2A 3LT'

        expect(price.calculBasicPrice(pickup_postcode, delivery_postcode)).to eq 679
    end
    it 'calculate variable price by distance' do
      pickup_postcode =  'AL1 5WD'
      delivery_postcode = 'EC2A 3LT'

      expect(price.calculBasicPrice(pickup_postcode, delivery_postcode)).to eq 656
    end
  end
end
