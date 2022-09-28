require 'rails_helper'

describe 'Usuário vê modelos de produtos' do 
  it 'se estiver autenticado' do
    visit product_models_path
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    login_as(User.last)
    visit root_path
    within('nav') do 
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do 
    login_as(User.last)
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
    login_as(User.last)
    ProductModel.destroy_all
    visit product_models_path

    expect(page).to have_content 'Nenhum modelo de produto cadastrado' 
  end
end