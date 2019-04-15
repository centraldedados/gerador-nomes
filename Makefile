run:
	bundle exec ruby app.rb
	# heroku local web # needs Profile setup

install:
	bundle install

deploy:
	git push heroku master

push:
	git push origin master