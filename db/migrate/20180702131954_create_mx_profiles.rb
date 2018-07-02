class CreateMxProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :mx_profiles do |t|
      t.references :mx_history, foreign_key: true
      t.references :license, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
