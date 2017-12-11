class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]

  has_many :services
  has_many :questions
  has_many :answers
  # active_storage backed avatar
  has_one_attached :avatar

  validates :name, presence: true
end
