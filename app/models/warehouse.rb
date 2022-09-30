class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :zip_code, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :code, format: {with: /\A[a-zA-Z]{3}\z/}, allow_blank: true
  validates :zip_code, format: {with: /\A[0-9]{5}-[0-9]{3}|[0-9]{8}\z/}, allow_blank: true

  def full_description
    "#{code} | #{name}"
  end
end
