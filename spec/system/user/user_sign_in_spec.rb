require 'rails_helper'

describe 'Usuário faz autenticação' do
  it 'com sucesso' do 
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'jose@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    within('nav') do 
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'jose@email.com'
    end  
    expect(page).to have_content 'Login efetuado com sucesso'
  end

  it 'e faz logout' do 
    visit new_user_session_path
    fill_in 'E-mail', with: 'jose@email.com'
    fill_in 'Senha', with: 'password'
    within('form') do 
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'jose@email.com'
    expect(page).not_to have_button 'Sair'
  end

  it 'com dados inválidos' do
    visit new_user_session_path
    within('form') do
      fill_in 'E-mail', with: ''
      click_on 'Entrar'
    end

    expect(page).to have_content 'E-mail ou senha inválidos'
  end
end