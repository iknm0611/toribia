class PostsController < ApplicationController

  def index
    @posts = Post.all
    #@user = post.user
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
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

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

end



