Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'xxxx', 'xxx', :image_size => 'large'
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  provider :facebook, 'xxxx', 'xxx', :image_size => 'large'
  
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
  
end
