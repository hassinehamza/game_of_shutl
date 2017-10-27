module GameOfShutl
  class Vehicle
    attr_accessor :type, :markup, :price_limit, :next_vehicle, :capacity

    def initialize(params)
      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

  end
end
