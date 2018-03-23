class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :comments, dependent: :destroy
  belongs_to :user, optional: false

  validates :title,       presence: { value: true, message: ': O titulo não foi preenchido' },
                          length: { maximum: 50, message: ': O titulo não pode ter mais de 50 caracteres' }
  validates :description, presence: { value: true, message: ': A descrição não foi preenchida' },
                          length: { maximum: 500, message: ': A descrição não pode ter mais de 500 caracteres' }
end
