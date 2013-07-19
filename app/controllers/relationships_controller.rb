class RelationshipsController < ApplicationController
  
  def index
  @rela = Relationship.all
  end
  
  def show
    @posts = Post.find(:re)
  end
  
  def show
    @rela = Relationship.find(params[:id])
    @posts = Post.where(:rel_current_id => @rela.id)
    @your_posts = Post.where(:user_id => current_user.id)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @posts }
      end
  end
  
end
