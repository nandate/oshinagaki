class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :content
      t.string :image_url
      t.string :author
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
