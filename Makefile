run:
	bundle exec ruby app.rb -p 4567

install:
	bundle install
	make add_platform

push:
	git push origin master

add_platform:
	bundle lock --add-platform x86_64-linux

# Deployment
run_production:
	bundle exec ruby app.rb -p 8080

fly_deploy:
	flyctl deploy --remote-only --strategy bluegreen
	
deploy:
	make fly_deploy

ssh:
	flyctl ssh console

ping:
	flyctl curl https://gerador-nomes.fly.dev

