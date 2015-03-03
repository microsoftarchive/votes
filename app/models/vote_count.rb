class VoteCount < ActiveRecord::Base
  validates :task_id, presence: true

  def recalculate!
    self.update! amount: Vote.where(task_id: task_id).count
  end
end
