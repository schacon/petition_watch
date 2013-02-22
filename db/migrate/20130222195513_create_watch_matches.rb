class CreateWatchMatches < ActiveRecord::Migration
  def change
    create_table :watch_matches do |t|
      t.references :watch
      t.references :petition
      t.timestamps
    end
  end
end
