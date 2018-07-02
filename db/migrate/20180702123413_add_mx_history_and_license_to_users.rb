class AddMxHistoryAndLicenseToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :license, foreign_key: true
    add_reference :users, :mx_history, foreign_key: true
  end
end
