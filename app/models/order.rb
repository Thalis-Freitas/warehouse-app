class Order < ApplicationRecord
  before_validation :generate_code, on: :create
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items
  enum status: {pending: 0, delivered: 5, canceled: 9}

  validate :estimated_delivery_date_is_future
  validates :code, :estimated_delivery_date, presence: true

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def estimated_delivery_date_is_future 
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.today
      self.errors.add(:estimated_delivery_date, " deve ser futura")
    end
  end

  def create_stock_when_delivered
    self.order_items.each do |item|
      item.quantity.times do 
        StockProduct.create!(order: self, product_model: item.product_model, warehouse: self.warehouse)
      end
    end
  end
end
