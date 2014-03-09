class Event < ActiveRecord::Base
  belongs_to :user, inverse_of: :events
  belongs_to :category, inverse_of: :events
  has_many :entries, inverse_of: :event
  has_many :awards, inverse_of: :event
  has_many :distinctions, through: :awards
end
