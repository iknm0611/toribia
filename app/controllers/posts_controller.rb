class PostsController < ApplicationController

  before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
    @user = current_user
    @favorite = Favorite.new
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @favorite = Favorite.new
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
  if  @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to posts_path
  else
      @posts = Post.all
      render :index
  end
  end

  def edit
     @post = Post.find(params[:id])
  end

  def search
      @user = current_user
      @posts = Post.search(params[:keyword])
      @keyword = params[:keyword]
      render "index"
  end

  def sort
     @user = current_user
     @posts = Post.sort(params[:sort])
     render "index"
  end

  def update
      @post = Post.find(params[:id])
  if  @post.update(post_params)
      flash[:notice] = 'Post was successfully updated.'
      redirect_to posts_path
  else
      render :edit
  end
  end

  def destroy
      post = Post.find(params[:id])
  if  post.destroy
      flash[:notice] = "Post was successfully destroyed."
      redirect_to posts_path
  end
  end

  private

  def ensure_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to new_post_path unless @post
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

end



