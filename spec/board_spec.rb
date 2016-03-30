require 'spec_helper'

module ConnectFour

  describe Board do

    context "#initialize" do
      it "initializes the board with a grid" do
        expect { Board.new(grid: "grid") }.not_to raise_error
      end

      # dropping pieces is easier with columns of rows
      it "sets the grid with default number of columns" do
        board = Board.new
        expect(board.grid).to have(COLUMNS).things
      end

      it "sets the grid with default numnber of rows" do
        board = Board.new
        ROWS.times do |column|
          expect(board.grid[column]).to have(ROWS).things
        end
      end
    end

    context "#grid" do
      it "returns the grid" do
        board = Board.new(grid: "blah")
        expect(board.grid).to eq "blah"
      end
    end

    context "#get_cell" do
      it "returns the cell based on (x,y) coordinate" do
        grid = [["","",""],["","Barbie",""],["","",""]]
        board = Board.new(grid: grid)
        expect(board.get_cell(1,1)).to eq "Barbie"
      end
    end

    context "#set_cell" do
      it "updates the value of the cell object at (x, y) coordinates" do
        Cat = Struct.new(:value)
        grid = [[Cat.new("cool"),"",""],["","",""],["","",""]]
        board = Board.new(grid: grid)
        board.set_cell(0, 0, "meow")
        expect(board.get_cell(0, 0).value).to eq "meow"
      end
    end

    TestCell = Struct.new(:value)
    let(:x_cell) { TestCell.new("X") }
    let(:y_cell) { TestCell.new("Y") }
    let(:empty) { TestCell.new }
    context "#game_over" do
      it "returns :winner if winner? is true" do
        board = Board.new
        allow(board).to receive(:winner?) { true }
        expect(board.game_over).to eq :winner
      end

      it "returns :draw if winner? is false and draw? is true" do
        board = Board.new
        allow(board).to receive(:winner?) { false }
        allow(board).to receive(:draw?) { true }
        expect(board.game_over).to eq :draw
      end

      it "returns false if winner? is false and draw? is false" do
        board = Board.new
        allow(board).to receive(:winner?) { false }
        allow(board).to receive(:draw?) { false }
        expect(board.game_over).to be false
      end

      # TODO: rewrite tests to use ConnectFour board format
      it "returns :winner when row has 4 consecutive objects with values that are all the same" do
        grid = [
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, x_cell, empty,  empty,  x_cell, empty,  empty],
          [empty, x_cell, x_cell, x_cell, x_cell, x_cell, empty],
          [empty, y_cell, x_cell, x_cell, y_cell, y_cell, x_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
     
      it "returns :winner when column has 4 consecutive objects with values that are all the same" do
        grid = [
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, x_cell, empty,  empty,  empty,  empty,  empty],
          [empty, x_cell, empty,  empty,  x_cell, empty,  empty],
          [empty, x_cell, x_cell, y_cell, x_cell, x_cell, empty],
          [empty, x_cell, x_cell, x_cell, y_cell, y_cell, x_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
     
      it "returns :winner when diagonal has 4 consecutive objects with values that are all the same" do
        grid = [
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, empty,  empty,  empty,  empty,  x_cell, empty],
          [empty, x_cell, empty,  empty,  x_cell, y_cell, empty],
          [empty, x_cell, x_cell, x_cell, y_cell, x_cell, empty],
          [empty, y_cell, x_cell, x_cell, y_cell, y_cell, x_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
        grid.map { |row| row.reverse }
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
     
      it "returns :draw when all spaces on the board are taken" do
        grid = [
          [x_cell, y_cell, x_cell, y_cell, x_cell, y_cell, x_cell],
          [x_cell, y_cell, x_cell, y_cell, x_cell, y_cell, x_cell],
          [y_cell, x_cell, y_cell, x_cell, y_cell, x_cell, y_cell],
          [y_cell, x_cell, y_cell, x_cell, y_cell, x_cell, y_cell],
          [x_cell, y_cell, x_cell, y_cell, x_cell, y_cell, x_cell],
          [x_cell, y_cell, x_cell, y_cell, x_cell, y_cell, x_cell]
        ]
        board = Board.new(grid: grid)
        # binding.pry
        expect(board.game_over).to eq :draw
      end
     
      it "returns false when there is no winner or draw" do
        grid = [
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, empty,  empty,  empty,  empty,  empty,  empty],
          [empty, x_cell, empty,  empty,  empty,  empty,  empty],
          [empty, x_cell, empty,  empty,  x_cell, empty,  empty],
          [empty, y_cell, x_cell, y_cell, x_cell, x_cell, empty],
          [empty, x_cell, x_cell, x_cell, y_cell, y_cell, x_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to be false
      end
    end
  end
  
end