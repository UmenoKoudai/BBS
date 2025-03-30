class ThreadsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]


  def index
    threads = ThreadModel.all
    render json: threads
  end

  def create
    thread = ThreadModel.new(thread_params)
    if thread.save
      render json: thread, status: :create
    else
      render json: thread.error, status: :unprocessable_entity
    end
  end

  def show
    thread = ThreadModel.find(params[:id])
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    limit = params[:limit].to_i > 0 ? params[:limit].to_i : 10

    total_comment = thread.comments.count
    total_pages = (total_comment.to_f / limit).ceil
    comments = thread.comments.order(created_at: :asc).offset((page - 1) * limit).limit(limit) 

    if thread && comments
      render json: {thread: thread, comments: comments, totalePage: total_pages}
    else
      render json: { error: "Thread not found"}, status: :not_found 
    end
  end

  def destroy
    thread = ThreadModel.find(params[:id])
    thread.destroy
    render json: { message: "Thread deleted"}
  end

  private

  def thread_params
    params.require(:thread).permit( :title, :summary)
  end

  def authorize_admin
    unless current_user.role == "admin"
      render json: { error: "Forbidden" }, status: :forbidden
    end
  end

end
