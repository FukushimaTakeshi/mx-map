class RemoveColumnToUser < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :users, :licenses
    remove_reference :users, :license, index: true

    remove_foreign_key :users, :mx_histories
    remove_reference :users, :mx_history, index: true
  end
end
