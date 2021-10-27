class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to posts_path
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
  	@comment = @post.comments.find(params[:id])
		if  @comment.destroy
		  redirect_to post_path(@post)
		end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end

end
