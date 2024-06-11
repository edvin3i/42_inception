DOCKER_COMPOSE	=	docker-compose
DCOMPOSE_CONFG	=	docker-compose.yml
DATA_DIR		=	/home/$(USER)/data
RM				=	rm -rf


create_dirs:
	@echo "\e[36mCreating the volumes (dirs) at $(DATA_DIR)\e[0m"
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress

build: create_dirs
	$(DOCKER_COMPOSE) -f $(DCOMPOSE_CONFG) build

up: create_dirs
	$(DOCKER_COMPOSE) -f $(DCOMPOSE_CONFG) up -d

down:
	$(DOCKER_COMPOSE) -f $(DCOMPOSE_CONFG) down

start:
	$(DOCKER_COMPOSE) -f $(DCOMPOSE_CONFG) start

stop:
	$(DOCKER_COMPOSE) -f $(DCOMPOSE_CONFG) stop

list:
	docker ps

clean:
		$(DOCKER_COMPOSE) -f $(DCOMPOSE_CONFG) down --rmi all --volumes --remove-orphans
		docker system prune -f
		docker volume prune -f
		$(RM) $(DATA_DIR)

.PHONY: create_dirs build up down start stop list clean