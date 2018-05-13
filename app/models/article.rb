class Article < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true,
    length: {minimum: 3, maximum: 50}
  validates :description, presence: true,
    length: {minimum: 6, maximum: 100}
end
