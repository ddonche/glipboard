class CommentsController < ApplicationController
  before_action :load_commentable
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
    #@comment.user_id = current_user.id if current_user
  end
  
  def create
    @comment = @commentable.comments.new(allowed_params) 
    @comment.user_id=current_user.id if current_user
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(allowed_params)
        format.html { redirect_to @commentable, notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @commentable, notice: 'Comment was eradicated.' }
    end
  end
  
  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    
    #update user reputation in the database
    User.increment_counter(:reputation, @comment.user_id)
    redirect_to @commentable
  end
  
  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    
    #update user reputation in the database
    User.decrement_counter(:reputation, @comment.user_id)
    redirect_to @commentable
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.friendly.find(id)
  end
  
  def allowed_params
    params.require(:comment).permit(:content, :user_id)
  end
end