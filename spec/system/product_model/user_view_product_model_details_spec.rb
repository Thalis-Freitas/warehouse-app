require 'rails_helper'

describe 'Usuário vê detalhes dos modelos de produto' do
  it 'se estiver autenticado' do
    visit suppliers_path
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do fornecedor' do 
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                         sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)         
    ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                         sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')

    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Samsung'
  
    expect(page).to have_content 'Fornecedor Samsung'
    expect(page).to have_content 'Modelos de produtos cadastrados'
    expect(page).to have_content 'TV 40'
    expect(page).to have_content 'SKU: TV4000-SAMSU-XPBA760'
    expect(page).to have_content 'Dimensões: 49cm x 101cm x 8cm'
    expect(page).to have_content 'Peso: 6300g'
    expect(page).to have_content 'Notebook 05'
    expect(page).to have_content 'SKU: NOTE05-SAMSU-FL703DT'
    expect(page).to have_content 'Dimensões: 38cm x 22cm x 2cm'
    expect(page).to have_content 'Peso: 1800g'
  end

  it 'e não existem modelos de produtos cadastrados para o fornecedor' do 
    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                     registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                     city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')

    login_as(user)
    visit suppliers_path
    click_on 'Samsung'

    expect(page).not_to have_content 'Modelos de produtos cadastrados'
    expect(page).to have_content 'Nenhum modelo de produto cadastrado para este fornecedor'
  end
end