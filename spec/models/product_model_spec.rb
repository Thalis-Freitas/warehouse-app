require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when name is empty' do 
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: '', weight: 6300, width: 101, height: 49, depth: 8,
                                        sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :name).to be true
        expect(product_model.errors[:name]).to include 'não pode ficar em branco'
      end

      it 'false when weight is empty' do 
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: '', width: 101, height: 49, depth: 8,
                                         sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :weight).to be true
        expect(product_model.errors[:weight]).to include 'não pode ficar em branco'
      end

      it 'false when width is empty' do 
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: '', height: 49, depth: 8,
                                         sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :width).to be true
        expect(product_model.errors[:width]).to include 'não pode ficar em branco'
      end

      it 'false when height is empty' do 
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: '', depth: 8,
                                         sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :height).to be true
        expect(product_model.errors[:height]).to include 'não pode ficar em branco'
      end

      it 'false when depth is empty' do 
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: '',
                                         sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :depth).to be true
        expect(product_model.errors[:depth]).to include 'não pode ficar em branco'
      end

      it 'false when sku is empty' do 
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                         sku: '', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :sku).to be true
        expect(product_model.errors[:sku]).to include 'não pode ficar em branco'
      end    

      it 'false when there is no supplier' do 
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                         sku: 'TV4000-LGELT-XPBA760')
        product_model.valid?
        expect(product_model.errors.include? :supplier).to be true
        expect(product_model.errors[:supplier]).to include 'é obrigatório(a)'
      end
    end

    context 'uniqueness' do 
      it 'false when sku is already in use' do 
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                      sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
        product_model = ProductModel.new(name: 'Smartphone 07', weight: 220, width: 5, height: 12, depth: 1,
                                         sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :sku).to be true
        expect(product_model.errors[:sku]).to include 'já está em uso'
      end

      it 'false when name is already in use' do 
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        ProductModel.create!(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                             sku: 'TV4000-SAMSU-XPBA760', supplier: supplier)
        product_model = ProductModel.new(name: 'TV 40', weight: 1800, width: 22, height: 38, depth: 2,
                                          sku: 'NOTE05-SAMSU-FL703DT', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :name).to be true
        expect(product_model.errors[:name]).to include 'já está em uso'
      end
    end

    context 'comparison' do 
      it 'false when weight is <= 0' do
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight:0, width: 101, height: 49, depth: 8,
                                         sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :weight).to be true
        expect(product_model.errors[:weight]).to include 'deve ser maior que 0'
      end

      it 'false when width is <= 0' do
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: -4, height: 49, depth: 8,
                                         sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :width).to be true
        expect(product_model.errors[:width]).to include 'deve ser maior que 0'
      end

      it 'false when height is <= 0' do
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 0, depth: 8,
                                         sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :height).to be true
        expect(product_model.errors[:height]).to include 'deve ser maior que 0'
      end
      
      it 'false when depth is <= 0' do
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: -8,
                                         sku: 'TV4000-LGELT-XPBA760', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :depth).to be true
        expect(product_model.errors[:depth]).to include 'deve ser maior que 0'
      end
    end

    context 'length' do 
      it 'false when sku length is different from 20' do
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG LTDA',
                                    registration_number: '64738922000198', full_address: 'Av das Nações 89', 
                                    city: 'Salvador', state: 'BA', email: 'contato@lg.com.br')
        product_model = ProductModel.new(name: 'TV 40', weight: 6300, width: 101, height: 49, depth: 8,
                                        sku: 'TV4000-LGELT', supplier: supplier)
        product_model.valid?
        expect(product_model.errors.include? :sku).to be true
        expect(product_model.errors[:sku]).to include 'não possui o tamanho esperado (20 caracteres)'
      end
    end
  end
end
