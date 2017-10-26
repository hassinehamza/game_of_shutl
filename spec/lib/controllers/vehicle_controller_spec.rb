require 'spec_helper'

describe GameOfShutl::VehicleController do

  let(:vehicle_controller) do
    GameOfShutl::VehicleController.new
  end

  describe 'find_vehicle_by_price' do
    it 'it determine the appropriate Vehicle based on basic price if vehicle is specified'  do
      vehicle = 'motorbike'
      price = 1200

      expect((vehicle_controller.find_vehicle_by_price(vehicle, price)).type).to eq 'small_van'
    end

    it 'it determine the appropriate Vehicle based on basic price if vehicle is NOT specified'  do
      price = 1200

      expect((vehicle_controller.find_vehicle_by_price(nil, price)).type).to eq 'small_van'
    end

  end
end
