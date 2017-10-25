module GameOfShutl
  class Price

    def calculBasicPrice(pickup_postcode, delivery_postcode)
      price = ((pickup_postcode.to_i(36) - delivery_postcode.to_i(36))/1000).abs
    end

    def priceBasedOnVehicle(pickup_postcode, delivery_postcode, vehicle)
      basicprice = calculBasicPrice(pickup_postcode, delivery_postcode)
      price =  basicprice + basicprice * vehicle.markup
    end
  end
end
