module GameOfShutl
  class Application < Sinatra::Base

    #
    # methode to parse json request
    #
    def json_params
      begin
        request.body.rewind
        JSON.parse(request.body.read)
      rescue
        halt 400, { message:'Invalid JSON' }.to_json
      end
    end

    #
    # calculate Variable price based on distance
    #
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

    #
    # calculate price based on vehicle and distance
    #
    post '/quotes/price_by_vehicle' do

      quote = json_params['quote']

      # find the vehicle object which name was specifiedin the request
      vehicle_controller = VehicleController.new
      vehicle = vehicle_controller.get_vehicle(quote['vehicle'])

      #calculate delivery price
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

    #
    # calculate the required vehicle  based on price limit
    # calculate price based on vehicle and distance
    #
    post '/quotes/vehicle_by_price_limit' do

      quote = json_params['quote']

      #calculate basic variable price
      price_controller = PriceController.new
      basic_price = price_controller.calcul_basic_price(quote['pickup_postcode'], quote['delivery_postcode'])

      # find the required vehicle
      vehicle_controller = VehicleController.new
      vehicle = vehicle_controller.find_vehicle_by_price(quote['vehicle'], basic_price)

      # calculate delivery price
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


    #
    # the completed service
    # calculate the required vehicle based on products volumetrics
    # calculate price based on vehicle and distance
    #
    post '/quotes' do

      quote = json_params['quote']

      # calculate basic variable price
      price_controller = PriceController.new
      basic_price = price_controller.calcul_basic_price(quote['pickup_postcode'], quote['delivery_postcode'])

      # find the required vehicle based on price limt
      vehicle_controller = VehicleController.new
      vehicle_based_on_price = vehicle_controller.find_vehicle_by_price(quote['vehicle'], basic_price)

      # find the vehicle bases on products volumetrics
      vehicle = vehicle_controller.find_vehicle_by_products(quote['products'], vehicle_based_on_price)

      # calculate delivery price
      price_based_on_volumetrics = price_controller.price_based_on_vehicle(quote['pickup_postcode'], quote['delivery_postcode'], vehicle)

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          vehicle: vehicle.type,
          price: price_based_on_volumetrics
        }
      }.to_json
    end

    error 404 do
        halt 404 , { message:"Route Note Found" }.to_json
    end

  end
end
