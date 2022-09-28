require 'rails_helper'

describe 'Usuário cadastra modelo de produto' do
  it 'a partir do menu' do 
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar novo modelo'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Profundidade'
    expect(page).to have_field 'SKU'
    expect(page).to have_field 'Fornecedor', type: 'select'
  end

  it 'com sucesso' do
		visit product_models_path
    click_on 'Cadastrar novo modelo'
    fill_in 'Nome', with: 'Smartphone 07'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: 12
    fill_in 'Largura', with: 5
    fill_in 'Profundidade', with: 1
    fill_in 'SKU', with: 'SMAR05-ACME1-FL7FONE'
    select 'ACME', from: 'Fornecedor'
    click_on 'Criar Modelo de Produto'

    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'Smartphone 07'
    expect(page).to have_content 'SKU: SMAR05-ACME1-FL7FONE'
    expect(page).to have_content 'Dimensões: 12cm x 5cm x 1cm'
    expect(page).to have_content 'Peso: 300g'
    expect(page).to have_content 'Fornecedor: ACME'
  end

  it 'com dados incompletos' do 
    visit product_models_path
    click_on 'Cadastrar novo modelo'
    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    click_on 'Criar Modelo de Produto'

    expect(page).to have_content 'Modelo de produto não cadastrado'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
  end

  it 'com dado exclusivo que já está em uso' do 
    visit product_models_path
    click_on 'Cadastrar novo modelo'
    fill_in 'Nome', with: 'TV 40'
    fill_in 'SKU', with: 'TV4000-SAMSU-XPBA760'
    click_on 'Criar Modelo de Produto'

    expect(page).to have_content 'Nome já está em uso'
    expect(page).to have_content 'SKU já está em uso'
  end

  it 'com dados inválidos' do 
		visit product_models_path
    click_on 'Cadastrar novo modelo'
    fill_in 'SKU', with: 'TV4'
    fill_in 'Peso', with: 0
    fill_in 'Largura', with: 0
    fill_in 'Altura', with: -7
    fill_in 'Profundidade', with: -1
    click_on 'Criar Modelo de Produto'

    expect(page).to have_content 'SKU não possui o tamanho esperado (20 caracteres)'
    expect(page).to have_content 'Peso deve ser maior que 0'
    expect(page).to have_content 'Largura deve ser maior que 0'
    expect(page).to have_content 'Altura deve ser maior que 0'
    expect(page).to have_content 'Profundidade deve ser maior que 0'
  end
end