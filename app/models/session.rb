class Session < ActiveRecord::Base
  belongs_to :lesson
  has_many :bookings, dependent: :restrict_with_error
  validates :starts_at, :maxnumber, presence: true
end
