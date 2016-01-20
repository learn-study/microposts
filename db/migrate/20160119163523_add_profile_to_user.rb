class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :integer
    add_column :users, :profile, :text
    add_column :users, :url, :string
    add_column :users, :area, :string
  end
end
