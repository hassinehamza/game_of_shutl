module GameOfShutl
  class PriceController

    def calcul_basic_price(pickup_postcode, delivery_postcode)
      price = ((pickup_postcode.to_i(36) - delivery_postcode.to_i(36))/1000).abs
    end

    def price_based_on_vehicle(pickup_postcode, delivery_postcode, vehicle)
      basic_price =calcul_basic_price(pickup_postcode, delivery_postcode)
      price_based_on_vehicle =  basic_price + basic_price * vehicle.markup
    end
  end
end
