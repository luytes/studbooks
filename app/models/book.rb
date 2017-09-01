class Book < ApplicationRecord
  belongs_to :user

  # has_many :orders, :dependent => :destroy
  alias_attribute :owner, :user
  validates :title, presence: true
  validates :author, presence: true
  validates :field, presence: true
  validates :condition, presence: true
  validates :picture, presence: true
  # validates :state, presence: true
  validates :price_cents, presence: true

  monetize :price_cents

  mount_uploader :picture, PhotoUploader
end
