class Order < ApplicationRecord
  before_validation :generate_code
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  # validates :estimated_delivery_date, comparison: { greater_than: Date.today }
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
end
