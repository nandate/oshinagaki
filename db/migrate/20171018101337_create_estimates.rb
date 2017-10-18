class CreateEstimates < ActiveRecord::Migration[5.0]
  def change
    create_table :estimates do |t|
      t.string :name
      t.string :term
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :estimates, [:user_id, :created_at]
  end
end
