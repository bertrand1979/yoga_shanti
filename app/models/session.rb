class Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  validates :starts_at, presence: true
end
