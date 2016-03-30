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
        puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" | ")
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
        runs = grid + grid.transpose +
          [grid, grid.transpose].map { |grid| diagonals(grid) }.flatten(1)
        runs.map { |run| run.each_cons(4).to_a }.flatten(1)
      end

      def diagonals(local_grid)
        rows = local_grid.length
        columns = local_grid[0].length
        i = 0; j = 0
        diagonals = []
        until local_grid[i].nil? || local_grid[i][j].nil?
          # run = []
          start_cell = [i, j]
          run = (0..columns-1).map do |offset| 
            # begin
              local_grid[i-offset][j+offset]
            # rescue
            #   break
            # end
          end
          # until i < 0 or j == columns
          #   run << local_grid[i][j]
          #   i -= 1; j += 1
          # end
          diagonals << run
          i, j = start_cell
          start_cell[0] == rows - 1 ? j += 1 : i += 1
        end
        diagonals.map { |run| run.compact }.select { |run| run.length >= 4 }
      end

      def winning_position_values(winning_position)
        winning_position.map { |cell| cell.value }
      end

  end
end