Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000' # 本番環境では特定のオリジンに限定推奨
    resource '*',
      headers: :any,
      methods: %i[get post put patch delete options head],
      credentials: false
  end
end
