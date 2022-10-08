require 'rails_helper'

describe 'Usuário busca por um pedido' do 
  it 'se estiver autenticado' do 
    visit root_path

    within('header nav') do 
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end
  
  it 'a partir do menu' do
    user = User.create(name:'Julia', email:'julia@email.com', password:'password')
  
    login_as(user)
    visit root_path

    within('header nav') do 
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e encontra o pedido' do 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da Busca por #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung'
  end

  it 'e encontra múltiplos pedidos' do
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    second_warehouse = Warehouse.create!(name: 'Armazém BA', code: 'SSA', city: 'Salvador', area: '90000',
                                    address: 'Avenida do Aeroporto, 200', zip_code: '32100-000',
                                    description: 'Galpão destinado para estoque de cargas')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU1234567')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU9876543')
    second_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                 estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SSA0000000')
    third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'

    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content'GRU1234567'
    expect(page).to have_content'GRU9876543'
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).not_to have_content'SSA0000000'
    expect(page).not_to have_content 'Galpão Destino: SSA | Armazém BA'
  end

  it 'sem preencher o campo' do 
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: ''
    click_on 'Buscar'
    expect(page).to have_content 'É necessário preencher o campo para realizar a busca'
  end
  
  it 'e não encontra nenhum pedido' do
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'SKD'
    click_on 'Buscar'

    expect(page).to have_content 'Nenhum pedido encontrado'
  end
end