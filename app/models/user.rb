class User < ApplicationRecord
  require 'concerns/validation.rb'
  include Validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,
      format: { with: /([A-ZА-ЯЁ]\.?(\s[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+\w*\.?){2,}|[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+\w*\.?(\s[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+\w*\.?)+)/,
        message: "must contain at least 2 words with 2 letters or more, and every word must begin with a capital letter." }
  validate :dot_in_name

  has_many :categories
  has_many :posts
  has_many :comments, dependent: :destroy

end
