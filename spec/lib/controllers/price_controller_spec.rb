require 'spec_helper'

describe GameOfShutl::PriceController do

  let(:priceController) do
    GameOfShutl::PriceController.new
  end
  let(:vehicleController) do
    GameOfShutl::VehicleController.new
  end

  describe 'calculatBasicPrice method' do
    it 'converts the postcodes to base-32 and subtracts delivery from pickup and calculate basic price' do

        pickup_postcode =  'SW1A 1AA'
        delivery_postcode = 'EC2A 3LT'

        expect(priceController.calculBasicPrice(pickup_postcode, delivery_postcode)).to eq 679
    end
    it 'calculate variable price by distance' do
      pickup_postcode =  'AL1 5WD'
      delivery_postcode = 'EC2A 3LT'

      expect(priceController.calculBasicPrice(pickup_postcode, delivery_postcode)).to eq 656
    end
  end

  describe 'priceBasedOnVehicle method' do
    it 'calculate basic price and add to it vehicle fees' do
      pickup_postcode =  'AL1 5WD'
      delivery_postcode = 'EC2A 3LT'
      vehicle = vehicleController.getVehicle('bicycle')

      expect(priceController.priceBasedOnVehicle(pickup_postcode, delivery_postcode, vehicle)).to eq 721.6
    end
  end
end
