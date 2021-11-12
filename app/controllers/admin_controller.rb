class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    @users=get_all_users
    
  end

  def reset_password
    @user=""
  end

  def change
    @user=User.find(params[:id])
    password=BCrypt::Password.create(params[:password])
    if @user.update(encrypted_password: password)
      flash[:notice] = "Password updated successfully......"
      redirect_to admin_index_path
    else
      render('reset_password')
    end
  end

  def activate
    @user=User.find(params[:id])
    @user.update(deactivated:false)
    redirect_to admin_index_path
  end

  def deactivate
    @user=User.find(params[:id])
    @user.update(deactivated:true)
    redirect_to admin_index_path
  end

  private

  def get_all_users
    User.with_role(:user)
  end

  
end
