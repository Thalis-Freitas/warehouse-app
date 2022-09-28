namespace :user do
  desc "Popular a tabela users"
  if Rails.env.development? || Rails.env.test?
    task set_user: :environment do
      User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end
