class Comment < ApplicationRecord
  belongs_to :post

  validates :body, length: { maximum: 250 }, presence: true
end
