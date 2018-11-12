class Bicycle < ApplicationRecord
  belongs_to :user
  enum bicycle_type:{ unselected: nil, road: 1, mountain: 2, other: 0}
  has_one_attached :image

validates :name, presence: true
validates :bicycle_type, presence: true
end
