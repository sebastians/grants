class Filer < ApplicationRecord
  validates_uniqueness_of :ein
end
