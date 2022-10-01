require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when name is empty' do 
        user = User.new(name: '', email: 'ana@email.com', password: 'password')
        user.valid?
        expect(user.errors.include? :name).to be true
        expect(user.errors[:name]).to include 'não pode ficar em branco'
      end

      it 'false when email is empty' do 
        user = User.new(name: 'Ana', email: '', password: 'password')
        user.valid?
        expect(user.errors.include? :email).to be true
        expect(user.errors[:email]).to include 'não pode ficar em branco'
      end

      it 'false when password is empty' do 
        user = User.new(name: 'Ana', email: 'ana@email.com', password: '')
        user.valid?
        expect(user.errors.include? :password).to be true
        expect(user.errors[:password]).to include 'não pode ficar em branco'
      end
    end

    context 'uniqueness' do
      it 'false when email is already in use' do 
        User.create!(name: 'Lucia', email: 'lucia@email.com', password: 'pass1234')
        second_user = User.new(name: 'Ana', email: 'lucia@email.com', password: 'password' )
        second_user.valid?
        expect(second_user.errors.include? :email).to be true
        expect(second_user.errors[:email]).to include 'já está em uso'
      end
    end

    context 'length' do
      it 'false when password length is less than 6' do
        user = User.new(name: 'Ana', email: 'ana@email.com', password: 'pass')
        user.valid?
        expect(user.errors.include? :password).to be true
        expect(user.errors[:password]).to include 'é muito curto (mínimo: 6 caracteres)'
      end
    end
    
    context 'format' do 
      it 'false when email has invalid format' do
        user = User.new(name: 'Ana', email: 'anaemail.com', password: 'password')
        user.valid?
        expect(user.errors.include? :email).to be true
        expect(user.errors[:email]).to include 'não é válido'
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
