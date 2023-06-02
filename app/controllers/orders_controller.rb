class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :for_move_to_index, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:post_code, :shipping_origin_id, :city, :brock, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def for_move_to_index
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    return unless @item.user_id == current_user.id || !@item.order.nil?

    redirect_to root_path
  end
end
