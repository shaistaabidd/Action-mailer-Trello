class CardsController < ApplicationController
  
  before_action :set_card, only: %i[ show edit update delete destroy ]
  before_action :authenticate_user!
  before_action :get_list
  before_action :get_board
  load_and_authorize_resource :board
  
  def index
    #@cards = Card.where(list_id: @list.id)
    @cards = @list.cards.order("updated_at DESC")
  end

  def show
        
  end

  def new
    #@board=@list.board
    #@board = Board.find(params[:board_id])
    @card = Card.new
  end

  def create
    #@board = Board.find(params[:board_id])
    #@board=@list.board
    @card = Card.new(card_params)
    @card.list_id = @list.id
    
    if @card.save      
      flash[:notice] = "Card created successfully......"
      redirect_to board_list_cards_path(@card.list.board, @card.list)
    else
      
      flash[:notice] = "Invalid Card Name!!!"
      render('new')      
    end
  
  end

  def edit
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
      params.required(:card).permit(:name,:status)
    end
end
