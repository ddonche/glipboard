class UserNotifier < ActionMailer::Base
  default :from => 'noreply@glipboard.com'

  # send a notification email to the user, pass in the user when someone joins their glip
  def send_joinglip_email(user)
    @glip.user = user
    mail( :to => @glip.user.email,
    :subject => 'Someone has participated in your Glip!' )
  end
  
  private
  
  def set_glip
    @glip  = Glip.find(params[:id])
  end
end
