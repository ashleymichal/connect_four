require 'spec_helper'

module ConnectFour
  describe Player do
    before :each do
      @input = { color: :red, name: "Ashley" }
    end

    context "#initialize" do
      it "raises an exception when initialized with {}" do
        expect { Player.new({}) }.to raise_error(KeyError)
      end

      it "does not raise an exception when initialized with a valid Hash" do
        expect { Player.new(@input) }.not_to raise_error
      end
    end

    context "#color" do
      it "returns the color" do
        player = Player.new(@input)
        expect(player.color).to eq :red
      end
    end

    context "#name" do
      it "returns the name" do
        player = Player.new(@input)
        expect(player.name).to eq "Ashley"
      end
    end

  end
end