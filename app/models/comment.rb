class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :supplier, polymorphic: true

  validates :content, presence: true, length: { maximum: 500 }

  default_scope { order(id: :desc) }
end
