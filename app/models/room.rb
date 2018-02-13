class Room < ApplicationRecord
  belongs_to :user
  has_many :buttons, dependent: :destroy
end
