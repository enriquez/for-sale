class Photo < ActiveRecord::Base
  belongs_to :product

  # There's some magic here that switches the storage to s3 or filesystem depending on if 
  # APP_CONFIG['s3_bucket'] is set. See config/initializers/load_config.rb on how to set.
  has_attached_file :file, :styles => { :small => "100x100>", :thumb => "248x186>", :medium => "600x600>" },
    :storage => (APP_CONFIG["s3_bucket"] ? :s3 : :filesystem),
    :s3_credentials => { :access_key_id => APP_CONFIG['access_key_id'], :secret_access_key => APP_CONFIG['secret_access_key'] },
    :path => (APP_CONFIG["s3_bucket"] ? ":attachment/:id/:style.:extension" : ":rails_root/public/system/:attachment/:id/:style/:filename"),
    :bucket => APP_CONFIG["s3_bucket"]
  
  validates_attachment_presence :file
  validates_attachment_size :file, :less_than => 5.megabytes
  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'image/gif']

  # Fix the mime types. Make sure to require the mime-types gem
  def swf_uploaded_data=(data)
    data.content_type = MIME::Types.type_for(data.original_filename)
    self.file = data
  end
end
