class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders
  after_create :create_cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    role == 'admin'
  end
end
