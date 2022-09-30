require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'se estiver autenticado' do
    visit root_path
    expect(current_path).to eq new_user_session_path
  end
  
  it 'e vê o nome da app' do
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    login_as(user)
    visit root_path
    expect(page).to have_content 'Galpões & Estoque'
    expect(page).to have_link('Galpões & Estoque', href: root_path)
  end

  it 'e vê os galpões cadastrados' do 
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    Warehouse.create!(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                      address: 'Avenida Atlântica, 50', zip_code: '80000-000',
                      description: 'Perto do Aeroporto')
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                      address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    login_as(user)
    visit root_path

    expect(page).not_to have_content 'Não existem galpões cadastrados'
    expect(page).to have_content 'Aeroporto SP'
    expect(page).to have_content 'Código: GRU'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content '100000 m²'
    expect(page).to have_content 'Maceió'
    expect(page).to have_content 'Código: MCZ'
    expect(page).to have_content 'Cidade: Maceió'
    expect(page).to have_content '50000 m²'
  end

  it 'e não existem galpões cadastrados' do 
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
    login_as(user)
    visit root_path
    expect(page).to have_content 'Não existem galpões cadastrados'
  end
end