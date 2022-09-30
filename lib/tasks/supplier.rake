namespace :supplier do
  desc "Popular a tabela suppliers"
  if Rails.env.development?
    task set_supplier: :environment do
      Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                       full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                       registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                       city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')        
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end
