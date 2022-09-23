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
    visit root_path 
    click_on 'Fornecedores'
    
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
  end

  it 'e não existem fornecedores cadastrados' do 
    Supplier.destroy_all

    visit root_path 
    click_on 'Fornecedores'

    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end
end