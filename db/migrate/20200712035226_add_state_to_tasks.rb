class AddStateToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :state, :integer, default: 0, null: false
  end
end
