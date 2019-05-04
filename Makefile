run:
	bundle exec ruby app.rb

install:
	bundle install
	npm i purgecss

deploy:
	git push heroku master

push:
	git push origin master