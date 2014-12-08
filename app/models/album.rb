class Album < ActiveRecord::Base
	
	belongs_to :band, class_name: "Band", foreign_key: :band_id
	validates :band, presence: true
	validates :album_type, inclusion: { in: ["studio", "live"] }
	
	has_many :tracks, class_name: "Track", foreign_key: :album_id, inverse_of: :album, dependent: :destroy
	
	has_many :images, as: :attachable, dependent: :destroy
	has_many :genre_taggings, inverse_of: :album, dependent: :destroy
	has_many :genres, through: :genre_taggings, source: :genre
	
	
	def genre_categories
		Genre.joins(genre_taggings: :album).where('albums.id = ?', self.id).pluck('genres.category')
	end
	
end
