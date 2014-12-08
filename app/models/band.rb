class Band < ActiveRecord::Base

	validates :name, presence: true
	validates :tagline, length: { maximum: 50 }

	belongs_to :submitter, class_name: "User", foreign_key: :submitter_id
	has_many :images, as: :attachable, dependent: :destroy

	has_many :albums, class_name: "Album", foreign_key: :band_id, inverse_of: :band, dependent: :destroy
	has_many :genres, through: :albums, source: :genres

	has_many :members, class_name: "BandMember", foreign_key: :band_id, inverse_of: :band


	scope :recent, ->(num=10) { order('created_at DESC').limit(num) }

	def genre_categories
		Genre.joins(genre_taggings: [{ album: :band }]).where('bands.id = ?', self.id).pluck('genres.category').uniq
	end

	def has_images?
		!self.images.empty?
	end

	# url to most recent pic
	def profile_pic
		return unless has_images?
		self.images.order('created_at DESC').first.attachment.url
	end

	def profile_thumb
		return unless has_images?
		self.images.order('created_at DESC').first.attachment.thumb.url
	end

	# urls of image attachments
	def image_urls
		self.images.map(&:attachment).map(&:url)
	end

end
