class Lesson < ActiveRecord::Base
  belongs_to :user
  has_many :sessions, dependent: :destroy
  validates :name, :address, :price, presence: true
end
