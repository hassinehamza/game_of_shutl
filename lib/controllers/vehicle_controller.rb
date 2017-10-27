module GameOfShutl
  class VehicleController

    SMALLEST_VEHICLE = 'bicycle'

    def initialize
      #liste of vehicle with their properties
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

    #
    # method returns a vehicle object based on its type
    #
    def get_vehicle(type)
      vehicle = @list_vehicles[type]
      #raise exception if vehicle is not in the list
      if vehicle == nil
        raise Exception.new("Vehicle is Nil ,We cannot found it")
      end
      return vehicle
    end

    #
    # methods returns a vehicle object that satisfies the price_limit
    #
    def find_vehicle_by_price(vehicle_type, price)
      vehicle = @list_vehicles[vehicle_type] ||= @list_vehicles[SMALLEST_VEHICLE]
      while( price > vehicle.price_limit)
        vehicle =  @list_vehicles[vehicle.next_vehicle]
      end
      return vehicle
    end

    #
    # methods returns a vehicle that satifies products volumetrics
    # => @attribute products : an array of hash
    # => @attribute basic_veh : is an optional attribute
    #
    def find_vehicle_by_products(products, basic_veh = nil)
      # vehicle is initialized basic_veh if it is specifed
      # otherwise vehicle is initialized as SMALLEST_VEHICLE
      vehicle = basic_veh ||= @list_vehicles[SMALLEST_VEHICLE]
      weight, width, height, length = 0, 0, 0, 0
      # we assume that the volumetrics are simply to be summed together
      products.each do |product|
        weight += product['weight']
        width += product['width']
        height += product['height']
        length += product['length']
      end
      while(vehicle.capacity.weight < weight && vehicle.capacity.width < width &&
            vehicle.capacity.height < height && vehicle.capacity.weight < weight)
            vehicle = @list_vehicles[vehicle.next_vehicle]
      end
      return vehicle
    end

  end
end
