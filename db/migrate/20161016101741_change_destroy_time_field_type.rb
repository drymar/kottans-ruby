class ChangeDestroyTimeFieldType < ActiveRecord::Migration
  def change
    remove_column :messages, :destroy_time, :datetime
    add_column :messages, :destroy_time, :integer
  end
end
