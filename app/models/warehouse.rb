class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :zip_code, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :code, format: {with: /\A[a-zA-Z]{3}\z/}, allow_blank: true
  validates :zip_code, format: {with: /\A[0-9]{5}-[0-9]{3}|[0-9]{8}\z/}, allow_blank: true
  validates :area, comparison: {greater_than: 0}, allow_blank: true
  has_many :stock_products

  def full_description
    "#{code} | #{name}"
  end

  def set_product_models
    all_models_in_stock = self.stock_products.map do |stock_product|
      stock_product.product_model if stock_product.available?
    end
    all_models_in_stock.uniq.compact
  end
end
