class CreateVacations < ActiveRecord::Migration[5.0]
  def change
    create_table :vacations do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.text :description
      t.boolean :display_public, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
