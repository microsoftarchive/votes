class Vote < ActiveRecord::Base
  validates :task_id, :user_id, presence: true
  validates :task_id, uniqueness: { scope: :user_id }

  after_save :update_counts

  def update_counts
    VoteCount.find_or_create_by(task_id: task_id).recalculate!
  end
end
