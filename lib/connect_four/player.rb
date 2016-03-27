module ConnectFour
  class Player
    attr_reader :name, :color
    def initialize(input)
      @color = input.fetch(:color)
      @name = input.fetch(:name)
    end
  end
end