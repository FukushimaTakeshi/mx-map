class RemoveAttendanceFromPlan < ActiveRecord::Migration[5.2]
  def change
    remove_column :plans, :attendance, :integer
  end
end
