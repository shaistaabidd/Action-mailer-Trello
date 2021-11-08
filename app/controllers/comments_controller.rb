class CommentsController < ApplicationController
  def index
    @comments=Comment.all.order("updated_at DESC")
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
    @comment=Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "Comment updated successfully......"
      redirect_to comments_path
    else
      flash[:notice] = "Invalid Comment!!!"
      render('edit')
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path
    flash[:notice] = "Comment '#{@comment.text}' deleted successfully......"
  end

end


private

  def comment_params
    params.required(:comment).permit(:text)
  end 