class Track < ActiveRecord::Base

	include Noteable
	
	validates :name, presence: true

	belongs_to :album
	has_one :band, through: :album, source: :band

	
end
