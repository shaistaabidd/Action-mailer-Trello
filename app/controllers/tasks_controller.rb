class TasksController < ApplicationController
  before_action :authenticate_user!
  def new
    @task=Task.new
  end

  def create
    @task=Task.new(task_params)
    @task.user_id=current_user.id


    if @task.save      
      flash[:notice] = "Task is Assigned Successfully!!!"
      redirect_to tasks_path
    else
      
      flash[:notice] = "Invalid Input, Try Again!!!"
      render('new')      
    end

  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def task_params
    params.require(:task).permit(:username, :task)    
  end
end
