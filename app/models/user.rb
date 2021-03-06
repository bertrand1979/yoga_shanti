class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :lessons, dependent: :destroy
  has_many :events, class_name:'Session', through: :lessons
  has_many :bookings
  has_many :sessions, through: :bookings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true, if: :teacher?
  validates :start_date, presence: true, if: :teacher?
  validates :description, presence: true, if: :teacher?

  def teacher?
    category == "teacher"
  end

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

end
