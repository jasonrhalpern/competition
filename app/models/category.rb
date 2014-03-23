class Category < ActiveRecord::Base
  has_many :events, inverse_of: :category

  validates :type, :presence => true
end
