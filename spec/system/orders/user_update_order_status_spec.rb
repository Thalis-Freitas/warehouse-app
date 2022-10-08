require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    product = ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                   sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now, status: :pending)
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Entregue'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue' 
    expect(page).not_to have_button 'Cancelado'
    expect(page).not_to have_button 'Entregue'
    expect(StockProduct.count).to eq 5
    expect(StockProduct.where(product_model: product, warehouse: warehouse).count).to eq 5
  end

  it 'e pedido foi cancelado' do 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    product = ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                   sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now, status: :pending)
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Cancelado'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Situação do Pedido: Cancelado'     
    expect(StockProduct.count).to eq 0
  end
end