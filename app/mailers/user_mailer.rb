class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    attachments.inline['trello.png'] = File.read('app/assets/images/trello.png')
    mail(
      from: 'admin@gmail.com',
      to: email_address_with_name(@user.email,@user.username) ,
      cc: 'xyz@gmail.com',
      bcc: 'm@gmail.com',
      subject: 'Welcome to Trello App'
    )

  end

  def assign_task_email
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @task=params[:task]
    mail(
      from: @user_from.email,
      to: email_address_with_name(@user_to.email,@user_to.username) ,
      cc: 'abc@gmail.com',
      bcc: 'xyz@gmail.com',
      subject: 'New Assigned Task'
    )
  end
  
  def reminder(to,from,card)
    @to=to
    @from=from
    @card=card
    mail(
      from: from.email,
      to: email_address_with_name(to.email,to.username) ,
      cc: 'abc@gmail.com',
      bcc: 'xyz@gmail.com',
      subject: 'Deadline Notification'
    )


  end


  def over_due(to,from,card)
    @to=to
    @from=from
    @card=card
    mail(
      from: from.email,
      to: email_address_with_name(to.email,to.username) ,
      cc: 'abc@gmail.com',
      bcc: 'xyz@gmail.com',
      subject: 'Over Due Date'
    )       
  end
  
end
