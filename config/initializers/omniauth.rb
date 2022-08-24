# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET, scope: 'user:email'
end
