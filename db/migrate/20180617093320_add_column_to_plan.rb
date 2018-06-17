class AddColumnToPlan < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :uuid, :string
  end
end
