Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'w8xmzvFqVvJY76A6MZkGQg', 'sqVdREFxIMLFG4fC8OheNMrTnJ7dB4JJttQiTWvQ0', :image_size => 'large'
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  provider :facebook, '440941812619535', '50fa2c362c97d3857aaa4ddcb77d455f', :image_size => 'large'
  
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
  
end
