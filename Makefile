run:
	bundle exec ruby app.rb

install:
	bundle install
	npm i purgecss

build:
	purgecss -c purgecss.config.js -o public/css

deploy:
	make build
	git push heroku master

push:
	git push origin master