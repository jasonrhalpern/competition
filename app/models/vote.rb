class Vote < ActiveRecord::Base
  belongs_to :entry, inverse_of: :votes
  belongs_to :user, inverse_of: :votes

  validates :entry, :user, :event_id, :presence => true
end
