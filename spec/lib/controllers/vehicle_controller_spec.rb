require 'spec_helper'

describe GameOfShutl::VehicleController do
  let(:vehicleController) do
    GameOfShutl::VehicleController.new
  end
  describe 'findVehicleByPrice' do
    it 'it determine the appropriate Vehicle based on basic price if vehicle is provided'  do
      vehicle = 'motorbike'
      price = 1200

      expect((vehicleController.findVehicleByPrice(vehicle, price)).type).to eq 'small_van'
    end

    it 'it determine the appropriate Vehicle based on basic price if vehicle is NOT provided'  do
      price = 1200

      expect((vehicleController.findVehicleByPrice(nil, price)).type).to eq 'small_van'
    end

  end
end
