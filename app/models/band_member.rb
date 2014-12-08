class BandMember < ActiveRecord::Base
	has_many :images, as: :attachable, dependent: :destroy

	belongs_to :band
	validates :band, :name, presence: true
	validates :name, uniqueness: { scope: :band}
	validates :gender, inclusion: { in: %w(M F) }
	has_many :notes, as: :notable, dependent: :destroy
	
end
