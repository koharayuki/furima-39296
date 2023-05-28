class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :items
  # has_many :orders

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }
  validates :nickname, presence: true
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :last_name
    validates :first_name
  end
  validates :suv_last_name, presence: true, format: { with: /\A[ァ-ヴー]+\z/u }
  validates :suv_first_name, presence: true, format: { with: /\A[ァ-ヴー]+\z/u }
  validates :date_of_birth, presence: true
end


