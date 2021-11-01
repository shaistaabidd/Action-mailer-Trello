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
    @tasks=current_user.tasks
    @my_tasks=Task.where(username: current_user.username)
  end

  def show
    @task=Task.find(params[:id])
  end

  def edit
    @task=Task.find(params[:id])
  end


  def update
    @task=Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task updated successfully......"
      redirect_to tasks_path
    else
      flash[:notice] = "Invalid Input, Try Again!!!"
      render('edit')
    end
  end


  private

  def task_params
    params.require(:task).permit(:username, :task)    
  end
end
