require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do 
    login_as(User.last)
    visit root_path
    click_on 'Cadastrar Galpão'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Área'
  end

  it 'com sucesso' do
    login_as(User.last)
    visit new_warehouse_path
    fill_in 'Nome' , with: 'Rio de Janeiro'
    fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
    fill_in 'Código', with: 'RIO'
    fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'CEP', with: '20100-000'
    fill_in 'Área', with: '32000'
    click_on 'Criar Galpão'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso'
    expect(page).to have_content 'RIO'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content '32000 m²'
  end

  it 'com dados incompletos' do 
    login_as(User.last)
    visit new_warehouse_path
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    click_on 'Criar Galpão'

    expect(page).to have_content 'Galpão não cadastrado'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
  end

  it 'com dado exclusivo que já está em uso' do 
    login_as(User.last)
    visit new_warehouse_path
    fill_in 'Nome', with: 'Aeroporto SP'
    fill_in 'Código', with: 'GRU'
    click_on 'Criar Galpão'

    expect(page).to have_content 'Nome já está em uso'
    expect(page).to have_content 'Código já está em uso'
  end

  it 'com dados inválidos' do 
    login_as(User.last)
    visit new_warehouse_path
    fill_in 'Código', with: 'Rj'
    fill_in 'CEP', with: '25000'
    click_on 'Criar Galpão'

    expect(page).to have_content 'Código não é válido'
    expect(page).to have_content 'CEP não é válido'
  end
end