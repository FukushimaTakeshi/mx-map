class AddRegionRefToPrefecture < ActiveRecord::Migration[5.2]
  def change
    add_reference :prefectures, :region, foreign_key: true
  end
end
