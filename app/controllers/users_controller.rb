class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def followings
    @user = current_user
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    @user = current_user
    user = User.find(params[:id])
    @users = user.followers
  end

  def search
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    @user = current_user
    render "index"
  end

  def update
    @posts = Post.all
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end


