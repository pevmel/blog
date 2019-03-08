class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,
      presence: true,
      uniqueness: true,
      format: { with: /([A-ZА-ЯЁ]\.?(\s[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+\w*\.?){2,}|[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+\w*\.?(\s[A-ZА-ЯЁ][A-Za-zА-Яа-яЁё]+\w*\.?)+)/,
        message: "must contain at least 2 words with 2 letters or more, and every word must begin with a capital letter." }
  validate :dot_in_name

  has_many :categories
  has_many :posts

  private

    def dot_in_name
      errors.add(:name, 'must contain at least one period symbol (.)') unless name.include? ?.
    end

end
