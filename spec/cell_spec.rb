require 'spec_helper'

module ConnectFour
  describe Cell do

    context "#initialize" do
      it "is initialized with a value of nil by default" do
        cell = Cell.new
        expect(cell.value).to be_nil
      end

      it "can be initialized with a value of 'X'" do
        cell = Cell.new("X")
        expect(cell.value).to eq "X"
      end
    end

  end  
end