class DeleteImagesSupport < ActiveRecord::Migration
  def change
    remove_column :options, :image_url
  end
end
