require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when corporate_name is empty' do 
        supplier = Supplier.new(corporate_name: '', brand_name: 'Spark', registration_number: '44037925000122',
                                full_address: 'Torre da Indústria, 10', city: 'Teresina', state: 'PI',
                                email: 'vendas@spark.com.br')
        supplier.valid?
        expect(supplier.errors.include? :corporate_name).to be true
        expect(supplier.errors[:corporate_name]).to include 'não pode ficar em branco'
      end

      it 'false when brand_name is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: '',
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        supplier.valid?
        expect(supplier.errors.include? :brand_name).to be true
        expect(supplier.errors[:brand_name]).to include 'não pode ficar em branco'
      end

      it 'false when registration_number is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        supplier.valid?
        expect(supplier.errors.include? :registration_number).to be true
        expect(supplier.errors[:registration_number]).to include 'não pode ficar em branco'
      end

      it 'false when full_address is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122', full_address: '',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        supplier.valid?
        expect(supplier.errors.include? :full_address).to be true
        expect(supplier.errors[:full_address]).to include 'não pode ficar em branco'
      end

      it 'false when city is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: '', state: 'PI', email: 'vendas@spark.com.br')
        supplier.valid?
        expect(supplier.errors.include? :city).to be true
        expect(supplier.errors[:city]).to include 'não pode ficar em branco'
      end

      it 'false when state is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122',full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: '', email: 'vendas@spark.com.br')
        supplier.valid?
        expect(supplier.errors.include? :state).to be true
        expect(supplier.errors[:state]).to include 'não pode ficar em branco'
      end

      it 'false when email is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: '')
        supplier.valid?
        expect(supplier.errors.include? :email).to be true
        expect(supplier.errors[:email]).to include 'não pode ficar em branco'
      end
    end

    context 'uniqueness' do 
      it 'false when registration_number is already in use' do 
        Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                         full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP',
                         email: 'contato@acme.com')
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '34472163000102', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        supplier.valid?
        expect(supplier.errors.include? :registration_number).to be true
        expect(supplier.errors[:registration_number]).to include 'já está em uso'
      end
    end

    context 'format' do 
      it 'false when registration_number has invalid format' do
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '440', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        supplier.valid?
        expect(supplier.errors.include? :registration_number).to be true
        expect(supplier.errors[:registration_number]).to include 'não é válido'
      end

      it 'false when email has invalid format' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendasspark')
        supplier.valid?
        expect(supplier.errors.include? :email).to be true
        expect(supplier.errors[:email]).to include 'não é válido'
      end
    end
  end

  describe '#full_description' do
    it 'exibe a razão social e o estado' do 
      s = Supplier.new(corporate_name: 'Brinquedos & Variedades LTDA', state: 'SE')
      result = s.full_description
      expect(result).to eq 'Brinquedos & Variedades LTDA | SE'
    end
  end
end
