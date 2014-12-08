class Genre < ActiveRecord::Base
	
	validates :category, presence: true, uniqueness: true
	
	has_many :genre_taggings, inverse_of: :genre
	has_many :albums, through: :genre_taggings, source: :album
	
	
end
