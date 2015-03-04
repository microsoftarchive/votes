default:
	rake

install:
	rbenv install -s
	gem install bundler --no-rdoc --no-ri
	bundle install
	rbenv rehash
	bundle exec rake db:reset

start:
	bundle exec foreman start
