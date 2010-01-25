class AddProductIdToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :product_id, :integer
  end

  def self.down
    remove_column :photos, :product_id
  end
end
