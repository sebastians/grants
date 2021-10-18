class Award < ApplicationRecord
  belongs_to :funder
  belongs_to :recipient
end
