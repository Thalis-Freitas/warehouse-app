require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do 
  it 'se estiver autenticado' do 
    visit root_path

    within('header nav') do 
      expect(page).not_to have_link 'Meus Pedidos'
    end
  end

  it 'e não vê outros pedidos' do 
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    other_user = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: other_user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.week.from_now)
    third_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 3.day.from_now)
    
    login_as user
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content order.code
    expect(page).to have_content third_order.code
    expect(page).not_to have_content second_order.code
  end

  it 'e visita um pedido' do 
    user = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: Date.tomorrow)
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung Eletrônicos LTDA'
    expect(page).to have_content "Previsão de Entrega: #{I18n.l(Date.tomorrow)}"
  end

  it 'e não visita pedidos de outros usuários' do 
    user = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
    other_user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'pass1234')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: Date.tomorrow)
    login_as other_user
    visit order_path(order)

    expect(current_path).not_to eq order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido'
  end
end