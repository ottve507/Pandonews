module SearchesHelper
  
  def show_users_ids
    @usersearch.collect(&:id).join(',')    
  end
  
  def show_feeds_ids
    @search.collect(&:id).join(',')    
  end
  
end
