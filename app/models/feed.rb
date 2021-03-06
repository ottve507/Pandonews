class Feed < ActiveRecord::Base
  attr_accessible :content, :guid, :language, :latitude, :location, :longitude, :original_plate_id, :published_at, :thumbnail_url, :title, :type_of_feed, :url, :url_to_feed, :user_id

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

     # after_create { |feed| Feed.update_from_feed(feed.url) }

      def impression_count
       impressions.size
      end

      def unique_impression_count
      impressions.group(:ip_address).size
      end

      def self.input(last)
        self.where("created_at < ? ", last).order('created_at desc').limit(5)
      end

      def self.update_from_feed(feed_url, userid, originalplateid)
        feed = Feedzirra::Feed.fetch_and_parse(feed_url)
        add_entries(feed.entries, userid, feed.feed_url, originalplateid)
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
         # unless exists? :guid => entry.id
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
        # end
        end
      end
  end