class Property < ApplicationRecord
  has_many :property_ownerships, dependent: :destroy
  has_many :users, through: :property_ownerships
  has_many :parcels, dependent: :destroy  
end
