all: build

build:
	@if [ ! -e "./srcs/.env" ] || [ ! -d "./secrets" ] || [ ! -e "./secrets/passwords.txt" ] || \
	[ ! -e "./secrets/emails.txt" ] || [ ! -e "./secrets/wp_admin.txt" ]; \
		then make --no-print-directory secrets;\
	else \
		mkdir -p /home/${USER}/data/mariadb; \
		mkdir -p /home/${USER}/data/wordpress; \
		docker compose -f srcs/docker-compose.yml up --build; \
	fi


secrets:
	@if [ ! -e "./srcs/.env" ]; then touch srcs/.env; \
		echo -n "DATABASE_NAME=\n\
DATABASE_USER=\n\
WP_LOGIN=\n\
STUDENT=mortins-" > srcs/.env;\
	echo "Please set the variables in 'srcs/.env'";\
	fi
	@if [ ! -d "./secrets" ]; then mkdir secrets; fi
	@if [ ! -e "./secrets/passwords.txt" ]; then touch secrets/passwords.txt; \
		echo -n "DATABASE_PASSWORD=\n\
DATABASE_ROOT_PASSWORD=\n\
WP_USER_PASSWORD=\n\
WP_ADMIN_PASSWORD=" > secrets/passwords.txt; \
		echo "Please set the variables in 'secrets/passwords.txt'"; \
	fi
	@if [ ! -e "./secrets/emails.txt" ]; then touch secrets/emails.txt; \
		echo -n "WP_USER_EMAIL=\n\
WP_ADMIN_EMAIL=" > secrets/emails.txt; \
		echo "Please set the variables in 'secrets/emails.txt'"; \
	fi
	@if [ ! -e "./secrets/wp_admin.txt" ]; then touch secrets/wp_admin.txt; \
		echo -n "WP_ADMIN_LOGIN=" > secrets/wp_admin.txt; \
		echo "Please set the variable in 'secrets/wp_admin.txt'"; \
	fi

stop: # Stop containers
	docker compose -f srcs/docker-compose.yml down

# Remove containers and networks created by up.
# Needs to be run with sudo
clean: stop
	@rm -rf /home/mortins-/data
	@docker system prune -af --volumes

# Delete volumes
# Needs to be run with sudo
fclean: clean
	@docker volume rm mariadb_data wordpress_data

re: fclean all

.PHONY: all build secrets stop clean fclean re