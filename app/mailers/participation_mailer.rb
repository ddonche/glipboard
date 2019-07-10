class ParticipationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.new_comment.subject
  #
  def new_participation(glip)
    @glip = glip

    mail to: @glip.user.email, 
    subject: "Someone has joined you on #{@glip.title}"
  end
end
