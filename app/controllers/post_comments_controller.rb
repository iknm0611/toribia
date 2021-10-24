class PostCommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)

    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
