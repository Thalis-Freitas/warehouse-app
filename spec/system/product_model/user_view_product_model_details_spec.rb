require 'rails_helper'

describe 'Usuário vê detalhes dos modelos de produto' do
  it 'a partir do fornecedor' do 
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
    ProductModel.destroy_all

    visit suppliers_path
    click_on 'Samsung'

    expect(page).not_to have_content 'Modelos de produtos cadastrados'
    expect(page).to have_content 'Nenhum modelo de produto cadastrado para este fornecedor'
  end
end