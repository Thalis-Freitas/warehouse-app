require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do 
    it 'ao criar um produto em estoque' do 
      warehouse = Warehouse.create!(name: 'Galpão da Avenida', code: 'POA', city: 'Porto Alegre', area: '60000',
                                    address: 'Avenida das Rosas, 10', zip_code: '52700-000',
                                    description: 'Galpão')
      supplier = Supplier.create!(corporate_name: 'Móveis Magalhães', brand_name: 'Maga Móveis', registration_number: '98836472000184',
                                  full_address: 'Rua da praça, 150', city: 'FSA', state: 'BA', email: 'magalhaes@moveis.com')  
      user = User.create!(name: 'Marina', email: 'mari@email.com', password: 'password')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user,
                        estimated_delivery_date: Date.tomorrow, status: :delivered)
      product = ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                                     sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length). to eq 20
    end

    it 'e não é modificado' do
      warehouse = Warehouse.create!(name: 'Galpão da Avenida', code: 'POA', city: 'Porto Alegre', area: '60000',
                                    address: 'Avenida das Rosas, 10', zip_code: '52700-000',
                                    description: 'Galpão')
      second_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                           address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                           description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Móveis Magalhães', brand_name: 'Maga Móveis', registration_number: '98836472000184',
                                  full_address: 'Rua da praça, 150', city: 'FSA', state: 'BA', email: 'magalhaes@moveis.com')  
      user = User.create!(name: 'Marina', email: 'mari@email.com', password: 'password')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user,
                        estimated_delivery_date: Date.tomorrow, status: :delivered)
      product = ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                                     sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number

      stock_product.update(warehouse: second_warehouse)

      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
