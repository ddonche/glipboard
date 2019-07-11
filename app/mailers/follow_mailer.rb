class FollowMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.new_comment.subject
  #
  def new_follower_notification(user, follower)
    @user = user
    @follower = follower

    mail to: @user.email, 
    subject: "#{@follower.username} is now following you on Glipboard!"
  end
end
