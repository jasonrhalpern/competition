class Event < ActiveRecord::Base

  #do NOT change the order of the category enum
  enum category: [ :music, :fashion, :food, :dance, :comedy, :filmmaking, :acting, :writing ]
  enum status: [ :pending, :approved, :rejected ]

  belongs_to :user, inverse_of: :events
  has_many :entries, inverse_of: :event

  validates :user, :title, :description, :start_date, :end_date, :close_date, :category, :status, presence: true
  validates :title, length: { maximum: 80 }, uniqueness: true
  validates :description, length: { maximum: 600 }
  validate :dates_in_order

  scope :current, -> { where('start_date <= ? AND ? <= end_date', current_date, current_date) }
  scope :upcoming, -> { where('? < start_date', current_date) }
  scope :approved, -> { where status: Event.statuses[:approved] }
  scope :pending, -> { where status: Event.statuses[:pending] }

  def self.current_approved
    Event.current.approved.order(start_date: :desc)
  end

  def self.upcoming_approved
    Event.upcoming.approved.order(start_date: :desc)
  end

  def self.recent_winners
    joins(:entries).merge(Entry.winners).order(end_date: :desc)
  end

  def self.current_date
    Date.current
  end

  def closed?
    current_date > close_date
  end

  def ended?
    current_date > end_date
  end

  def current?
    start_date <= current_date and current_date <= end_date
  end

  def upcoming?
    current_date < start_date
  end

  def dates_in_order
    if start_date.present? and end_date.present? and end_date <= start_date
      errors.add :start_date, 'The start date has to be before the end date'
    end
    if end_date.present? and close_date.present? and end_date >= close_date
      errors.add :end_date, 'The end date has to be before the close date'
    end
  end

end
