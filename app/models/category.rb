class Category < ApplicationRecord
  require 'concerns/validation.rb'
  include Validation

  belongs_to :user
  has_many :posts
  has_many :comments, as: :supplier, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: true,
    format: { with: /([A-ZА-ЯЁ]\.?\s.*[A-Za-zА-Яа-яЁё]{2,}.*\s.*[A-Za-zА-Яа-яЁё]{2,}.*|[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+.*\s.*[A-Za-zА-Яа-яЁё]{2,}.*)/,
      message: "must start with a capital letter and contain at least 2 words with 2 letters or more." }
  validate :dot_in_name

end
