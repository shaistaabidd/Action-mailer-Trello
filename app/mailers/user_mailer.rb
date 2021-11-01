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

  
end
