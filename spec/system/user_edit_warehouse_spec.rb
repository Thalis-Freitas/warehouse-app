require 'rails_helper'

describe 'Usuário edita um galpão' do  
  it 'a partir da página de detalhes' do
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field 'Nome', with: 'Aeroporto SP'
    expect(page).to have_field 'Descrição', with: 'Galpão destinado para cargas internacionais'
    expect(page).to have_field 'Código', with: 'GRU'
    expect(page).to have_field 'Cidade', with: 'Guarulhos'
    expect(page).to have_field 'Endereço', with: 'Avenida do Aeroporto, 1000'
    expect(page).to have_field 'CEP', with: '15000-000'
    expect(page).to have_field 'Área', with: '100000', type: 'number'
  end

  it 'com sucesso' do 
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
    address: 'Avenida Atlântica, 50', cep: '80000-000',
    description: 'Perto do Aeroporto')

    visit root_path
    click_on 'Maceió'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão de Maceió'
    fill_in 'Endereço', with: 'Avenida, 800'
    fill_in 'CEP', with: '77000000'
    fill_in 'Código', with: 'mcz'
    fill_in 'Área', with: '65000'
    click_on 'Atualizar Galpão'

    expect(current_path).to eq warehouse_path(warehouse)
    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'MCZ'
    expect(page).to have_content 'Perto do Aeroporto'
    expect(page).to have_content 'Nome: Galpão de Maceió'
    expect(page).to have_content 'Cidade: Maceió'
    expect(page).to have_content 'Área: 65000 m²'
    expect(page).to have_content 'Endereço: Avenida, 800'    
  end

  it 'e remove os dados dos campos' do
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área', with: ''
    click_on 'Atualizar Galpão'

    expect(page).to have_content 'Não foi possível atualizar o galpão'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
    expect(page).to have_content 'CEP não é válido'
    expect(page).to have_content 'Código não é válido'
  end

  it 'sem modificar os campos' do 
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: 'Aeroporto SP'
    fill_in 'Código', with: 'GRU'
    fill_in 'Descrição', with: 'Galpão destinado para cargas internacionais'
    fill_in 'Cidade', with: 'Guarulhos'
    fill_in 'Endereço', with: 'Avenida do Aeroporto, 1000'
    fill_in 'CEP', with: '15000-000'
    fill_in 'Área', with: '100000'
    click_on 'Atualizar Galpão'

    expect(page).to have_content 'Nenhuma modificação encontrada'
  end
end