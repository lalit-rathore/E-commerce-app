class Product < ApplicationRecord
    belongs_to :category
    
    has_one_attached :image


    def self.search(title)
        if title.blank?
          all
        else
          where('name LIKE ?', "%#{title}%")
        end
      end
end
