class Api::V1::VoteCountsController < ApplicationController
  def show
    if params[:task_id]
      for_task
    elsif params[:list_id]
      for_list
    end
  end

  def for_task
    vc = VoteCount.where(task_id: params.require(:task_id)).first!
    json = { id: vc.id, amount: vc.amount, revision: vc.revision, task_id: vc.task_id }
    render json: json
  end

  def for_list
    with_tasks(params.require(:list_id)) do |tasks|
      vote_counts = tasks.map do |task|
        Rails.logger.error task.inspect
        VoteCount.where(task_id: task['id']).first
      end
      vote_counts.compact!
      render json: vote_counts
    end
  end

  private

  def error_resp
    render json: { error: :server_error }, status: 500
  end

  def not_found_resp
    render json: { error: :not_found }, status: 404
  end

  def get_w(path)
    uri = URI("http://a.wunderlist.com/#{path}")
    req = Net::HTTP::Get.new(uri)
    req["X-Client-ID"] = request.headers["X-Client-ID"]
    req["X-Access-Token"] = request.headers["X-Access-Token"]
    res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request req }
  end

  def with_tasks(list_id)
    res = get_w("api/v1/tasks?list_id=#{list_id}")
    Rails.logger.error "*"*80
    Rails.logger.error res.body
    Rails.logger.error "*"*80

    if res.code == '200'
      tasks = JSON.parse(res.body)
      yield(tasks)
    elsif res.code == '404'
      not_found_resp
    else
      error_resp
    end
  end
end
