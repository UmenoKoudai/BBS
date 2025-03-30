class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def create
    Rails.logger.debug "パラメーター：#{params.inspect}"
    thread = ThreadModel.find(params[:thread_id])

    # パラメータをログで確認
    comment_params = comment_param
    Rails.logger.debug "コメントパラメータ：#{comment_params.inspect}"

    # コメントを新規作成
    comment = thread.comments.new(comment_params)

    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = comment.find(params[:id])
    comment.destroy
    render json: { message: "Comment deleted successfully"}, status: :ok
  end


  private

  def comment_param
    # コメントのパラメータを許可
    params.require(:comment).permit(:name, :text)
  end

  def authorize_admin
    unless current_user.role == "admin"
      render json: { error: "Forbidden" }, status: :forbidden
    end
  end


end
