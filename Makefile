run:
	bundle exec ruby app.rb -p 8080

install:
	bundle install

push:
	git push origin master

# Deployment
fly_deploy:
	flyctl deploy --remote-only --strategy bluegreen
	
deploy:
	make fly_deploy

ssh:
	flyctl ssh console

