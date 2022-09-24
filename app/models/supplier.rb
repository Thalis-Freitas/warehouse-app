class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :email, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, format: {with: /\A[0-9]{14}\z/}
  validates :email, email: true        
end
