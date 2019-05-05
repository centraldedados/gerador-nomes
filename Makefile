run:
	bundle exec ruby app.rb

install:
	bundle install
	npm i purgecss

build:
	purgecss -c purgecss.config.js -o public/css

push:
	git push origin master

deploy:
	make build
	git push heroku master
