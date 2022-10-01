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
                        estimated_delivery_date: 1.week.from_now)
      expect(order.valid?).to be true
    end

    it 'deve pertencer a um galpão' do
      supplier = Supplier.create!(corporate_name: 'Móveis Magalhães', brand_name: 'Maga Móveis', registration_number: '98836472000184',
                                  full_address: 'Rua da praça, 150', city: 'FSA', state: 'BA', email: 'magalhaes@moveis.com')
      user = User.create!(name: 'Marina', email: 'mari@email.com', password: 'password')
      order = Order.new(supplier: supplier, user: user, estimated_delivery_date: 1.week.from_now)
      order.valid?
      expect(order.errors.include? :warehouse).to be true
      expect(order.errors[:warehouse]).to include 'é obrigatório(a)'
    end

    it 'deve pertencer a um fornecedor' do
      warehouse = Warehouse.create!(name: 'Galpão da Avenida', code: 'POA', city: 'Porto Alegre', area: '60000',
                                    address: 'Avenida das Rosas, 10', zip_code: '52700-000', description: 'Galpão')
      user = User.create!(name: 'Marina', email: 'mari@email.com', password: 'password')
      order = Order.new(warehouse: warehouse, user: user, estimated_delivery_date: 1.week.from_now)
      order.valid?
      expect(order.errors.include? :supplier).to be true
      expect(order.errors[:supplier]).to include 'é obrigatório(a)'
    end

    it 'deve pertencer a um usuário' do
      warehouse = Warehouse.create!(name: 'Galpão da Avenida', code: 'POA', city: 'Porto Alegre', area: '60000',
                                    address: 'Avenida das Rosas, 10', zip_code: '52700-000', description: 'Galpão')
      supplier = Supplier.create!(corporate_name: 'Móveis Magalhães', brand_name: 'Maga Móveis', registration_number: '98836472000184',
                                  full_address: 'Rua da praça, 150', city: 'FSA', state: 'BA', email: 'magalhaes@moveis.com')
      order = Order.new(warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
      order.valid?
      expect(order.errors.include? :user).to be true
      expect(order.errors[:user]).to include 'é obrigatório(a)'
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
                        estimated_delivery_date: Date.tomorrow)
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
                          estimated_delivery_date: 1.day.from_now)
      second_order = Order.new(warehouse: warehouse, supplier: supplier, user: user,
                          estimated_delivery_date: 1.month.from_now)
      second_order.save!
      expect(second_order.code).not_to eq order.code
    end
  end
end
