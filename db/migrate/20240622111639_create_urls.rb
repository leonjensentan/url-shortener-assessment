class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string "target_url"
      t.string "short_url", limit: 15
      t.string "title_tag", default: "Untitled Page"
      t.integer "clicks", default: 0
      t.timestamps
    end
  end
end
