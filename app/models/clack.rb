class Clack < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :replies

end
