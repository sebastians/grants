class Funder < ApplicationRecord
  validates :ein, uniqueness: true
  has_many :awards, as: :grants
end
