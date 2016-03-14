class Session < ActiveRecord::Base
  belongs_to :lesson
  has_many :bookings
  validates :starts_at, presence: true
end
