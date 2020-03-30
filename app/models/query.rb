class Query < ApplicationRecord
  has_many :results
  has_many :songs, through: :results
  validates :query, uniqueness: true, presence: true
end
