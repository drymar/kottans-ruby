class AddFieldToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :visit_limit, :integer
  end
end
