class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.integer :account_id
      t.boolean :account_owner, default: false

      t.timestamps
    end
  end
end
