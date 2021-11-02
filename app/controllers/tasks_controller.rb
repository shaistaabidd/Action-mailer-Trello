class TasksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def new
    @users_list =User.where.not(username: nil).pluck(:username)
    #@a=User.pluck(:username)
    @task=Task.new
  end

  def create
    @task=Task.new(task_params)
    @task.user_id=current_user.id
    @to=User.find_by(username: @task.username)

    if @task.save      
      flash[:notice] = "Task is Assigned Successfully!!!"
      UserMailer.with(user_to: @to, user_from: current_user, task: @task).assign_task_email.deliver_now
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
    @users_list =User.where.not(username: nil).pluck(:username)
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

  def destroy
    @task=Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
    flash[:notice] = "Task '#{@task.task}' deleted successfully......"
 

  end


  private

  def task_params
    params.require(:task).permit(:username, :task)    
  end
end
