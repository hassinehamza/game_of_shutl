require 'spec_helper'

describe GameOfShutl::PriceController do

  let(:price_controller) do
    GameOfShutl::PriceController.new
  end
  let(:vehicle_controller) do
    GameOfShutl::VehicleController.new
  end

  describe 'calculatBasicPrice method' do
    it 'converts the postcodes to base-32 and subtracts delivery from pickup and calculate basic price' do

        pickup_postcode =  'SW1A 1AA'
        delivery_postcode = 'EC2A 3LT'

        expect(price_controller.calcul_basic_price(pickup_postcode, delivery_postcode)).to eq 679
    end
    it 'calculates variable price by distance' do
      pickup_postcode =  'AL1 5WD'
      delivery_postcode = 'EC2A 3LT'

      expect(price_controller.calcul_basic_price(pickup_postcode, delivery_postcode)).to eq 656
    end
  end

  describe 'price_based_on_vehicle method' do
    it 'calculates basic price and add to it vehicle fees' do
      pickup_postcode =  'AL1 5WD'
      delivery_postcode = 'EC2A 3LT'
      vehicle = vehicle_controller.get_vehicle('bicycle')

      expect(price_controller.price_based_on_vehicle(pickup_postcode, delivery_postcode, vehicle)).to eq 721.6
    end
  end
end
