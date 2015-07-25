class AddReferences < ActiveRecord::Migration
  def change
    add_column :options, :form_id, :integer
    add_column :answers, :form_id, :integer
  end
end
