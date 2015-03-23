Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_ID"], ENV["GOOGLE_SECRET"]
  provider :spotify, ENV["SPOTIFY_ID"], ENV["SPOTIFY_KEY"]
  provider :facebook, ENV["FB_KEY"], ENV["FB_SECRET"]
end
