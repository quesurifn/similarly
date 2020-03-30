class Result < ApplicationRecord
  belongs_to :query
  belongs_to :song
end
