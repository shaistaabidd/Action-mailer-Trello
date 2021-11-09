class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_card
  before_action :get_list
  before_action :get_board
  
  #load_and_authorize_resource :board

  def index
    #@comments=Comment.all.order("updated_at DESC")
    @comments=@card.comments.order("updated_at DESC")
    @other_user=Comment.where(user_name: @card.username)
    
  end

  def new
    
    @comment=Comment.new
    
  end
  
  def create
    @comment=Comment.new(comment_params)
    @comment.card_id=@card.id
    @comment.user_name=current_user.username
    if @comment.save
      flash[:notice] = "Comment Added successfully......"
      redirect_to board_list_card_comments_path
    else
      render('new')
    end

  end
  
#   def show
#   end

  def edit
    @comment=Comment.find(params[:id])
    
  end
  def update
    @comment=Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated successfully......"
      redirect_to board_list_card_comments_path
    else
      flash[:notice] = "Invalid Comment!!!"
      render('edit')
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to board_list_card_comments_path
    flash[:notice] = "Comment '#{@comment.text}' deleted successfully......"
  end

end


private

  def get_card
    @card = Card.find(params[:card_id])
  end
    
  def get_list
    @list = @card.list
  end

  def get_board
    @board = @list.board
  end

  def comment_params
    params.required(:comment).permit(:text)
  end 
