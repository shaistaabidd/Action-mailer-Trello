class CommentsController < ApplicationController
  def index
  end

  def new
    @comment=Comment.new

  end
  
  def create
    @comment=Comment.new(comment_params)
    @comment.user_id=current_user.id
    if @comment.save
      flash[:notice] = "Comment Added successfully......"
      redirect_to("/comments")
    else
      render('new')
    end

  end
  
  def show
  end

  def edit
  end
end


private

  def comment_params
    params.required(:comment).permit(:text)
  end 