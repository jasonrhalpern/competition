class User < ActiveRecord::Base

  #do NOT change the order of the role enum
  enum role: [ :regular, :producer, :admin ]

  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable

  has_many :entries, inverse_of: :user
  has_many :events, inverse_of: :user
  has_many :comments, inverse_of: :user
  has_many :votes, inverse_of: :user

  validates :email, presence: true, uniqueness: true, format: { with: Devise::email_regexp }
  validates :username, presence: true, uniqueness: true, length: { in: 5..20 }
  validates :password, presence: true, confirmation: true, length: { in: 6..20 }, if: :password_required?
  validates :role, presence: true
  validate :password_complexity

  def password_complexity
    if password.present? and not password.match(/^(?=.*[\d[!@#$%\^*()_\-=?|;:.,<>]])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%\^*()_\-=?|;:.,<>]*$/)
      errors.add :password, 'Invalid password. Passwords must be 6-20 characters and contain at least one letter and one number or special character.'
    end
  end

  def password_required?
    !password.nil? || !password_confirmation.nil?
  end
end
