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
    end

    context "#initialize" do
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
        expected = "Ashley: Enter a column number between 1 and 7."
      end
    end

  end

end