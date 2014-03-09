class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :entry, inverse_of: :comments
end
