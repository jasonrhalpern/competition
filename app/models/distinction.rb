class Distinction < ActiveRecord::Base
  has_many :awards, inverse_of: :distinction
  has_many :entries, through: :awards
end
