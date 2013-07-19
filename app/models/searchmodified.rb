class Search < ActiveRecord::Base
  attr_accessible :keywords, :language, :location
  
  def feedresults
    @feedresults ||= find_feeds
  end
  
  def userresults
    @userresults ||= find_users
  end
  
  def self.input(last)
    self.where("created_at < ? ", last).order('created_at desc').limit(5)
  end
  
private
  def find_feeds
    feedresults = Feed.order(:title)
    #if keywords.present? && !language.present? && !location.present?
     # feedresults = feedresults.find(:all, :conditions => ['title LIKE :search OR content LIKE :search', {:search => "%#{keywords}%"}])
    if keywords.present? && !language.present? && location.present?
        feedresults = feedresults.find(:all, :conditions => ['(title LIKE :search OR content LIKE :search) AND location LIKE :loc', {:search => "%#{keywords}%", :loc => "%#{location}%"}])
    elsif keywords.present? && language.present? && !location.present?
        feedresults = feedresults.find(:all, :conditions => ['(title LIKE :search OR content LIKE :search) AND language LIKE :loc', {:search => "%#{keywords}%", :loc => "%#{language}%"}])
    elsif keywords.present? && language.present? && location.present?
        feedresults = feedresults.find(:all, :conditions => ['(title LIKE :search OR content LIKE :search) AND language LIKE :lan AND location LIKE :loc', {:search => "%#{keywords}%", :lan => "%#{language}%", :loc => "%#{location}%"}])
    elsif searchall.present?
        feedresults = feedresults.find(:all, :conditions => ['(title LIKE :search OR content LIKE :search) OR language LIKE :search OR location LIKE :search', {:search => "%#{searchall}%"}])
        
    end
  end 
  
  def find_users
    userresults = User.order(:name)
    if keywords.present?
      userresults = userresults.find(:all, :conditions => ['name LIKE :search', {:search => "%#{keywords}%"}])
    end
  end
  
end
