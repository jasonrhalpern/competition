class Award < ActiveRecord::Base
  belongs_to :distinction, inverse_of: :awards
  belongs_to :entry, inverse_of: :award
  belongs_to :event, inverse_of: :awards
end
