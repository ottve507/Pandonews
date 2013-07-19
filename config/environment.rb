# Load the rails application
require File.expand_path('../application', __FILE__)
require 'will_paginate'
#config.gem "pauldix-feedzirra", :lib => "feedzirra", :source => "http://gems.github.com"


# Initialize the rails application
Auth::Application.initialize!
RAILS_ENV = 'production'
