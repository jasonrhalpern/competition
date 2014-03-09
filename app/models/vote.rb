class Vote < ActiveRecord::Base
  belongs_to :entry, inverse_of: :votes
  belongs_to :user, inverse_of: :votes
end
