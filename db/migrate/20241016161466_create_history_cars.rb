class CreateHistoryCars < ActiveRecord::Migration[7.2]
  def change
    create_table :history_cars do |t|
      t.references :car, null: false, foreign_key: true
      t.string :vin
      t.string :registration_number
      t.integer :last_mileage
      t.boolean :registration_restrictions
      t.boolean :wanted_status
      t.boolean :pledge_status
      t.integer :previous_owners
      t.boolean :accidents_found
      t.boolean :repair_estimates_found
      t.boolean :taxi_usage
      t.boolean :carsharing_usage
      t.boolean :diagnostics_found
      t.boolean :technical_inspection_found
      t.boolean :imported
      t.boolean :insurance_found
      t.boolean :recall_campaigns_found

      t.timestamps
    end
    add_index :history_cars, :vin, unique: true
  end
end
