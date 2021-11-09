# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Board, user_id: user.id
    can :manage, Task, user_id: user.id
    can :manage, List do |list|
      p "checking list abilities", list
      list.board.user_id == user.id  
    end
    can :read, Card do |s|
      s.username == user.username || s.list.board.user.username==user.username   
    end
    can :manage, Card do |s|
      s.list.board.user.username==user.username   
    end

    # can :show, Card, username: user.username
    # can :update, Card, username: user.username
    # can :destroy, Card, username: user.username
    
    # can :read, Card do |s|
    #   raise "hello1"
    #   p "checking ability",s.username, user.username
    #   s.username == user.username   
    # end

    # can :read, Card do |s|
    #   raise "hello2"

    #   p "card check", s
    #   p "checking ability",s.list.board.user_id, user.id
    #   s.list.board.user_id == user.id   
    # end
    

    # can :show, Card, username: user.username
    
    #can :manage, Card, username: user.username
    #can :show, Card
    #can :manage, List, :board => { :user_id => user.id }
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
