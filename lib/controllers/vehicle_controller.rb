module GameOfShutl
  class VehicleController

    SMALLEST_VEHICLE = 'bicycle'

    def initialize
      @list_vehicles = {  'bicycle' => Vehicle.new(:type => 'bicycle',
                                                  :markup => 0.1,
                                                  :price_limit => 500,
                                                  :next_vehicle => 'motorbike',
                                                  :capacity => Product.new(:weight => 3,
                                                                           :width =>30,
                                                                           :height =>25,
                                                                           :length =>10)),
                          'motorbike' => Vehicle.new(:type => 'motorbike',
                                                    :markup => 0.15,
                                                    :price_limit => 750,
                                                    :next_vehicle => 'parcel_car',
                                                    :capacity => Product.new(:weight => 6,
                                                                             :width =>35,
                                                                             :height =>25,
                                                                             :length =>25)),
                          'parcel_car' => Vehicle.new(:type => 'parcel_car',
                                                      :markup => 0.2,
                                                      :price_limit => 1000,
                                                      :next_vehicle => 'small_van',
                                                      :capacity => Product.new(:weight => 50,
                                                                               :width =>110,
                                                                               :height =>100,
                                                                               :length =>75)),
                          'small_van' => Vehicle.new(:type => 'small_van',
                                                    :markup => 0.3,
                                                    :price_limit => 1500,
                                                    :next_vehicle =>  'large_van',
                                                    :capacity => Product.new(:weight => 400,
                                                                             :width => 133,
                                                                             :height => 133,
                                                                             :length => 133)),
                          'large_van' => Vehicle.new(:type => 'large_van',
                                                    :markup => 0.4,
                                                    :price_limit =>  Float::INFINITY,
                                                    :capacity => Product.new(:weight => Float::INFINITY,
                                                                             :width => Float::INFINITY,
                                                                             :height => Float::INFINITY,
                                                                             :length => Float::INFINITY))
                        }
    end

    def get_vehicle(type)
      vehicle = @list_vehicles[type]
      if vehicle == nil
        raise Exception.new("Vehicle is Nil ,We cannot found")
      end
      return vehicle
    end

    def find_vehicle_by_price(vehicle_type, price)
      vehicle = @list_vehicles[vehicle_type] ||= @list_vehicles[SMALLEST_VEHICLE]
      while( price > vehicle.price_limit)
        vehicle =  @list_vehicles[vehicle.next_vehicle]
      end
      return vehicle
    end

  end
end
