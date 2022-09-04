

# Enable cross origin for all routes
configure do
  enable :cross_origin
end

set :protection, :except => [:frame_options, :json_csrf]

# Set content type to JSON
# override this for homepage
before do
  # For deployment, but disabled while testing the use of canonical
  # if request.host == "gerador-nomes.fly.dev"
  #   redirect 'https://gerador-nomes.wolan.net', 301
  # end

  # API
  content_type 'application/json'
end

