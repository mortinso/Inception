all: build

build:
	@if [ ! -d "./secrets" ] || [ ! -e "./secrets/passwords.txt" ] || [ ! -e "./secrets/emails.txt" ]; \
		then echo "Please run \`make secrets\` before running \`make\` again"; \
	else \
		mkdir -p /home/${USER}/data/mariadb; \
		mkdir -p /home/${USER}/data/wordpress; \
		docker compose -f srcs/docker-compose.yml up --build; \
	fi


secrets:
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


clean: # Stop and remove containers and networks created by up.
	docker compose -f srcs/docker-compose.yml down

fclean: clean
	@rm -rf /home/${USER}/data
	docker system prune -af --volumes

re: fclean all

.PHONY: all build clean fclean re secrets