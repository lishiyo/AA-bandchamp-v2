module Imageable
	
	extend ActiveSupport::Concern
	
	included do
    has_many :images, as: :attachable, dependent: :destroy
# 	accepts_nested_attributes_for :images
# 	attr_accessor :images_attributes
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
