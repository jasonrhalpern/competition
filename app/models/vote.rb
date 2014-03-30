class Vote < ActiveRecord::Base

  belongs_to :entry, inverse_of: :votes, counter_cache: true
  belongs_to :user, inverse_of: :votes

  validates :entry, :user, presence: true

end
