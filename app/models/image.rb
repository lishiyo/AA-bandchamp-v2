class Image < ActiveRecord::Base
	
	belongs_to :attachable, :polymorphic => true
	
	mount_uploader :attachment, ImageUploader
		
end
