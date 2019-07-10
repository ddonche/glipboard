class CommentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.new_comment.subject
  #
  def new_comment(comment)
    @comment = comment
    @glip = @comment.glip

    mail to: @glip.user.email, 
    subject: "New comment on your Glip #{@glip.title}"
  end
end
