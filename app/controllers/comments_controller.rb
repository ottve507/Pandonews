class CommentsController < ApplicationController
  def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new( :parent_id => @parent_id, 
                            :commentable_id => @commentable.id,
                            :commentable_type => @commentable.class.to_s)
  end
  
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      if @commentable = Suggestion.find(1)
        redirect_to :back
      else
        redirect_to @commentable
      end
    else
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @feed = Feed.find(@comment.commentable_id)
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @feed }
      format.json { head :no_content }
    end
  end
  
  def votecomment
    value = params[:type] == "up" ? 1 : -1
    @comment = Comment.find(params[:comment_id])
    if value == 1
      current_user.up_vote(@comment)
    else
      current_user.down_vote(@comment)
    end
    redirect_to :back
  end 
 
  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
