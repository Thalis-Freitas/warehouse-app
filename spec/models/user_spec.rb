require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when name is empty' do 
        user = User.new(name: '', email: 'ana@email.com', password: 'password')
        expect(user.valid?).to eq false
      end

      it 'false when email is empty' do 
        user = User.new(name: 'Ana', email: '', password: 'password')
        expect(user.valid?).to eq false
      end

      it 'false when password is empty' do 
        user = User.new(name: 'Ana', email: 'ana@email.com', password: '')
        expect(user.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'false when email is already in use' do 
        User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
        second_user = User.new(name: 'Ana', email: 'lucia@email.com', password: 'password' )
        expect(second_user.valid?).to eq false
      end
    end

    context 'length' do
      it 'false when password length is less than 6' do
        user = User.new(name: 'Ana', email: 'ana@email.com', password: 'pass')
        expect(user.valid?).to eq false
      end
    end
    
    context 'format' do 
      it 'false when email has invalid format' do
        user = User.new(name: 'Ana', email: 'anaemail.com', password: 'password')
        expect(user.valid?).to eq false
      end
    end
  end

  describe '#description' do 
    it 'exibe o nome e o email' do
      u = User.new(name:'Verônica da Silva', email:'silva@email.com')
      expect(u.description).to eq 'Verônica da Silva <silva@email.com>'
    end
  end
end
