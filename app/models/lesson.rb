class Lesson < ActiveRecord::Base
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_attachments :photos, maximum: 3
  validates :name, :address, :price, presence: true
end
