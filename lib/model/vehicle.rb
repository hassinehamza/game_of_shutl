module GameOfShutl
  class Vehicle
    attr_reader :type, :markup

    def initialize(type, markup)
      @type = type
      @markup = markup
    end

    def type
      @type
    end
  end
end
