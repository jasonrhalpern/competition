class Category < ActiveRecord::Base
  has_many :events, inverse_of: :category
end
