class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :identification_number, presence: true

  has_and_belongs_to_many :courses
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :tasks
end