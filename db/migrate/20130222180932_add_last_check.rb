class AddLastCheck < ActiveRecord::Migration
  def up
    change_table :watches do |t|
      t.datetime :last_check
    end
  end

  def down
    change_table :watches do |t|
      t.remove :last_check
    end
  end
end
