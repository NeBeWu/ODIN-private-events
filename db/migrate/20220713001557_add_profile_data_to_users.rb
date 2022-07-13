class AddProfileDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :text
    add_column :users, :description, :text
    add_column :users, :website, :text
  end
end
