require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when name is empty' do 
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', zip_code: '25000-000', 
                                  city: 'Rio', area: 1000, description: 'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when code is empty' do 
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', zip_code: '25000-000', 
                                  city: 'Rio', area: 1000, description: 'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when address is empty' do 
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', zip_code: '25000-000', 
                                  city: 'Rio', area: 1000, description: 'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when zip_code is empty' do 
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', zip_code: '', 
                                  city: 'Rio', area: 1000, description: 'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when city is empty' do 
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', zip_code: '25000-000', 
                                  city: '', area: 1000, description: 'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end
      
      it 'false when area is empty' do 
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', zip_code: '25000-000', 
                                  city: 'Rio', area: '', description: 'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when description is empty' do 
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', zip_code: '25000-000', 
                                  city: 'Rio', area: '1000', description: '')
        expect(warehouse.valid?).to eq false
        end
    end

    context 'uniqueness' do 
      it 'false when code is already in use' do 
        Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
                          address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                          description: 'Galpão destinado para cargas internacionais')
        warehouse = Warehouse.new(name: 'Armazém SSA', code: 'GRU', city: 'Salvador', area: '90000',
                                  address: 'Avenida do Aeroporto, 200', zip_code: '32100-000',
                                  description: 'Galpão destinado para estoque de cargas')
        expect(warehouse.valid?).to eq false
      end

      it 'false when name is already in use' do 
        Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '100000',
          address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
          description: 'Galpão destinado para cargas internacionais')
        warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'SSA', city: 'Salvador', area: '90000',
                                  address: 'Avenida do Aeroporto, 200', zip_code: '32100-000',
                                  description: 'Galpão destinado para estoque de cargas')
        expect(warehouse.valid?).to eq false
      end
    end
    
    context 'format' do 
      it 'false when zip code has invalid format' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', zip_code: '25000', 
                                  city: 'Rio', area: '1000', description: 'Descrição')
        expect(warehouse.valid?).to eq false
      end
      it 'false when code has invalid format' do
        warehouse = Warehouse.new(name: 'Rio', code: 'rj', address: 'Endereço', zip_code: '25000-000', 
                                  city: 'Rio', area: '1000', description: 'Descrição')
        expect(warehouse.valid?).to eq false
      end
    end
  end

  describe '#full_description' do
    it 'exibe o nome e o código' do 
      w = Warehouse.new(name: 'Cuiabá', code: 'CBA')
      expect(w.full_description).to eq 'CBA | Cuiabá'
    end
  end
end
