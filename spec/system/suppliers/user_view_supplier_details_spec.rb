require 'rails_helper'

describe 'Usuário vê detalhes de um forcenedor' do
  it 'e vê informações adicionais' do 
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 34.472.163/0001-02'
    expect(page).to have_content 'Endereço: Avenida das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com' 
  end

  it 'e volta para a tela inicial' do 
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    expect(current_path).to eq root_path 
  end
end