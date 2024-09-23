require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new( product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))}

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a product_name' do
      subject.product_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a product_count' do
      subject.product_count = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a non-integer product_count' do
      subject.product_count = 3.5
      expect(subject).to_not be_valid
    end

    it 'is not valid with a product_count less than or equal to zero' do
      subject.product_count = 0
      expect(subject).to_not be_valid
    end

    it 'is not valid without a customer' do
      subject.customer = nil
      expect(subject).to_not be_valid
    end
  end
end