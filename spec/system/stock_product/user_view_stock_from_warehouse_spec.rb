require 'rails_helper'

describe 'Usuário vê o estoque' do 
  it 'na tela do galpão' do 
    warehouse = Warehouse.create!(name: 'Galpão da Avenida', code: 'POA', city: 'Porto Alegre', area: '60000',
                                  address: 'Avenida das Rosas, 10', zip_code: '52700-000',
                                  description: 'Galpão')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                registration_number: '06548763000134', full_address: 'Av Nacoes Unidas 999', 
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    product_tv = ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                      sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
    product_notebook = ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 22, height: 38, depth: 2,
                                            sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)
    product_smartphone = ProductModel.create!(name: 'Smartphone 07', weight: 300, width: 5, height: 13, depth: 1,
                                              sku: 'SMAR05-ACME1-FL7FONE', supplier: supplier)
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'password')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_notebook) }

    login_as user
    visit root_path
    click_link 'Galpão da Avenida'

    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x TV4000-SAMSU-XPBA760'
    expect(page).to have_content '2 x NOTE05-SAMSU-FL703DT'
    expect(page).not_to have_content 'SMAR05-ACME1-FL7FONE'
  end
end