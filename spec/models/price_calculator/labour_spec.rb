require "rails_helper"

describe PriceCalculator::Labour, type: :model do
  describe "delegations", :delegation do
    it do
      calc = PriceCalculator::Labour.new(labour: nil, hours: nil)

      expect(calc).to delegate_method(:per_hour).to(:labour)
    end

    it do
      calc = PriceCalculator::Labour.new(labour: nil, hours: nil)

      expect(calc).to delegate_method(:mark_up).to(:labour)
    end
  end

  it "#cost" do
    labour = build(:labour, per_hour: 15.00)

    calc = PriceCalculator::Labour.new(labour: labour, hours: 3)

    expect(calc.cost).to eq(45)
  end

  context "normal job" do
    it "#envisage_price" do
      calc = PriceCalculator::Labour.new(labour: nil, hours: 3)
      allow(calc).to receive(:cost).and_return(100)
      allow(calc).to receive(:mark_up).and_return(200)

      expect(calc.envisage_price).to eq(200)
    end

    it "#envisage_trade_price" do
      calc = PriceCalculator::Labour.new(labour: nil, hours: 3)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_trade_price).to eq(90)
    end
    
    it "#envisage_to_my_price" do
      calc = PriceCalculator::Labour.new(labour: nil, hours: 3)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_to_my_price).to eq(80)
    end

    it "#my_price" do
      calc = PriceCalculator::Labour.new(labour: nil, hours: 3)
      allow(calc).to receive(:envisage_to_my_price).and_return(100)

      expect(calc.my_price).to eq(135)
    end
  end

  context "rush job" do
    it "#envisage_rush_price" do
      calc = PriceCalculator::Labour.new(labour: nil, hours: 3)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_rush_price).to eq(150)
    end

    it "#envisage_trade_rush_price" do
      calc = PriceCalculator::Labour.new(labour: nil, hours: 3)
      allow(calc).to receive(:envisage_trade_price).and_return(100)

      expect(calc.envisage_trade_rush_price).to eq(150)
    end

    it "#envisage_to_my_rush_price" do
      calc = PriceCalculator::Labour.new(labour: nil, hours: 3)
      allow(calc).to receive(:envisage_to_my_price).and_return(100)

      expect(calc.envisage_to_my_rush_price).to eq(150)
    end

    it "#my_rush_price" do
      calc = PriceCalculator::Labour.new(labour: nil, hours: 3)
      allow(calc).to receive(:my_price).and_return(100)

      expect(calc.my_rush_price).to eq(150)
    end
  end
end
