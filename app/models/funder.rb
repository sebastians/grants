class Funder < ApplicationRecord
  validates :ein, presence: true, uniqueness: { scope: :type }
  has_many :awards, as: :grants
end
