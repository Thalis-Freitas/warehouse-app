class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  validates_associated :supplier
  validates :name, :sku, presence: true
  validates :name, :sku, uniqueness: true
  validates :weight, :width, :height, :depth,  comparison: { greater_than: 0 }
  validates :sku, length: { is: 20 }, allow_blank: true
end
