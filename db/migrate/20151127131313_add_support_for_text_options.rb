class AddSupportForTextOptions < ActiveRecord::Migration
  def change
    remove_column :options, :typeform_id
    add_column :options, :label, :string
  end
end
