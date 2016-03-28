module ConnectFour
  ROWS = 6
  COLUMNS = 7

  class Board
    attr_accessor :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end    

    def formatted_grid
      grid.each do |row|
        puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
      end
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
        winning_positions.each do |winning_position|
          next if winning_position_values(winning_position).all_empty?
          return true if winning_position_values(winning_position).all_same?
        end
        false
      end

      def draw?
        grid.flatten.map { |cell| cell.value }.none_empty?
      end

      def winning_positions
        grid +
        grid.transpose# +
        # TODO diagonals
      end

      def winning_position_values(winning_position)
        winning_position.map { |cell| cell.value }
      end

      def diagonals
        # TODO
      end

  end
end