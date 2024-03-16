#

help:
	@echo These are helpful commands:
	@echo
	@echo "make nginx              Installs our nginx configuration."
	@echo "make up                 Launches Maria DB and MediaWiki"
	@echo "make update             Runs the update.php script. Do once."
	@echo "make down               Shuts down our containers."
	@echo "make attach             Run bash inside the MediaWiki container."
	@echo "make attach-mariadb     Run bash inside the MariaDB container."
	@echo "make clean              Do after a down to remove the lingering downed containers."

nginx:
	mkdir -p /Library/WebServer/Sites/azur-lane.wiki/htdocs
	mkdir -p /Library/WebServer/Sites/azur-lane.wiki/nlogs
	sudo cp azur-lane.wiki /etc/nginx/sites-available
	sudo ln -s /etc/nginx/sites-available /etc/nginx/sites-enabled
	sudo certbot certonly --nginx -d azur-lane.wiki -d www.azur-lane.wiki
	sudo nginx -s reload

up:
	mkdir -p db
	docker compose up -docker

down:
	docker compose down

clean:
	docker rm az-wiki-database-1 az-wiki-mediawiki-1

attach:
	docker exec -it az-wiki-mediawiki-1 bash

attach-mariadb:
	docker exec -it az-wiki-database-1 bash

update:
	docker exec az-wiki-mediawiki-1 'php maintenance/update.php'