module Noteable
	
	extend ActiveSupport::Concern
	
	included do
    has_many :notes, as: :notable, dependent: :destroy
  end


end