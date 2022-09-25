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
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', 
                     registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                     city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')

    visit root_path 
    click_on 'Fornecedores'
  
    expect(page).not_to have_content 'Não existem fornecedores cadastrados'
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
    expect(page).to have_content 'Spark'
    expect(page).to have_content 'Teresina - PI'
  end

  it 'e não existem fornecedores cadastrados' do 
    Supplier.destroy_all

    visit root_path 
    click_on 'Fornecedores'

    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end
end