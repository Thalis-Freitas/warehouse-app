require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app' do
    visit root_path
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do 
    visit root_path

    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('Código: GRU')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('100000 m²')
  end

  it 'e não existem galpões cadastrados' do 
    Warehouse.delete_all
    visit root_path
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end