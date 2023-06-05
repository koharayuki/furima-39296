require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_delivery = FactoryBot.build(:order_delivery, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品購入ができるとき' do
      it '必要事項(post_code, shipping_origin_id、city, brock, phone_number,token)が過不足なく存在すれば購入できる' do
        expect(@order_delivery).to be_valid
      end

      it 'buildingが空でも保存できる' do
        @order_delivery.building = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it 'item_idが空では登録できない' do
        @order_delivery.item_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Itemを入力してください")
      end

      it 'user_idが空では登録できない' do
        @order_delivery.user_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Userを入力してください")
      end

      it 'post_codeが空では登録できない' do
        @order_delivery.post_code = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は不正な値です")
      end

      it 'post_codeがハイフン無しでは登録できない' do
        @order_delivery.post_code = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'post_codeが半角文字列以外では登録できない' do
        @order_delivery.post_code = '１２３-４５６７'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'shipping_origin_idが1では登録できない' do
        @order_delivery.shipping_origin_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'cityが空では登録できない' do
        @order_delivery.city = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'brockが空では登録できない' do
        @order_delivery.brock = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空では登録できない' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です", "電話番号は数値で入力してください")
      end

      it 'phone_numberが半角数値以外では登録できない' do
        @order_delivery.phone_number = '１２１１１１１１１１１'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号は不正な値です", "電話番号は数値で入力してください")
      end

      it 'phone_numberが9桁以下では登録できない' do
        @order_delivery.phone_number = '11_111_111_1'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号は不正な値です", "電話番号は整数で入力してください")
      end

      it 'phone_numberが12桁以上では登録できない' do
        @order_delivery.phone_number = '11_111_111_111_1'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号は不正な値です", "電話番号は整数で入力してください")
      end

      it 'tokenが空では登録できないこと' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
