class GenreTagging < ActiveRecord::Base
	
	belongs_to :album
	belongs_to :genre
	
	validates :album, :genre, presence: true
	validates :genre, uniqueness: { scope: :album }
	
end
