class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :code, format: {with: /\A[a-zA-Z]{3}\z/}
  validates :cep, format: {with: /\A[0-9]{5}-[0-9]{3}|[0-9]{8}\z/}
end
