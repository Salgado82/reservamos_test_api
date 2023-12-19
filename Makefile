get-gems:
	bundle install
	
generate-env-file:
	cp .env.example .env

start-server:
	rails server