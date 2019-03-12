class Post < ApplicationRecord
  require 'concerns/validation.rb'
  include Validation

  belongs_to :user
  belongs_to :category
  has_many :comments, as: :supplier, dependent: :destroy
  mount_uploader :file, FileUploader

  validates :name,
    uniqueness: true,
    format: { with: /([A-ZА-ЯЁ]\.?\s.*[A-Za-zА-Яа-яЁё]{2,}.*\s.*[A-Za-zА-Яа-яЁё]{2,}.*|[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+.*\s.*[A-Za-zА-Яа-яЁё]{2,}.*)/,
      message: "must begin with a capital letter and contain at least 2 words with 2 letters or more." }
  validate :dot_in_name

  validate :file_size

  private

    def file_size
      errors.add(:file, 'must be not more then 2MB') if file.size > 2.megabytes
    end
end
