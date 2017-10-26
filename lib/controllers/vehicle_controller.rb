module GameOfShutl
  class VehicleController
    FIRST_VEHICLE = 'bicycle'
    def initialize
      @listOfVehicle = {  'bicycle' => Vehicle.new(:type => 'bicycle',
                                                  :markup => 0.1,
                                                  :priceLimit => 500,
                                                  :nextVehicle => 'motorbike'),
                          'motorbike' => Vehicle.new(:type => 'motorbike',
                                                    :markup => 0.15,
                                                    :priceLimit => 750,
                                                    :nextVehicle => 'parcel_car'),
                          'parcel_car' => Vehicle.new(:type => 'parcel_car',
                                                      :markup => 0.2,
                                                      :priceLimit => 1000,
                                                      :nextVehicle => 'small_van'),
                          'small_van' => Vehicle.new(:type => 'small_van',
                                                    :markup => 0.3,
                                                    :priceLimit => 1500,
                                                    :nextVehicle =>  'large_van'),
                          'large_van' => Vehicle.new(:type => 'large_van',
                                                    :markup => 0.4,
                                                    :priceLimit =>  Float::INFINITY)
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
      vehicle = @listOfVehicle[vehicleType] ||= @listOfVehicle[FIRST_VEHICLE]
      while( price > vehicle.priceLimit)
        vehicle =  @listOfVehicle[vehicle.nextVehicle]
      end
      return vehicle
    end
  end
end
