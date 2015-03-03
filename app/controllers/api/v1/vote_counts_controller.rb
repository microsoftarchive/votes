class Api::V1::VoteCountsController < ApplicationController
  def show
    vc = VoteCount.where(task_id: params.require(:task_id)).first!
    json = { id: vc.id, amount: vc.amount, revision: vc.revision, task_id: vc.task_id }
    render json: json
  end

  # TODO: get the vote counts for list_id
end
