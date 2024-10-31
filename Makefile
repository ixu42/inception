DOCKER_COMPOSE_FILE := './srcs/docker-compose.yml'

all: up

up:
	docker compose -f $(DOCKER_COMPOSE_FILE) up --build

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down
	sudo rm -fr /home/ixu/data/db_data/*
	sudo rm -fr /home/ixu/data/wp_data/*

ps:
	docker compose -f $(DOCKER_COMPOSE_FILE) ps

logs:
	docker compose -f $(DOCKER_COMPOSE_FILE) logs

re:
	up down
