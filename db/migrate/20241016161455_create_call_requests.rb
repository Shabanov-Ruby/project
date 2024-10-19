class CreateCallRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :call_requests do |t|
      t.references :car, null: false, foreign_key: true
      t.string :name
      t.string :phone
      t.datetime :preferred_time

      t.timestamps
    end
  end
end
