class Room < ApplicationRecord
  belongs_to :user
  has_many :buttons, dependent: :destroy
  has_many :players, dependent: :destroy
  has_many :users, through: :players
  has_one :turnlist, dependent: :destroy
end
