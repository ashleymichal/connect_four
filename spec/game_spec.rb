require 'spec_helper'

module ConnectFour

  describe Game do

    let (:ashley) { Player.new({color: :red, name: "Ashley"}) }
    let (:ben) { Player.new({color: :blue, name: "Ben"}) }

    context "#initialize" do
      it "randomly selects a current_player" do
        allow_any_instance_of(Array).to receive(:shuffle) { [ashley, ben] }
        game = Game.new([ashley, ben])
        expect(game.current_player).to eq ashley
      end
      
      it "randomly selects an other_player" do
        allow_any_instance_of(Array).to receive(:shuffle) { [ashley, ben] }
        game = Game.new([ashley, ben])
        expect(game.other_player).to eq ben
      end
    end

    context "#switch_players" do
      it "will set @current_player to @other_player" do
        game = Game.new([ashley, ben])
        other_player = game.other_player
        game.switch_players
        expect(game.current_player).to eq other_player
      end
     
      it "will set @other_player to @current_player" do
        game = Game.new([ashley, ben])
        current_player = game.current_player
        game.switch_players
        expect(game.other_player).to eq current_player
      end
    end

    context "#solicit_move" do
      it "asks the player to make a move" do
        game = Game.new([ashley, ben])
        allow(game).to receive(:current_player) { ashley }
        expected = "Ashley: Enter a column number between 1 and 7 to make a move"
      end
    end

    context "#get_move" do
      it "converts human_move of '1' to '0'" do
        game = Game.new([ashley, ben])
        expect(game.get_move("1")).to eq 0
      end

      it "converts human_move of '7' to '6'" do
        game = Game.new([ashley, ben])
        expect(game.get_move("7")).to eq 6
      end
    end

    context "#game_over_message" do
      it "returns '{current player name} won!' if board shows a winner" do
        game = Game.new([ashley, ben])
        allow(game).to receive(:current_player) { ashley }
        allow(game.board).to receive(:game_over) { :winner }
        expect(game.game_over_message).to eq "Ashley won!"
      end
     
      it "returns 'The game ended in a tie' if board shows a draw" do
        game = Game.new([ashley, ben])
        allow(game).to receive(:current_player) { ashley }
        allow(game.board).to receive(:game_over) { :draw }
        expect(game.game_over_message).to eq "The game ended in a tie"
      end
    end

  end

end