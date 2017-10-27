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

  describe 'find_vehicle_by_products' do
    it 'should find the smallest required vehicle based only on the volumetrics of the produts' do
      products = [{
        'weight' => 10,
        'width' => 50,
        'height' => 50,
        'length' => 50
      }]

      expect((vehicle_controller.find_vehicle_by_products(products)).type).to eq 'parcel_car'
    end

    it 'should find the adequated vehicle based on the volumetrics of the produts and it should be greater than the vehicle specified' do
      products = [{
        'weight' => 10,
        'width' => 50,
        'height' => 50,
        'length' => 50
      }]
      basic_vehicle = vehicle_controller.get_vehicle('small_van')
      expect((vehicle_controller.find_vehicle_by_products(products, basic_vehicle)).type).to eq 'small_van'
    end
  end
end
