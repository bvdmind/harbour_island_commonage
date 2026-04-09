class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_one_attached :photo
  has_many :verification_documents, dependent: :destroy
  has_many :property_ownerships, dependent: :destroy
  has_many :properties, through: :property_ownerships
  has_many :posts, dependent: :destroy
  has_many :documents, class_name: "VerificationDocument", dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
