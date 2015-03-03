class VoteCount < ActiveRecord::Base
  validates :task_id, presence: true

  def update_and_increment!(opts)
    with_lock do
      self.update! opts.merge(revision: revision + 1)
    end
  end

  def recalculate!
    self.update_and_increment! amount: Vote.where(task_id: task_id).count
  end
end
