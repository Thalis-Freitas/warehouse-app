require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Aeroporto SP'
    expect(page).not_to have_content 'GRU' 
  end

  it 'e não apaga outros galpões' do
    Warehouse.create!(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
    address: 'Avenida Atlântica, 50', zip_code: '80000-000',
    description: 'Perto do Aeroporto')

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