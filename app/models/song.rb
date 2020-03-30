class Song < ApplicationRecord
  has_many :results
  has_many :queries, through: :results
end
