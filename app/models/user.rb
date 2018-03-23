class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: { value: true, message: 'O perfil deve conter o nome' }
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :password, length: { minimum: 6 }

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :email, format: { with: VALID_EMAIL_REGEX }
end
