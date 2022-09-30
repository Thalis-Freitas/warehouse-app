require 'rails_helper'

describe 'Usuário vê modelos de produtos' do 
  it 'se estiver autenticado' do
    visit product_models_path
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    login_as(user)
    visit root_path
    within('nav') do 
      click_on 'Modelos de Produtos'
    end
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do 
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                     full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                         sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
    ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                         sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    
    login_as(user)
    visit product_models_path

    expect(page).not_to have_content 'Nenhum modelo de produto cadastrado'
    expect(page).to have_content 'TV 40'
    expect(page).to have_content 'SKU: TV4000-SAMSU-XPBA760'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'Notebook 05'
    expect(page).to have_content 'SKU: NOTE05-SAMSU-FL703DT'
    expect(page).to have_content 'Fornecedor: Samsung'
  end

  it 'e não existem produtos cadastrados' do 
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    login_as(user)
    visit product_models_path
    expect(page).to have_content 'Nenhum modelo de produto cadastrado' 
  end
end