class CreateMxHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :mx_histories do |t|
      t.string :history

      t.timestamps
    end
  end
end
