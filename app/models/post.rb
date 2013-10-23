class Post < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :custom => "400X400" }, :default_url => "/images/:style/missing.png"
  
 # gps_jpg = EXIFR::JPEG.new(:image).gps? 

 after_image_post_process :load_exif
 validates_attachment :image, :presence => true
 validates_attachment_content_type :image, :content_type => ['image/jpeg']

  def load_exif
   exif_img = EXIFR::JPEG.new(image.queued_for_write[:custom].path)
   self.latitude = exif_img.gps.latitude
   self.longitude = exif_img.gps.longitude
  end

end