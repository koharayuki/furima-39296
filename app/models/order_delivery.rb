class OrderDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :shipping_origin_id, :city, :brock, :building, :phone_number, :token

  validates :shipping_origin_id, numericality: { other_than: 1, message: "を選択してください"}

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city
    validates :brock
    validates :phone_number, format: { with: /\A\d[0-9]{10,11}+\z/ }, numericality: { only_integer: true }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_code: post_code, shipping_origin_id: shipping_origin_id, city: city, brock: brock, building: building,
                    phone_number: phone_number, order_id: order.id)
  end
end
