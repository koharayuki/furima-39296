class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password,  length: { minimum: 6 }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}ａ-ｚＡ-Ｚ０-９]+\z/}
  validates :first_name, presence: true, format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}ａ-ｚＡ-Ｚ０-９]+\z/}
  validates :suv_last_name, presence: true, format: { with: /\A[ァ-ヴー]+\z/u}
  validates :suv_first_name, presence: true, format: { with: /\A[ァ-ヴー]+\z/u}
  validates :date_of_birth, presence: true
end


