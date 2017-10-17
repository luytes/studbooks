class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email
  before_create :confirmation_token
  before_save do |user|
    user.first_name = user.first_name.titleize
    user.last_name = user.last_name.titleize
    user.email = user.email.downcase
    user.university = user.university.titleize
  end

  mount_uploader :picture, PhotoUploader

  has_many :books

  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :university, presence: true
  validates :gender, presence: true
  validates :age, presence: true
  validates :country, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}".titleize
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def send_welcome_email
    # if self.admin == false
      UserMailer.welcome(self).deliver_now
    # end
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
