run:
	bundle exec ruby app.rb -p 8080

install:
	bundle install
	make add_platform

push:
	git push origin master

add_platform:
	bundle lock --add-platform x86_64-linux

# Deployment
fly_deploy:
	flyctl deploy --remote-only --strategy bluegreen
	
deploy:
	make fly_deploy

ssh:
	flyctl ssh console

ping:
	flyctl curl https://gerador-nomes.fly.dev

