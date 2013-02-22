class AddInitialData < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :login
      t.text :email
      t.timestamps
    end

    create_table :watches do |t|
      t.references :user
      t.string :term
      t.datetime :last_alert
      t.timestamps
    end

    create_table :petitions do |t|
      t.string :pid
      t.string :url
      t.string :title
      t.text :body
      t.text :issues
      t.integer :signatures
      t.datetime :created_time
      t.boolean :answered
      t.timestamps
    end

  end

  def down
    drop_table :users
    drop_table :watches
    drop_table :petitions
  end
end
