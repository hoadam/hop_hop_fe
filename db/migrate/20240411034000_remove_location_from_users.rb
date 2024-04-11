class RemoveLocationFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :location, :string
  end
end
