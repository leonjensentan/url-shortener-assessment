class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.string :originating_geolocation
      t.references :url, null: false, foreign_key: true
      t.timestamps
    end
  end
end
