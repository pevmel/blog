class Category < ApplicationRecord
  belongs_to :user
  has_many :posts

  validates :name,
    presence: true,
    uniqueness: true,
    format: { with: /([A-ZА-ЯЁ]\.?\s.*[A-Za-zА-Яа-яЁё]{2,}.*\s.*[A-Za-zА-Яа-яЁё]{2,}.*|[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+.*\s.*[A-Za-zА-Яа-яЁё]{2,}.*)/,
      message: "must start with a capital letter and contain at least 2 words with 2 letters or more." }
  validate :dot_in_name

  private

    def dot_in_name
      errors.add(:name, 'must contain at least one period symbol (.)') unless name.include? ?.
    end
end
