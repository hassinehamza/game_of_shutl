module GameOfShutl
  class Product
    attr_accessor :weight, :width, :height, :length

    def initialize(params)
      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

  end
end
