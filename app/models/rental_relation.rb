class RentalRelation < ApplicationRecord

  belongs_to :bicycle
  belongs_to :borrow_user, class_name: 'User'

  validates :bicycle_id, :borrow_user_id, presence: true
  validates :bicycle_id, uniqueness: { scope: :borrow_user_id }
  validate  :self_bicycle?


  def lend_user
    Bicycle.find(self.bicycle_id).user
  end

  def self_bicycle?
    if self.borrow_user_id &&
        self.bicycle_id &&
        self.lend_user == borrow_user
      errors.add(:borrow_user_id, '自分の自転車を借りることはできません')
    end
  end

end
