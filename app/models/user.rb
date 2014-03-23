class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries, inverse_of: :user
  has_many :events, inverse_of: :user
  has_many :comments, inverse_of: :user
  has_many :votes, inverse_of: :user

  validates :username, :presence => true, :uniqueness => true, :length => { :in => 5..20 }
end
