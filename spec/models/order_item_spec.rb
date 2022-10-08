require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid?' do  
    it 'quantidade deve ser maior que 0' do
      order_item = OrderItem.new(quantity: '0')
      order_item.valid?
      expect(order_item.errors.include? :quantity).to be true
      expect(order_item.errors[:quantity]).to include 'deve ser maior que 0'
    end
  end
end
