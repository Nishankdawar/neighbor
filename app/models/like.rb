class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :clack

  validates :user_id, presence: true
  validates :clack_id, presence: true
end
