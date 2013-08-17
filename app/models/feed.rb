class Feed < ActiveRecord::Base
  attr_accessible :content, :guid, :language, :latitude, :location, :longitude, :original_plate_id, :published_at, :thumbnail_url, :title, :type_of_feed, :url, :url_to_feed, :user_id, :feedpic, :summary, :linkobject

  geocoded_by :location
  after_validation :geocode, :if => :location_changed? 
  
    has_many :impressions, :as=>:impressionable
     has_many :comments, :as => :commentable, :dependent => :destroy
     validates_length_of :tag_list, :maximum => 10
     make_voteable
     # validates :title, :presence => true
      acts_as_taggable
      has_many :platerelationships
      has_many :plates, :through => :platerelationships

      Feedzirra::Feed.add_common_feed_entry_element("media:content",
      :value => :url, :as => :thumbnail)
      Feedzirra::Feed.add_common_feed_entry_element("media:content",
      :value => :height, :as => :thumbnail_height)
      Feedzirra::Feed.add_common_feed_entry_element("media:content",
      :value => :width, :as => :thumbnail_width)
      Feedzirra::Feed.add_common_feed_entry_element("link", :as => :linkobject, :value => :src, :with => {:type => "image/jpeg"})
      Feedzirra::Feed.add_common_feed_entry_element('geo:lat', :as => :lat)
      Feedzirra::Feed.add_common_feed_entry_element('geo:long', :as => :lon)

      def impression_count
       impressions.size
      end
      
      def unique_impression_count
        impressions.count(:ip_address,:distinct =>true)
      end

      def self.input(last)
        self.where("created_at < ? ", last).order('created_at desc').limit(5)
      end

      def self.update_from_feed(feed_url, userid, originalplateid)
        feed = Feedzirra::Feed.fetch_and_parse(feed_url)
        add_entries(feed.entries, userid, feed_url, originalplateid)
      end
      
      def self.update_from_feed_new(feed_url, plates, feed_title, feedpic)
        feed = Feedzirra::Feed.fetch_and_parse(feed_url)
        add_entries_new(feed.entries, plates, feed_url, feed_title,feedpic)
      end

      def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
        feed = Feedzirra::Feed.fetch_and_parse(feed_url)
        add_entries(feed.entries)
        loop do
          sleep delay_interval
          feed = Feedzirra::Feed.update(feed)
          add_entries(feed.new_entries) if feed.updated?
        end
      end

      private

      def self.add_entries(entries, userid, feedurl, originalplateid)
        entries.reverse_each do |entry|
          unless exists? :guid => entry.id, :user_id => userid 
           @f = create!(
              :title => entry.title,
              :content => entry.summary,
              :thumbnail_url => entry.thumbnail,
              :published_at => entry.published,
              :url => entry.url,
              :url_to_feed => feedurl,
              :type_of_feed => "RSS",
              :guid => entry.id,
              :user_id => userid,
              :tag_list => entry.title.split(" ").first(10),
              :original_plate_id => originalplateid,
            )
           p = Platerelationship.create(:plate_id => originalplateid, :feed_id => @f.id)
        end
        end
      end
      
      def self.add_entries_new(entries, plates, feedurl, feed_title, feedpic)
        entries.reverse_each do |entry|
          unless exists? :guid => entry.id
           @f = create!(
              :title => entry.title,
              :content => entry.content,
              :thumbnail_url => entry.thumbnail,
              :published_at => entry.published,
              :url => entry.url,
              :url_to_feed => feedurl,
              :type_of_feed => feed_title,
              :feedpic => feedpic,
              :guid => entry.id,
              :user_id => 1,
              :longitude => entry.lon,
              :latitude => entry.lat,
              :tag_list => entry.title.split(" ").first(10),
              :summary => entry.summary,
              :linkobject => entry.linkobject,
            )            
          plates.each do |p|
           newPr = Platerelationship.create(:plate_id => p.id, :feed_id => @f.id)
          end
        end
        end
      end
      
  end