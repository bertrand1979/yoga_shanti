class Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  validates :start_at, presence: true
end
