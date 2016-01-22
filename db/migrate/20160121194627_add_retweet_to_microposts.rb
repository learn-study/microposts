class AddRetweetToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :retweet, :integer, default: nil
  end
end
