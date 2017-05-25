class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|

      t.references :user, foreign_key: true
      t.references :vacation, foreign_key: true
      t.references :park, foreign_key: true

      t.date :start_date, null: false
      t.date :end_date, null: false      

      t.timestamps
    end
  end
end
