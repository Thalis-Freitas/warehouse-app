require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
  it 'e vê informações adicionais' do 
    visit root_path
    click_on 'Aeroporto SP'

    expect(page).to have_content 'Galpão GRU'
    expect(page).to have_content 'Nome: Aeroporto SP'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'Área: 100000 m²' 
    expect(page).to have_content 'Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000' 
    expect(page).to have_content 'Galpão destinado para cargas internacionais' 
  end

  it 'e volta para a tela inicial' do 
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Voltar'

    expect(current_path).to eq root_path 
  end
end