class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :lockable

  has_many :bicycles, dependent: :destroy
  has_many :rental_relations, foreign_key: :borrow_user_id
  has_many :borrow_bicycles, through: :rental_relations, source: :bicycle


  validate :password_complexity
  validates :username, presence: true

  def password_complexity
    return if password.blank? || password =~ /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}+\z/i
    errors.add :password, "パスワードの強度が不足しています。パスワードの長さは8文字以上とし、小文字と数字と特殊文字をそれぞれ1文字以上含める必要があります。"
  end

  def borrow(bicycle)
    unless self == bicycle.user
      self.rental_relations.find_or_create_by(bicycle_id: bicycle.id)
    end
  end

  def cancell(bicycle)
    rental_relation = self.rental_relations.find_by(bicycle_id: bicycle.id)
    rental_relation.destroy if rental_relation
  end

  def borrow?(bicycle)
    self.rental_relations.include?(bicycle)
  end

end
