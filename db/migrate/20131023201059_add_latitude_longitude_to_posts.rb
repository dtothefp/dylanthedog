class AddLatitudeLongitudeToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.decimal :latitude
      t.decimal :longitude
    end
  end
end

 
