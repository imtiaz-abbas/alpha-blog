class User < ApplicationRecord
  has_many :articles
  before_save {self.email = email.downcase}
  validates :username, presence: true,
  uniqueness: {case_sensitive: false},
  length: {maximum: 30, minimum: 5}
  VALID_EMAIL_REGEX= /\a[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  length: {maximum: 100},
  uniqueness: {case_sensitive: false}
end
