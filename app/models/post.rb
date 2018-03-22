class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
end
