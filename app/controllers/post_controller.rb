class PostController < ApplicationCOntroller
  def def index
    posts = Post.all
    render json: posts
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: post.:errors, status: :unprocessble_entity
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end