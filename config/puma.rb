workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

env = ENV.fetch('RACK_ENV', 'development')

rackup      DefaultRackup
port        ENV.fetch('PORT', '3050')
environment env

if env == "production"
  on_worker_boot do
    # Worker specific setup for Rails 4.1+
    # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
    ActiveRecord::Base.establish_connection
  end

  preload_app!
end
