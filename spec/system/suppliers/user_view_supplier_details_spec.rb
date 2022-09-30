require 'rails_helper'

describe 'Usuário vê detalhes de um forcenedor' do
  it 'e vê informações adicionais' do 
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                     full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')

    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 34.472.163/0001-02'
    expect(page).to have_content 'Endereço: Avenida das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com' 
  end

  it 'e volta para a tela inicial' do 
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                     full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    
    login_as(user)
    visit suppliers_path
    click_on 'ACME'
    click_link 'Galpões & Estoque'

    expect(current_path).to eq root_path 
  end
end