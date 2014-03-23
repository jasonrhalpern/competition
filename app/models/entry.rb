class Entry < ActiveRecord::Base
  belongs_to :user, inverse_of: :entries
  belongs_to :event, inverse_of: :entries, counter_cache: true
  has_many :comments, inverse_of: :entry
  has_many :votes, inverse_of: :entry
  has_one :award, inverse_of: :entry
  has_one :distinction, through: :award

  validates :user, :event, :title, :description, :content_type, :presence => true
  validates :title, :length => { maximum: 60 }, :uniqueness => true
  validates :description, :length => { maximum: 300 }

end
