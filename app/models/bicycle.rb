class Bicycle < ApplicationRecord
  belongs_to :user
  enum bicycle_type:{ unselected: nil, road: 1, mountain: 2, other: 0}
  has_one_attached :image
  has_many :rental_relations, dependent: :destroy
  has_many :borrow_users, through: :rental_relations, source: :borrow_user

  validates :name, presence: true
  validates :bicycle_type, presence: true
end
