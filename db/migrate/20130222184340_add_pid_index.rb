class AddPidIndex < ActiveRecord::Migration
  def up
    change_table :petitions do |t|
      t.index :pid
    end
  end

  def down
  end
end
