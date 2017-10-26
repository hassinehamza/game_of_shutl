module GameOfShutl
  class Vehicle
    attr_accessor :type, :markup, :priceLimit, :nextVehicle

    def initialize(params)
      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

  end
end
