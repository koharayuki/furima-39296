class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @items = Item.new
  end

  def create
    Item.create(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:title, :content, :category_id, :status_id, :delivery_charge_id, :shipping_origin_id, :date_of_shipment_id, :price).merge(user_id: current_user.id)
  end

end
