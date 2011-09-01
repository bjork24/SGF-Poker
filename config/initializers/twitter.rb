require 'twitter'

Twitter.configure do |config|
  config.consumer_key = 'KEY'
  config.consumer_secret = 'SECRET'
  config.oauth_token = 'TOKEN'
  config.oauth_token_secret = 'SECRET'
end