namespace :utils_supplier do
  desc "Popular a tabela suppliers"
  if Rails.env.development? || Rails.env.test?
    task set_supplier: :environment do
      Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                       full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end
