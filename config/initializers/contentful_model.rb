ContentfulModel.configure do |config|
  config.access_token = Rails.application.credentials.contentful[:access_token]
  config.space = Rails.application.credentials.contentful[:space_id]
  config.environment = 'master'
  config.default_locale = 'en-US'
end
