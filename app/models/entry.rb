class Entry < ActiveRecord::Base
  belongs_to :user, inverse_of: :entries
  belongs_to :event, inverse_of: :entries
  has_many :comments, inverse_of: :entry
  has_many :votes, inverse_of: :entry
  has_one :award, inverse_of: :entry
  has_one :distinction, through: :award
end
