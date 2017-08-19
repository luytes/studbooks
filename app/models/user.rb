class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email
  before_create :confirmation_token

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
    "#{self.first_name} #{self.last_name}"
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def send_welcome_email
    if self.admin == false
      UserMailer.welcome(self).deliver_now
    end
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
