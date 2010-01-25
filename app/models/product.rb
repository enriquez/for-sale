class Product < ActiveRecord::Base
  has_many :photos
  default_scope :order => 'id ASC'
end
