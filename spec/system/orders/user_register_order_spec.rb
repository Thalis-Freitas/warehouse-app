require 'rails_helper'

describe 'Usuário cadastra um pedido' do 
  it 'se estiver autenticado' do
    visit new_order_path
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                      address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                     registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                     city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                     full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')

    login_as(user)
    visit root_path
    within('nav') do 
      click_on 'Registrar Pedido'
    end
    select 'GRU | Aeroporto SP', from: 'Galpão Destino'
    select 'ACME LTDA | SP', from: 'Fornecedor'
    fill_in 'Previsão de Entrega', type: 'date', with: Date.tomorrow
    click_on 'Salvar'

    expect(page).to have_content 'Pedido ABC1234567'
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA | SP'
    expect(page).to have_content 'Usuário Responsável: Lucas <lucas@email.com>'
    expect(page).to have_content "Previsão de Entrega: #{I18n.l(Date.tomorrow)}"
    expect(page).not_to have_content 'Armazém SSA'
    expect(page).not_to have_content 'Samsung Eletrônicos LTDA'
  end
end