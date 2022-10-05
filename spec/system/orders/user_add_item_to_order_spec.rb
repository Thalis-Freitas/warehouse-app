require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                                     sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)
    product_b = ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                     sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Notebook 05', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Notebook 05'
  end

  it 'e não vê produtos de outro fornecedor' do
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier_a = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    supplier_b = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                                  full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, 
                          estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                                     sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier_a)
    product_b = ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                     sku: 'TV4000-ACME0-XPBA760', supplier: supplier_b)
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'Notebook 05'
    expect(page).not_to have_content 'TV 40'
  end
  
  it 'com quantidade menor ou igual a zero' do 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    product = ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                                     sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)

    login_as user
    visit new_order_order_item_path(order_id: order.id)
    fill_in 'Quantidade', with: '0'
    click_on 'Gravar'

    expect(page).not_to have_content 'Item adicionado com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar o item'
    expect(page).to have_content 'Quantidade deve ser maior que 0'
  end
end