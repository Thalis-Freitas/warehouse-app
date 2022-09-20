class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :cep, format: {with: /\A[0-9]{5}-[0-9]{3}\z/}
end
