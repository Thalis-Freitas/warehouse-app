require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when corporate_name is empty' do 
        supplier = Supplier.new(corporate_name: '', brand_name: 'Spark', registration_number: '44037925000122',
                                full_address: 'Torre da Indústria, 10', city: 'Teresina', state: 'PI',
                                email: 'vendas@spark.com.br')
        expect(supplier.valid?).to eq false
      end
      it 'false when brand_name is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: '',
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        expect(supplier.valid?).to eq false
      end
      it 'false when registration_number is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        expect(supplier.valid?).to eq false
      end
      it 'false when full_address is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122', full_address: '',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        expect(supplier.valid?).to eq false
      end
      it 'false when city is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: '', state: 'PI', email: 'vendas@spark.com.br')
        expect(supplier.valid?).to eq false
      end
      it 'false when state is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122',full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: '', email: 'vendas@spark.com.br')
        expect(supplier.valid?).to eq false
      end
      it 'false when email is empty' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: '')
        expect(supplier.valid?).to eq false
      end
    end
    context 'uniqueness' do 
      it 'false when registration_number is already in use' do 
        Supplier.destroy_all
        Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '34472163000102',
                         full_address: 'Avenida das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '34472163000102', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        expect(supplier.valid?).to eq false
      end
    end
    context 'format' do 
      it 'false when registration_number has invalid format' do
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '440', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
        expect(supplier.valid?).to eq false
      end
      it 'false when email has invalid format' do 
        supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                registration_number: '44037925000122', full_address: 'Torre da Indústria, 10',
                                city: 'Teresina', state: 'PI', email: 'vendasspark')
        expect(supplier.valid?).to eq false
      end
    end
  end
end
