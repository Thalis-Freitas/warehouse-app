Warehouse.destroy_all
Supplier.destroy_all
ProductModel.destroy_all
User.destroy_all

Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                  address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                  description: 'Galpão destinado para cargas internacionais')

Warehouse.create!(name: 'Armazém BA', code: 'SSA', city: 'Salvador', area: '90000',
                 address: 'Avenida do Aeroporto, 200', zip_code: '32100-000',
                 description: 'Galpão destinado para estoque de cargas')

supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                            registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                            city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

second_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                                  full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
                      
ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                     sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)

ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                     sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)

ProductModel.create!(name: 'Smartphone 07', weight: 300, width: 5, height: 13, depth: 1,
                     sku: 'SMAR05-ACME1-FL7FONE', supplier: second_supplier)

User.create!(name: 'José', email: 'jose@email.com', password: 'password')
User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')