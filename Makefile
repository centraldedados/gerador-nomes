run:
	bundle exec ruby app.rb

install:
	bundle install
	npm i purgecss
	heroku git

build:
	purgecss -c purgecss.config.js -o public/css

push:
	git push origin master

herokufy:
	heroku git:remote -a gerador-nomes

deploy:
	make build
	git push heroku master

