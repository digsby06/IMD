class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  validates :username, length: { maximum: 20 }, :on => :create
  validates :password, length: { minimum: 8 }, :on => :create
  validates :password, confirmation: true, :on => :create

  default_scope { order('created_at DESC') }

  before_save { self.username = username.downcase }

end
