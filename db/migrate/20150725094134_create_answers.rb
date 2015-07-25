class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :image_url
      t.integer :vote_count

      t.timestamps null: false
    end
  end
end
