class RenameUsernameToNameInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :username, :name
  end
end
