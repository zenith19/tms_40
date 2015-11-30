class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.text :password_digest
      t.text :remember_digest
      t.boolean :supervisor

      t.timestamps null: false
    end
  end
end
