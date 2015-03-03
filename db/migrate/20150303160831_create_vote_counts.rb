class CreateVoteCounts < ActiveRecord::Migration
  def change
    create_table :vote_counts do |t|
      t.integer :task_id, null: false
      t.integer :amount, default: 0, null: false

      t.timestamps null: false
    end
    add_index :vote_counts, :task_id
  end
end
