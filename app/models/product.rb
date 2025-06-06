class Product < ApplicationRecord
  belongs_to :category

  has_many :cart_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :image
  has_many :order_items
  def self.search(title)
    if title.blank?
      all
    else
      where('name LIKE ?', "%#{title}%")
    end
  end
end
