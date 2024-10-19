class CreateImages < ActiveRecord::Migration[7.2]
  def change
    create_table :images do |t|
      t.references :car, null: false, foreign_key: true
      t.string :url
      t.string :description
      t.boolean :is_primary

      t.timestamps
    end
  end
end
