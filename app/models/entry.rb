class Entry < ActiveRecord::Base

  #do NOT change the order of the award or status enum
  enum award: [ :loser, :finalist, :runner_up, :winner  ]
  enum status: [ :pending, :approved, :rejected ]

  belongs_to :user, inverse_of: :entries
  belongs_to :event, inverse_of: :entries, counter_cache: true
  has_many :comments, inverse_of: :entry
  has_many :votes, inverse_of: :entry

  validates :user, :event, :title, :description, :content_type, :award, :status, presence: true
  validates :title, length: { maximum: 60 }, uniqueness: true
  validates :description, length: { maximum: 300 }
  validates :user_id, uniqueness: { scope: :event_id }

  scope :approved, -> { where status: Entry.statuses[:approved] }
  scope :pending, -> { where status: Entry.statuses[:pending] }
  scope :winners, -> { where award: Entry.awards[:winner] }
  scope :runner_ups, -> { where award: Entry.awards[:runner_up] }
  scope :finalists, -> { where award: Entry.awards[:finalist]}

end
