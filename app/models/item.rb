class Item < ApplicationRecord
  has_one :order
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :shipping_origin
  belongs_to :date_of_shipment

  validates :image, presence: true
  validates :title, presence: true
  validates :content, presence: true
  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      presence: { message: "can't be blank" }
  end
  validates :category_id, :status_id, :delivery_charge_id, :shipping_origin_id, :date_of_shipment_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
