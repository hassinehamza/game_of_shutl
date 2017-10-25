module GameOfShutl
  class VehicleController

    def initialize
      @listOfVehicle = {  "bicycle" => Vehicle.new(:type => 'bicycle', :markup => 0.1) ,
                          "motorbike" => Vehicle.new(:type => 'motorbike', :markup => 0.15),
                          "parcel_car" => Vehicle.new(:type => 'parcel_car', :markup => 0.2),
                          "small_van" => Vehicle.new(:type => 'small_van', :markup => 0.3),
                          "large_van" => Vehicle.new(:type => 'large_van', :markup => 0.4)
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
