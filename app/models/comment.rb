class Comment < ActiveRecord::Base
  belongs_to :entry, inverse_of: :comments
  belongs_to :user, inverse_of: :comments

  validates :description, :user, :entry, :presence => true
  validates :description, :length => { maximum: 400 }
  validates :user_id, :uniqueness => { :scope => :entry_id }
end
