require 'rails_helper'

describe 'Usuário cria uma conta' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Cláudia'
    fill_in 'E-mail', with: 'claudia@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    
    expect(page).to have_content 'claudia@email.com'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    user = User.last
    expect(user.name).to eq 'Cláudia'
  end

  it 'com email que já está em uso' do
    visit new_user_session_path
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Cláudia'
    fill_in 'E-mail', with: 'jose@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'E-mail já está em uso'
    expect(page).not_to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end

  it 'sem confirmar a senha' do
    visit new_user_session_path
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Cláudia'
    fill_in 'E-mail', with: 'claudia@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: ''
    click_on 'Criar conta'
    
    expect(page).to have_content 'Confirme sua senha não é igual a Senha'
  end

  it 'com senha menor que 6 caracteres' do
    visit new_user_session_path
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Cláudia'
    fill_in 'E-mail', with: 'jose@email.com'
    fill_in 'Senha', with: 'pass'
    fill_in 'Confirme sua senha', with: 'pass'
    click_on 'Criar conta'
    
    expect(page).to have_content 'Senha é muito curto (mínimo: 6 caracteres)'
  end
end