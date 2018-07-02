class CreateLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :licenses do |t|
      t.string :mx_class

      t.timestamps
    end
  end
end
