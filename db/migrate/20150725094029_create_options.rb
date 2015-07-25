class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :image_url

      t.timestamps null: false
    end
  end
end
