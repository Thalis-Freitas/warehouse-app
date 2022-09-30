require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do  
    it 'data prevista para entrega deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: '')
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to be true
    end

    it 'data prevista para entrega não pode ser passada' do 
      order = Order.new(estimated_delivery_date: 1.day.ago)
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include ' deve ser futura'
    end

    it 'data prevista para entrega não pode ser igual a hoje' do 
      order = Order.new(estimated_delivery_date: Date.today)
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to be true
    end
    
    it 'data prevista para entrega deve ser igual ou maior que amanhã' do 
      order = Order.new(estimated_delivery_date: Date.tomorrow)
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to be false
    end

    it 'deve ter um código' do 
      warehouse = Warehouse.create!(name: 'Galpão da Avenida', code: 'POA', city: 'Porto Alegre', area: '60000',
                                    address: 'Avenida das Rosas, 10', zip_code: '52700-000',
                                    description: 'Galpão')
      supplier = Supplier.create!(corporate_name: 'Móveis Magalhães', brand_name: 'Maga Móveis', registration_number: '98836472000184',
                                  full_address: 'Rua da praça, 150', city: 'FSA', state: 'BA', email: 'magalhaes@moveis.com')
      user = User.create!(name: 'Marina', email: 'mari@email.com', password: 'password')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user,
                        estimated_delivery_date: '2028-11-02')
      expect(order.valid?).to be true
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do 
      warehouse = Warehouse.create!(name: 'Galpão da Avenida', code: 'POA', city: 'Porto Alegre', area: '60000',
                                    address: 'Avenida das Rosas, 10', zip_code: '52700-000',
                                    description: 'Galpão')
      supplier = Supplier.create!(corporate_name: 'Móveis Magalhães', brand_name: 'Maga Móveis', registration_number: '98836472000184',
                                  full_address: 'Rua da praça, 150', city: 'FSA', state: 'BA', email: 'magalhaes@moveis.com')  
      user = User.create!(name: 'Marina', email: 'mari@email.com', password: 'password')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user,
                        estimated_delivery_date: '2028-11-02')
      order.save!
      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 10
    end

    it 'e o código é único' do 
      warehouse = Warehouse.create!(name: 'Galpão da Avenida', code: 'POA', city: 'Porto Alegre', area: '60000',
                                      address: 'Avenida das Rosas, 10', zip_code: '52700-000',
                                      description: 'Galpão')
      supplier = Supplier.create!(corporate_name: 'Móveis Magalhães', brand_name: 'Maga Móveis', registration_number: '98836472000184',
                                    full_address: 'Rua da praça, 150', city: 'FSA', state: 'BA', email: 'magalhaes@moveis.com')
      user = User.create!(name: 'Marina', email: 'mari@email.com', password: 'password')
      order = Order.create!(warehouse: warehouse, supplier: supplier, user: user,
                          estimated_delivery_date: '2028-11-02')
      second_order = Order.new(warehouse: warehouse, supplier: supplier, user: user,
                          estimated_delivery_date: '2029-05-12')
      second_order.save!
      expect(second_order.code).not_to eq order.code
    end
  end
end
