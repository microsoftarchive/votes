class Api::V1::VotesController < ApplicationController
  def create
    user_id = params.require(:user_id)
    task_id = params.require(:task_id)
    with_task(task_id) do
      vote = Vote.first_or_create task_id: task_id, user_id: user_id
      rep = { id: vote.id, user_id: user_id, task_id: task_id, revision: vote.revision }
      render json: rep, status: 201
    end
  end

  def destroy
    user_id = params.require(:user_id)
    task_id = params.require(:task_id)
    with_task(task_id) do
      vote = Vote.find_by task_id: task_id, user_id: user_id
      vote.destroy
      content_type "application/json"
      render nothing: true
    end
  end

  private

  def with_task(task_id)
    uri = URI("http://a.wunderlist.com/api/v1/tasks/#{task_id}")
    req = Net::HTTP::Get.new(uri)
    req["X-Client-ID"] = request.headers["X-Client-ID"]
    req["X-Access-Token"] = request.headers["X-Access-Token"]
    res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request req }

    if res.code == '200'
      yield
    elsif res.code == '404'
      render json: { error: :not_found }, status: 404
    else
      render json: { error: :server_error }, status: 500
    end
  end
end
