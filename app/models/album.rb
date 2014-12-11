class Album < ActiveRecord::Base

	include Imageable
	include Noteable

	belongs_to :band, class_name: "Band", foreign_key: :band_id
	validates :band, presence: true
	validates :album_type, inclusion: { in: ["studio", "live"] }

	has_many :tracks, class_name: "Track", foreign_key: :album_id, inverse_of: :album, dependent: :destroy

	has_many :genre_taggings, inverse_of: :album, dependent: :destroy
	has_many :genres, through: :genre_taggings, source: :genre

	
	def genre_categories #genre names
		Genre.joins(genre_taggings: :album).where('albums.id = ?', self.id).pluck('genres.category').uniq
	end

	def genre_ids #genre names
		Genre.joins(genre_taggings: :album).where('albums.id = ?', self.id).pluck('genres.id').uniq
	end

	# attach when creating a new album
	def attach_genre_taggings(genre_ids)
		return true if genre_ids.empty?

		Album.transaction do
			genre_ids.each do |id|
				self.genre_taggings.create!(genre_id: id)
			end
		end

	end

end
