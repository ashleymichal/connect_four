module ConnectFour
  ROWS = 6
  COLUMNS = 7

  class Board
    attr_accessor :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end    

    # TODO: rewrite to reflect column/row orientation for ConnectFour
    def formatted_grid
      grid.transpose.reverse.each do |row|
        puts row.map { |cell| cell.value.nil? ? empty_slot : cell.value }.join(" | ")
      end
    end

    def get_cell(x, y)
      grid[x][y]
    end

    def first_empty_cell(column)
      grid[column].find_index { |cell| cell.value.nil? }
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
        Array.new(COLUMNS) { Array.new(ROWS) { Cell.new } }
      end

      def empty_slot
        "\u25EF".encode('utf-8')
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
        runs = grid + grid.transpose +
          [grid, grid.reverse].map { |grid| diagonals(grid) }.flatten(1)
        runs.map { |run| run.each_cons(4).to_a }.flatten(1)
      end

      def diagonals(grid)
        shifted_grid = []
        grid.each_with_index do |row, index|
          shifted_grid << Array.new(index) + row + Array.new(grid.size - index)
        end
        shifted_grid.transpose.map { |diagonal| diagonal.compact }
      end

      def winning_position_values(winning_position)
        winning_position.map { |cell| cell.value }
      end

  end
end