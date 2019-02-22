class CreatePracticeRecodes < ActiveRecord::Migration[5.2]
  def change
    create_table :practice_recodes do |t|
      t.references :off_road_circuit, foreign_key: true
      t.references :user, foreign_key: true
      t.date :practice_date
      t.string :comment
      t.integer :duration

      t.timestamps
    end

    add_index :practice_recodes, [:user_id, :practice_date], name: 'unique_user_date', unique: true
  end
end
