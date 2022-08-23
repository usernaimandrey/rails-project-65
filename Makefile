setup:
	bin/setup
	bin/rails db:seed

start:
	bin/rails s -p 3000 -b "0.0.0.0"

console:
	bin/rails console

deploy:
	git push heroku main

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/
	
lint-fix:
	bundle exec rubocop -A

test:
	NODE_ENV=test bin/rails test

#аргумент commit=[commit_name,skip] skip - не обязателный
push:
	bin/rails git_push:commit$(commit) 

.PHONY: test
