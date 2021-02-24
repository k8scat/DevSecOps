.PHONY: start stop

COMPOSE_FILE=docker-compose.yaml

start: stop
	docker-compose -f $(COMPOSE_FILE) up -d

stop:
	docker-compose down
