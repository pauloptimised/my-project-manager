require 'rails_helper'

RSpec.describe SundryItem, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:print_job) }
  end

  it { should delegate_method(:quoted?).to(:print_job) }

  describe "associations", :association do
    it { should belong_to(:print_job) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      sundry_item = build_stubbed(:sundry_item)
      expect(sundry_item.price_calculator).to be_an_instance_of(PriceCalculator::SundryItem)
    end

    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
  end
end
