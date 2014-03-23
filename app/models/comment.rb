class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :entry, inverse_of: :comments

  validates :description, :user, :entry, :presence => true
  validates :description, :uniqueness => {:scope => [:user_id, :entry_id]}, :length => { maximum: 400 }
end
