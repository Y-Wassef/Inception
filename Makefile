COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_DIR = $(HOME)/data

all: up

up:
	@mkdir -p $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb
	@docker-compose -f $(COMPOSE_FILE) up -d

down:
	@docker-compose -f $(COMPOSE_FILE) down

re:
	@docker-compose -f $(COMPOSE_FILE) up --build -d

clean:
	@docker-compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@docker rm -f $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker network rm $$(docker network ls -q) 2>/dev/null || true
	@docker volume prune -f
	@docker system prune -f

.PHONY: all up re down clean
