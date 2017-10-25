module GameOfShutl
  class VehicleController

    def initialize
      @listOfVehicle = {  "bicycle" => Vehicle.new('bicycle',0.1) ,
                          "motorbike" => Vehicle.new('motorbike', 0.15),
                          "parcel_car" => Vehicle.new('parcel_car', 0.2),
                          "small_van" => Vehicle.new('small_van', 0.3),
                          "large_van" => Vehicle.new('large_van', 0.4)
                        }
    end

    def getVehicle(type)
      vehicle =  @listOfVehicle[type]
      if vehicle == nil
        raise Exception.new("Vehicle is Nil ,We cannot found")
      end
      return vehicle
    end

  end
end
