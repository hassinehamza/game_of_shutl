module GameOfShutl
  class Application < Sinatra::Base

    def json_params
      begin
        request.body.rewind
        JSON.parse(request.body.read)
      rescue
        halt 400, { message:'Invalid JSON' }.to_json
      end
    end

    post '/quotes/basic_price' do

      quote = json_params['quote']

      priceController = PriceController.new
      basicPrice = priceController.calculBasicPrice(quote['pickup_postcode'], quote['delivery_postcode'])

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          price: basicPrice
        }
      }.to_json
    end

    post '/quotes/price_by_vehicle' do

      quote = json_params['quote']
      vehicleController = VehicleController.new
      vehicle = vehicleController.getVehicle(quote['vehicle'])
      priceController = PriceController.new
      priceByVehicle = priceController.priceBasedOnVehicle(quote['pickup_postcode'], quote['delivery_postcode'], vehicle)

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          vehicle: quote['vehicle'],
          price: priceByVehicle
        }
      }.to_json
    end

    post '/quotes/vehicle_by_price' do

      quote = json_params['quote']
      priceController = PriceController.new
      basicPrice = priceController.calculBasicPrice(quote['pickup_postcode'], quote['delivery_postcode'])
      vehicleController = VehicleController.new
      vehicle = vehicleController.findVehicleByPrice(quote['vehicle'], basicPrice)
      priceBasedOnVehicle = priceController.priceBasedOnVehicle(quote['pickup_postcode'], quote['delivery_postcode'], vehicle)

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          vehicle: vehicle.type,
          price: priceBasedOnVehicle
        }
      }.to_json
    end

  end
end
