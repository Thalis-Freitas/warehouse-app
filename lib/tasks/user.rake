namespace :user do
  desc "Popular a tabela users"
  if Rails.env.development?
    task set_user: :environment do
      User.create!(name: 'José', email: 'jose@email.com', password: 'password')
      User.create!(name: 'Ana', email: 'ana@email.com', password: 'pass1234')
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end
