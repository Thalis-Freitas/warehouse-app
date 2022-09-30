require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                      address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')

    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Aeroporto SP'
    expect(page).not_to have_content 'GRU' 
  end

  it 'e não apaga outros galpões' do
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                      address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    Warehouse.create!(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                      address: 'Avenida Atlântica, 50', zip_code: '80000-000',
                      description: 'Perto do Aeroporto')
    user = User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')

    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Aeroporto SP'
    expect(page).not_to have_content 'GRU'
    expect(page).to have_content 'Maceió'
    expect(page).to have_content 'MCZ'
  end
end