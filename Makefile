DOCKER_COMPOSE	=	docker compose
DCOMPOSE_CONFG	=	srcs/docker-compose.yml
DATA_DIR		=	$(HOME)/data
RM				=	sudo rm -rf


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

clean: down
		docker system prune -a

fclean:
		$(DOCKER_COMPOSE) -f $(DCOMPOSE_CONFG) down --rmi all --volumes --remove-orphans
		docker system prune -f
		docker volume prune -f
		docker network prune -f
		$(RM) $(DATA_DIR)

.PHONY: create_dirs build up down start stop list clean fclean

# sudo echo "127.0.0.1        gbreana.42.fr" >> /etc/hosts
# sudo echo "127.0.0.1        db.gbreana.42.fr" >> /etc/hosts
# sudo echo "127.0.0.1        baikal.gbreana.42.fr" >> /etc/hosts
# sudo echo "127.0.0.1        chat.gbreana.42.fr" >> /etc/hosts