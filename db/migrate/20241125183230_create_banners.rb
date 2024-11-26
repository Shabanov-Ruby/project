class CreateBanners < ActiveRecord::Migration[7.2]
  def change
    create_table :banners do |t|
      t.string :image

      t.timestamps
    end
  end
end
