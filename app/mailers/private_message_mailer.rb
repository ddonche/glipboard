class PrivateMessageMailer < ApplicationMailer
    def send_email_to_reciever(receiver)
        @reciever = receiver

        mail(to: @reciever.email, subject: "New private message on Glipboard")
    end
end