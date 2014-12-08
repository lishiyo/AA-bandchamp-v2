class Track < ActiveRecord::Base

	validates :name, presence: true
	
	belongs_to :album
	has_one :band, through: :album, source: :band

end
