class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  mount_uploader :file, FileUploader

  validates :name,
    presence: true,
    uniqueness: true,
    format: { with: /([A-ZА-ЯЁ]\.?\s.*[A-Za-zА-Яа-яЁё]{2,}.*\s.*[A-Za-zА-Яа-яЁё]{2,}.*|[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+.*\s.*[A-Za-zА-Яа-яЁё]{2,}.*)/,
      message: "must begin with a capital letter and contain at least 2 words with 2 letters or more." }
  validate :dot_in_name

  validate :file_size

  private

    def dot_in_name
      errors.add(:name, 'must contain at least one period symbol (.)') unless name.include? ?.
    end

    def file_size
      errors.add(:file, 'must be not more then 2MB') if file.size > 2.megabytes
    end
end
