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

    post '/quotes/basic' do

      quote = json_params['quote']

      price = Price.new
      basicPrice = price.calculBasicPrice(quote['pickup_postcode'], quote['delivery_postcode'])

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          price: basicPrice
        }
      }.to_json
    end

    post '/quotes/vehicle' do

      quote = json_params['quote']
      vehicleController = VehicleController.new
      vehicle = vehicleController.getVehicle(quote['vehicle'])
      price = Price.new
      priceByVehicle = price.priceBasedOnVehicle(quote['pickup_postcode'], quote['delivery_postcode'], vehicle)

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          vehicle: quote['vehicle'],
          price: priceByVehicle
        }
      }.to_json
    end
  end
end
