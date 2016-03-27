module ConnectFour
  ROWS = 6
  COLUMNS = 7

  class Board
    attr_accessor :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    def get_cell(x, y)
      grid[x][y]
    end

    def set_cell(x, y, value)
      get_cell(x, y).value = value
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    private

      def default_grid
        Array.new(ROWS) { Array.new(COLUMNS) { Cell.new } }
      end

      def winner?
      end

      def draw?
      end

  end
end