CWD := $(shell pwd)
HAS_REMOTE := $(shell git remote -v | grep -q reveal; echo $$?)

all:	run

container:
	docker build --rm -t stpierre/career-presentation $(CWD)

run:	container
	docker run -d -p 8000:8000 --name career-presentation stpierre/career-presentation

stop:
	docker stop career-presentation
	docker rm career-presentation

restart: stop run

rebuild: container restart
