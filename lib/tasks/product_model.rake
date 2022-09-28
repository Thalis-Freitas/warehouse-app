namespace :product_model do
  desc "Popular a tabela product_models"
  if Rails.env.development? || Rails.env.test?
    task set_product_model: :environment do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                           sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
      ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                           sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end
