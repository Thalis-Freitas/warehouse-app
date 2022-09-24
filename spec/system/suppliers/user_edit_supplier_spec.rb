require 'rails_helper'

describe 'Usuário edita um fornecedor' do  
  it 'a partir do menu' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field 'Nome Fantasia', with: 'ACME'
    expect(page).to have_field 'Razão Social', with: 'ACME LTDA'
    expect(page).to have_field 'CNPJ', with: '34472163000102'
    expect(page).to have_field 'Endereço', with: 'Avenida das Palmas, 100'
    expect(page).to have_field 'Cidade', with: 'Bauru'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'E-mail', with: 'contato@acme.com', type: 'email'
  end

  it 'com sucesso' do 
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', 
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')

    visit root_path
    click_on 'Fornecedores'
    click_on 'Spark'
    click_on 'Editar'

    fill_in 'Nome Fantasia', with: 'Indústrias Spark'
    fill_in 'Endereço', with: 'Avenida das Indústrias, 400'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'Rj'
    click_on 'Atualizar Fornecedor'

    expect(current_path).to eq supplier_path(supplier)
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Fornecedor Indústrias Spark'
    expect(page).to have_content 'Documento: 44.037.925/0001-22'
    expect(page).to have_content 'Endereço: Avenida das Indústrias, 400 - Rio de Janeiro - RJ'
    expect(page).to have_content 'E-mail: vendas@spark.com.br' 
  end

  it 'e remove os dados dos campos' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content 'Não foi possível atualizar o fornecedor'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'CNPJ não é válido'
    expect(page).to have_content 'E-mail não é válido'
  end

  it 'sem modificar os campos' do 
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'ACME'
    fill_in 'Razão Social', with: 'ACME LTDA'
    fill_in 'CNPJ', with: '34472163000102'
    fill_in 'Endereço', with: 'Avenida das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content 'Nenhuma modificação encontrada'
  end
end