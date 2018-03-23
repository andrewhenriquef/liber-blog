class Comment < ApplicationRecord
  belongs_to :post, optional: false
  belongs_to :user, optional: false

  validates :body,  length:   { maximum: 250, message: ': O comentario não pode ter mais de 250 caracteres' },
                    presence: { value: true, message: ': O comentario está vazio' }
end
