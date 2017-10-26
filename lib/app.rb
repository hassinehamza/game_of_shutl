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

      price_controller = PriceController.new
      basic_price = price_controller.calcul_basic_price(quote['pickup_postcode'], quote['delivery_postcode'])

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          price: basic_price
        }
      }.to_json
    end

    post '/quotes/price_by_vehicle' do

      quote = json_params['quote']
      vehicle_controller = VehicleController.new
      vehicle = vehicle_controller.get_vehicle(quote['vehicle'])
      price_controller = PriceController.new
      price_by_vehicle = price_controller.price_based_on_vehicle(quote['pickup_postcode'], quote['delivery_postcode'], vehicle)

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          vehicle: quote['vehicle'],
          price: price_by_vehicle
        }
      }.to_json
    end

    post '/quotes/vehicle_by_price_limit' do

      quote = json_params['quote']
      price_controller = PriceController.new
      basic_price = price_controller.calcul_basic_price(quote['pickup_postcode'], quote['delivery_postcode'])
      vehicle_controller = VehicleController.new
      vehicle = vehicle_controller.find_vehicle_by_price(quote['vehicle'], basic_price)
      price_based_on_vehicle = price_controller.price_based_on_vehicle(quote['pickup_postcode'], quote['delivery_postcode'], vehicle)

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          vehicle: vehicle.type,
          price: price_based_on_vehicle
        }
      }.to_json
    end

  end
end
