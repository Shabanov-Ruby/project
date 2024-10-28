class CreateCallRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :call_requests do |t|
      t.references :car, null: false, foreign_key: true
      t.string :name
      t.bigint :phone
      t.string :preferred_time

      t.timestamps
    end
  end
end
