class Note < ActiveRecord::Base

  belongs_to :notable, polymorphic: true
		
  validates :content, :notable_id, :notable_type, presence: true

  belongs_to :author, class_name: "User", foreign_key: :user_id
  validates :author, presence: true

end
