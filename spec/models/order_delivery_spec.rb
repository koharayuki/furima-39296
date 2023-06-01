require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('images/test_image.png')
    @item.save
    @order_delivery = FactoryBot.build(:order_delivery, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品購入ができるとき' do
      it '必要事項(post_code, shipping_origin_id、city, brock, phone_number,token)が過不足なく存在すれば購入できる' do
        expect(@order_delivery).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it 'item_idが空では登録できない' do
        @order_delivery.item_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end

      it 'user_idが空では登録できない' do
        @order_delivery.user_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end

      it 'post_codeが空では登録できない' do
        @order_delivery.post_code = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code can't be blank", 'Post code is invalid')
      end

      it 'post_codeが半角文字列以外では登録できない' do
        @order_delivery.post_code = '１２３-４５６７'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Post code is invalid')
      end

      it 'shipping_origin_idが1では登録できない' do
        @order_delivery.shipping_origin_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Shipping origin can't be blank")
      end

      it 'cityが空では登録できない' do
        @order_delivery.city = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end

      it 'brockが空では登録できない' do
        @order_delivery.brock = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Brock can't be blank")
      end

      it 'phone_numberが空では登録できない' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid',
                                                                'Phone number is not a number')
      end

      it 'phone_numberが半角数値以外では登録できない' do
        @order_delivery.phone_number = '１２１１１１１１１１１'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid', 'Phone number is not a number')
      end

      it 'tokenが空では登録できないこと' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
