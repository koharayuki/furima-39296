require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必要事項(nickname,email、password,password_confirmation,last_name,first_name,suv_last_name,_suv_first_name,date_of_birth)が過不足なく存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordで半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordで半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａａa １１1'
        @user.password_confirmation = 'ａａa １１1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end

      it 'お名前(全角)は、名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
      end

      it 'お名前(全角)は、名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end

      it 'お名前(全角)は、名字を全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.last_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it 'お名前(全角)は、名前を全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'お名前カナ(全角)は、名字が空では登録できない' do
        @user.suv_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Suv last name can't be blank", "Suv last name is invalid")
      end

      it 'お名前カナ(全角)は、名前が空では登録できない' do
        @user.suv_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Suv first name can't be blank", "Suv first name is invalid")
      end

      it 'お名前カナ(全角)は、名字を全角（カタカナ）で入力しないと登録できない' do
        @user.suv_last_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Suv last name is invalid")
      end

      it 'お名前カナ(全角)は、名前を全角（カタカナ）で入力しないと登録できない' do
        @user.suv_first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Suv first name is invalid")
      end

      it '生年月日が空だと登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
