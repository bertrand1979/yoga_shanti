class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :session
  validates :user_id, presence: true
end
