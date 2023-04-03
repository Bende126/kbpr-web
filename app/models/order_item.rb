class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  has_one_attached :order_image do |attachable|
    attachable.variant :thumb, resize_to_fit: [256, 256]
  end

  validates :price, presence: true
  validates :laminated, inclusion: [true, false]
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :image_acceptable

  ACCEPTABLE_TYPES = ["image/jpeg", "image/png"]
  validates :comment, presence: true, if: -> { item&.id==1 }

  def self.with_total_price
    select('sum(price*quantity) as total_price', '*').group(:id)
  end

  def self.group_prices_for(order_items)
    select('group_id', 'order_id', 'sum(total_price) as group_total_price')
      .from(order_items.with_total_price, 'order_items')
      .joins(:order).group(:group_id, :order_id).includes(order: :group)
      .to_a.map do |row|
      OpenStruct.new(group: row.order.group, price: row.group_total_price)
    end
  end

  private

  def image_acceptable
    # Image needs to be attached
    unless order_image.attached?
      errors.add(:order_image, "feltöltése kötelező")
      return
    end

    unless order_image.blob.byte_size <= 10.megabyte
      errors.add(:order_image, "túl nagy")
    end

    unless ACCEPTABLE_TYPES.include?(order_image.content_type)
      errors.add(:order_image, "formátuma nem megfelelő")
    end

  end
end
