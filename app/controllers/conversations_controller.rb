class ConversationsController < ApplicationController
  before_action :find_conversation!, except: [:index]
  before_action :check_participating!, except: [:index]  

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
  end
  
  def show
    @message = Message.new
  end
  
  private
  
  def find_conversation!
    if params[:receiver_id]
      @receiver = User.find_by(id: params[:receiver_id])
      redirect_to(conversations_path) and return unless @receiver
      @conversation = Conversation.between(current_user.id, @receiver.id)[0]
    else
      @conversation = Conversation.find_by(id: params[:conversation_id])
      redirect_to(conversations_path) and return unless @conversation && @conversation.participates?(current_user)
    end
  end
  
  def check_participating!
    redirect_to conversations_path unless @conversation && @conversation.participates?(current_user)
  end
end