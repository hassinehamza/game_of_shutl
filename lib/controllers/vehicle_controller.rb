module GameOfShutl
  class VehicleController
  
    SMALLEST_VEHICLE = 'bicycle'

    def initialize
      @listOfVehicle = {  'bicycle' => Vehicle.new(:type => 'bicycle',
                                                  :markup => 0.1,
                                                  :priceLimit => 500,
                                                  :nextVehicle => 'motorbike',
                                                  :capacity => Product.new(:weight => 3,
                                                                           :width =>30,
                                                                           :height =>25,
                                                                           :length =>10)),
                          'motorbike' => Vehicle.new(:type => 'motorbike',
                                                    :markup => 0.15,
                                                    :priceLimit => 750,
                                                    :nextVehicle => 'parcel_car',
                                                    :capacity => Product.new(:weight => 6,
                                                                             :width =>35,
                                                                             :height =>25,
                                                                             :length =>25)),
                          'parcel_car' => Vehicle.new(:type => 'parcel_car',
                                                      :markup => 0.2,
                                                      :priceLimit => 1000,
                                                      :nextVehicle => 'small_van',
                                                      :capacity => Product.new(:weight => 50,
                                                                               :width =>110,
                                                                               :height =>100,
                                                                               :length =>75)),
                          'small_van' => Vehicle.new(:type => 'small_van',
                                                    :markup => 0.3,
                                                    :priceLimit => 1500,
                                                    :nextVehicle =>  'large_van',
                                                    :capacity => Product.new(:weight => 400,
                                                                             :width => 133,
                                                                             :height => 133,
                                                                             :length => 133)),
                          'large_van' => Vehicle.new(:type => 'large_van',
                                                    :markup => 0.4,
                                                    :priceLimit =>  Float::INFINITY,
                                                    :capacity => Product.new(:weight => Float::INFINITY,
                                                                             :width => Float::INFINITY,
                                                                             :height => Float::INFINITY,
                                                                             :length => Float::INFINITY))
                        }
    end

    def getVehicle(type)
      vehicle = @listOfVehicle[type]
      if vehicle == nil
        raise Exception.new("Vehicle is Nil ,We cannot found")
      end
      return vehicle
    end

    def findVehicleByPrice(vehicleType, price)
      vehicle = @listOfVehicle[vehicleType] ||= @listOfVehicle[SMALLEST_VEHICLE]
      while( price > vehicle.priceLimit)
        vehicle =  @listOfVehicle[vehicle.nextVehicle]
      end
      return vehicle
    end
  end
end
