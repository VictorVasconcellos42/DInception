NAME = inception

DOCKER	= @docker-compose -f ./srcs/docker-compose.yml

ENV_PATH = --env-file srcs/.env

all: up

up: 
	@printf "Start New ${NAME} Config\n"
	@bash srcs/requirements/wordpress/tools/dirCreate.sh
	${DOCKER} ${ENV_PATH} up -d

down:
	@printf "Turn off ${NAME} Config\n"
	${DOCKER} ${ENV_PATH} down

build:
	@printf "Building ${NAME} Config\n"
	@bash srcs/requirements/wordpress/tools/dirCreate.sh
	${DOCKER} ${ENV_PATH} up -d --build

re: build

clean: down
	@printf "Cleaning ${NAME} Config\n"
	@docker system prune -a
	@sudo rm -rf ~/setting/wordpress/*
	@sudo rm -rf ~/setting/mariadb/*

fclean:
	@printf "Delete every docker configurations\n"
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@docker volume rm srcs_mariadb_setting
	@docker volume rm srcs_wordpress_setting
	@sudo rm -rf ~/setting

.PHONY: all build down re clean fclean

	
	
