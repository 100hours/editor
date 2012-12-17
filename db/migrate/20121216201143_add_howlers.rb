class AddHowlers < ActiveRecord::Migration
  def change
    create_table :howlers do |t|
      t.string :url
      t.integer :charges
      t.text :notes

      t.timestamps
    end
  end
end
