class Supplier < ApplicationRecord
  has_many :product_models, dependent: :destroy
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, format: {with: /\A[0-9]{14}\z/}, allow_blank: true
  validates :email, email: true, allow_blank: true
end
