class AddTypeFormOptionIdToOptions < ActiveRecord::Migration
  def change
  	add_column :options, :typeform_id, :string
  end
end
