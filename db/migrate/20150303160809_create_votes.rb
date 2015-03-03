class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :task_id, null: false
      t.integer :user_id, null: false
      t.integer :revision, default: 1, null: false

      t.timestamps null: false
    end
    add_index :votes, :task_id
    add_index :votes, :user_id
  end
end
