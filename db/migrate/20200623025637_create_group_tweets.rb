class CreateGroupTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :group_tweets do |t|
      t.string :title
      t.string :text
      t.string :image
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
