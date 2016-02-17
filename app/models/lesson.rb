class Lesson < ActiveRecord::Base
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_attachments :photos, maximum: 3
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :name, :address, :price, presence: true
end
