require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'se estiver autenticado' do
    visit suppliers_path
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    login_as(user)
    visit root_path 
    within('nav') do 
      click_on 'Fornecedores'
    end
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do 
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                     full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                     registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                     city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')

    login_as(user)
    visit suppliers_path
  
    expect(page).not_to have_content 'Não existem fornecedores cadastrados'
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'São Paulo - SP'
  end

  it 'e não existem fornecedores cadastrados' do 
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    login_as(user)
    visit suppliers_path
    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end
end