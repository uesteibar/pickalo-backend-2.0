class ChangeColumnsInAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :vote_count
    remove_column :answers, :image_url

    add_column :answers, :option_id, :integer

  end
end
