require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  context 'presence' do 
    it 'false when name is empty' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: '', weight: 6300, width: 101, height: 49, depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when weight is empty' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: '', width: 101, height: 49, depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when width is empty' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: '', height: 49, depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when height is empty' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: '', depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when depth is empty' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: '',
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when sku is empty' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                       sku: '', supplier: supplier)
      expect(product_model.valid?).to eq false
    end    
    it 'false when there is no supplier' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760')
      expect(product_model.valid?).to eq false
    end
  end
  context 'uniqueness' do 
    it 'false when sku is already in use' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 35, height: 38, depth: 2,
                           sku: 'NOTE05-LGELT-FL703DT', supplier: supplier)
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                           sku: 'NOTE05-LGELT-FL703DT', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when name is already in use' do 
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      ProductModel.create!(name: 'Notebook 05', weight: 1800, width: 35, height: 38, depth: 2,
                           sku: 'NOTE05-LGELT-FL703DT', supplier: supplier)
      product_model = ProductModel.new(name: 'Notebook 05', weight: 6300, width: 101, height: 49, depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
  end

  context 'comparison' do 
    it 'false when weight is <= 0' do
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight:0, width: 101, height: 49, depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when width is <= 0' do
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: -4, height: 49, depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when height is <= 0' do
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 0, depth: 8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
    it 'false when depth is <= 0' do
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: -8,
                                       sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
  end

  context 'length' do 
    it 'false when sku length is different from 20' do
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                  registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                  city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
      product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                       sku: 'TV4000-LGELT', supplier: supplier)
      expect(product_model.valid?).to eq false
    end
  end
end