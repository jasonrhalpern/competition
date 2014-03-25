class Event < ActiveRecord::Base
  belongs_to :user, inverse_of: :events
  has_many :entries, inverse_of: :event

  validates :user, :category, :title, :description, :start_date, :end_date, :close_date, :presence => true
  validates :title, :length => { maximum: 80 }, :uniqueness => true
  validates :description, :length => { maximum: 600 }
end
