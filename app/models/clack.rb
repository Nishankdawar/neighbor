class Clack < ActiveRecord::Base
  belongs_to :user
  has_many :likes
end
