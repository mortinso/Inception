name = Inception

all: build

build: dirs
	docker compose -f srcs/docker-compose.yml up --build

dirs:
	@if [ ! -d "/home/mortinso/data/mariadb" ]; then mkdir -p /home/mortinso/data/mariadb; \
		echo "Created MariaDB Volume directory"; \
	fi
	@if [ ! -d "/home/mortinso/data/wordpress" ]; then mkdir -p /home/mortinso/data/wordpress; \
		echo "Created Wordpress Volume directory"; \
	fi

stop:
	docker compose -f srcs/docker-compose.yml stop

clean: # Stop and remove containers, networks, volumes, and images created by up.
	docker compose -f srcs/docker-compose.yml down --volumes --rmi all
# rm -rf /home/mortinso/data

fclean: clean
	@echo "System pruning..."
	docker system prune -af --volumes --force
# rm -rf /home/mortinso/data

re: fclean all

.PHONY: all build dirs stop clean fclean re