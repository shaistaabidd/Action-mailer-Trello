class CardsController < ApplicationController
    
  before_action :set_card, only: %i[ show edit update delete destroy ]
  before_action :authenticate_user!
  before_action :get_list
  before_action :get_board
  load_and_authorize_resource :card, :through => :list
  #load_and_authorize_resource 
  def index
    #@cards = Card.where(list_id: @list.id)
    #@cards = @list.cards.order("updated_at DESC")
    @tasks=@list.cards
    @my_tasks=Card.where(username: current_user.username)
  end

  def filter
    @searched_tag=@list.cards.tagged_with(params[:id])
    
  end
  
  def show
  end

  def new
    #@board=@list.board
    #@board = Board.find(params[:board_id])
    #@users_list =User.where.not(username: nil).pluck(:username)
    @card = Card.new
  end

  def create
    #@board = Board.find(params[:board_id])
    #@board=@list.board
    @card = Card.new(card_params)
    @card.list_id = @list.id
    @to=User.find_by(username: @card.username)
    if @card.save      
      flash[:notice] = "Card created successfully......"
      UserMailer.with(user_to: @to, user_from: current_user, task: @card).assign_task_email.deliver_now
      # CardJob.set(wait_until: (@card.deadline.strftime("  %M").to_i-Time.now.strftime("  %M").to_i).minutes.from_now).perform_later(@card)
      
      #UserMailer.with(user_to: @to, user_from: current_user, task: @card).assign_task_email.deliver_later(wait_until: 1.minute.from_now)
      redirect_to board_list_cards_path(@card.list.board, @card.list)
    else
      p @card.errors
      
      flash[:notice] = "Invalid Card Name!!!"
      render('new')      
    end
  
  end

  def edit
    @users_list =User.where.not(username: nil).pluck(:username)
    #@board=@list.board
  end

  def update
    
    if @card.update(card_params)    
      flash[:notice] = "Card updated successfully......"
      redirect_to board_list_cards_path(@card)
    else
      flash[:notice] = "Invalid Card Name!!!"
      render('edit')
    end
  
  end

  def destroy  
    @card.destroy
    redirect_to board_list_cards_path
    flash[:notice] = "Card '#{@card.name}' deleted successfully......"
  end
  
  private
  
    def set_card
      @card = Card.find(params[:id])
    end
    
    def get_list
      @list = List.find(params[:list_id])
    end
    
    def get_board
      @board = @list.board
    end
    
    def card_params
      params.required(:card).permit(:name,:status,:username, :deadline, :tag_list)
      
    end
end
