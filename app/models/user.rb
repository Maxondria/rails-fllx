class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 5, allow_blank: true }
  validates :username, presence: true, format: { with: /\A[A-Z0-9]+\z/i }, uniqueness: { case_sensitive: false }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.find_by_email_or_username(email_or_username)
    where(email: email_or_username)
      .or(where(username: email_or_username))
      .first
  end
end
