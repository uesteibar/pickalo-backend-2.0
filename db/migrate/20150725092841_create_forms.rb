class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :typeform_id
      t.string :typeform_url

      t.timestamps null: false
    end
  end
end
