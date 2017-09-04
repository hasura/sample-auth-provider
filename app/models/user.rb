class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validate :email_belongs_to_hasura
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def email_belongs_to_hasura
    unless email.present? && email.end_with?("hasura.io")
        errors.add(:email, "has to be hasura.io domain")
    end
  end
  
end
