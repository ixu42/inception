DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml
DATA_DIR := /home/ixu/data
DB_DATA_DIR := $(DATA_DIR)/db_data
WP_DATA_DIR := $(DATA_DIR)/wp_data
DOCKER_COMPOSE := docker compose -f $(DOCKER_COMPOSE_FILE)

all: up

up:
	@if [ ! -d $(DB_DATA_DIR) ]; then mkdir -p $(DB_DATA_DIR); echo "Created $(DB_DATA_DIR)"; fi
	@if [ ! -d $(WP_DATA_DIR) ]; then mkdir -p $(WP_DATA_DIR); echo "Created $(WP_DATA_DIR)"; fi
	@$(DOCKER_COMPOSE) up --build -d

down:
	@$(DOCKER_COMPOSE) down

ps:
	@$(DOCKER_COMPOSE) ps

logs:
	@$(DOCKER_COMPOSE) logs

clean: down
	@if [ -d $(DATA_DIR) ]; then \
		echo "Removing $(DATA_DIR)..."; \
		sudo rm -fr $(DATA_DIR); \
	fi

fclean: clean
	@$(DOCKER_COMPOSE) down --volumes --rmi all
	@echo "Docker images, volumes, and networks have been removed."

re: down up

help:
	@echo "Makefile for managing Docker Compose setup"
	@echo "Targets:"
	@echo "  all         Starts the Docker Compose setup (same as 'make up')"
	@echo "  up          Starts the Docker Compose setup, creating data directories if needed"
	@echo "  down        Stops and removes Docker containers"
	@echo "  ps          Shows the status of Docker containers"
	@echo "  logs        Displays logs from all Docker containers"
	@echo "  clean       Stops and removes Docker containers; removes data directories"
	@echo "  fclean      Fully cleans Docker: Stops and removes containers, images, volumes, networks"
	@echo "  re          Rebuilds Docker images and restarts Docker containers"
	@echo "  help        Displays this help message"

.PHONY: all up down ps logs clean fclean re help
