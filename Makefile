all: build

build:
	@mkdir -p /home/mortinso/data/mariadb
	@mkdir -p /home/mortinso/data/wordpress
	@docker compose -f srcs/docker-compose.yml up --build

clean: # Stop and remove containers and networks created by up.
	docker compose -f srcs/docker-compose.yml down

fclean: clean
	@rm -rf /home/mortinso/data
	docker system prune -af --volumes

re: fclean all

.PHONY: all build clean fclean re