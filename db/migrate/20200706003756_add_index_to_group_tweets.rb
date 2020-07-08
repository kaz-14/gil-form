class AddIndexToGroupTweets < ActiveRecord::Migration[6.0]
  def change
    add_index :group_tweets, :text, length: 32
  end
end
