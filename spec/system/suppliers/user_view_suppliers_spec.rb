require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    visit root_path 
    within('nav') do 
      click_on 'Fornecedores'
    end
    
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do 
    visit suppliers_path
  
    expect(page).not_to have_content 'Não existem fornecedores cadastrados'
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'São Paulo - SP'
  end

  it 'e não existem fornecedores cadastrados' do 
    Supplier.destroy_all
    visit suppliers_path
    
    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end
end