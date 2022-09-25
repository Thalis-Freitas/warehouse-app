class ProductModel < ApplicationRecord
  belongs_to :supplier
  # validates_associated :supplier
  validates :name, :sku, presence: true
  validates :name, :sku, uniqueness: true
  validates :weight, :width, :height, :depth,  comparison: { greater_than: 0 }
  validates :sku, length: { is: 20 }, allow_blank: true
end
