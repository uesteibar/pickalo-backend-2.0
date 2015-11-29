class AddQuestionToForm < ActiveRecord::Migration
  def change
    add_column :forms, :question, :string
  end
end
