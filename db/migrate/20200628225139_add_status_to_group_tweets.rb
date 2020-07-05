class AddStatusToGroupTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :group_tweets, :status, :integer, default: 0, null: false
  end
end
