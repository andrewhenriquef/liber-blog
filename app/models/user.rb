class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: { value: true, message: 'O perfil deve conter o nome' }
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
end
