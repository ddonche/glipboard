class MessagesController < ApplicationController
  before_action :find_conversation!
  before_action :authenticate_user!

  def new
    if current_user.reputation >= 20
      redirect_to conversation_path(@conversation) and return if @conversation
      @message = current_user.messages.build
    else
      redirect_to errors_path
    end
  end

  def create
    
    @conversation ||= Conversation.create(sender_id: current_user.id,
                                          receiver_id: @receiver.id)
    @message = current_user.messages.build(message_params)
    @message.conversation_id = @conversation.id
    @message.save!
    PrivateMessageMailer.send_email_to_reciever(@receiver).deliver_now

    Notification.create!(message_id: @message.id, recipient_id: @conversation.receiver_id,
                      conversation_id: @conversation.id,
                      notified_by_id: current_user.id, notification_type: "message")
    flash[:success] = "Your message was sent!"
    redirect_to conversation_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
  
  def find_conversation!
    if params[:receiver_id]
      @receiver = User.friendly.find_by(id: params[:receiver_id])
      redirect_to(root_path) and return unless @receiver
      @conversation = Conversation.between(current_user.id, @receiver.id)[0]
    else
      @conversation = Conversation.find_by(id: params[:conversation_id])
      redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
    end
  end
end