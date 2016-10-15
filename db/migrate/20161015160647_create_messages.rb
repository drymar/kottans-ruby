class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :token
      t.string :body
      t.string :password_digest
      t.integer :visit_number, default: 0
      t.timestamp :destroy_time

      t.timestamps
    end
    add_index :messages, :token, unique: true
  end
end
