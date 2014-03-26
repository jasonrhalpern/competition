class Entry < ActiveRecord::Base

  #do NOT change the order of the award enum
  enum award: [ :loser, :finalist, :runner_up, :winner  ]

  belongs_to :user, inverse_of: :entries
  belongs_to :event, inverse_of: :entries, counter_cache: true
  has_many :comments, inverse_of: :entry
  has_many :votes, inverse_of: :entry

  validates :user, :event, :title, :description, :content_type, :award, :presence => true
  validates :title, :length => { maximum: 60 }, :uniqueness => true
  validates :description, :length => { maximum: 300 }

end
