class Post < ActiveRecord::Base
  has_attached_file :image, styles: {
		
		large: "400x400"
	}

	# Validate the attached image is image/jpg, image/png, etc
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
