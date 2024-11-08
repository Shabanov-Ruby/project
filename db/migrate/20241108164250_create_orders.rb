class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :buyout, foreign_key: true
      t.references :credit, foreign_key: true
      t.references :exchange, foreign_key: true
      t.references :installment, foreign_key: true
      t.references :call_request, foreign_key: true
      t.references :order_status, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
