require 'active_support/concern'

module CommentsMod
   extend ActiveSupport::Concern
   require 'will_paginate'

    included do
      before_filter :comments, :only => [:show]
    end

    def comments
      @commentable = find_commentable
      @comments = @commentable.comments.arrange(:order => "created_at DESC").keys
      @comments = @comments.paginate(:page => params[:page], :per_page =>7)
      #@comments = @commentable.comments.paginate(:page => params[:page], :order => "created_at DESC", :per_page =>7)
      @comment = Comment.new
    end

    private

    def find_commentable
      return params[:controller].singularize.classify.constantize.find(params[:id])
    end

  end