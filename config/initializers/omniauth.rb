Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'TOKEN', 'TOKEN'
end