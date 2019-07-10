class PrivateMessageMailer < ApplicationMailer
    def send_email_to_reciever(receiver)
        @recipient = receiver

        mail(to: @recipient.email, subject: "New private message on Glipboard")
    end
end