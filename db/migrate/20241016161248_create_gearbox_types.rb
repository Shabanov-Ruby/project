class CreateGearboxTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :gearbox_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
