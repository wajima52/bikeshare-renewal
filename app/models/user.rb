class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :lockable

  validate :password_complexity
  validates :username, presence: true

  def password_complexity
    return if password.blank? || password =~ /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}+\z/i
    errors.add :password, "パスワードの強度が不足しています。パスワードの長さは8文字以上とし、小文字と数字と特殊文字をそれぞれ1文字以上含める必要があります。"
  end

end
