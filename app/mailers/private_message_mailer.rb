class PrivateMessageMailer < ApplicationMailer
    def send_email_to_reciever(receiver, sender)
        @recipient = receiver
        @sender = sender

        mail(to: @recipient.email, subject: "New private message on Glipboard from #{@sender.username}")
    end
end