require 'rails_helper'

describe 'Usuário vê modelos de produtos' do 
  it 'a partir do menu' do
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
    ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                         sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
    ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 35, height: 38, depth: 2,
                          sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)

    visit root_path
    click_on 'Modelos de Produtos'

    expect(page).not_to have_content 'Nenhum modelo de produto cadastrado'
    expect(page).to have_content 'TV 40'
    expect(page).to have_content 'SKU: TV4000-SAMSU-XPBA760'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'Notebook 05'
    expect(page).to have_content 'SKU: NOTE05-SAMSU-FL703DT'
    expect(page).to have_content 'Fornecedor: Samsung'
  end

  it 'e não existem produtos cadastrados' do 
    visit root_path
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Nenhum modelo de produto cadastrado' 
  end
end