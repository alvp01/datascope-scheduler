class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :location
      t.text :description
      t.datetime :end_time, null: false
      t.datetime :start_time, null: false
      t.boolean :is_physical_location, default: false

      t.references :user
      t.timestamps
    end
  end
end
