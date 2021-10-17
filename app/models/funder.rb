class Funder < ApplicationRecord
  validates_uniqueness_of :ein
end
