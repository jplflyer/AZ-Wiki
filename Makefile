#

help:
	@echo These are helpful commands:
	@echo
	@echo "make nginx              Installs our nginx configuration."
	@echo "make nginx-reload       Use once certbot is done. Replaces the azur-lane.wiki config file."
	@echo "make up                 Launches Maria DB and MediaWiki"
	@echo "make update             Runs the update.php script. Do once."
	@echo "make down               Shuts down our containers."
	@echo "make attach             Run bash inside the MediaWiki container."
	@echo "make attach-mariadb     Run bash inside the MariaDB container."
	@echo "make clean              Do after a down to remove the lingering downed containers."

nginx-init:
	mkdir -p /Library/WebServer/Sites/azur-lane.wiki/htdocs
	mkdir -p /Library/WebServer/Sites/azur-lane.wiki/nlogs
	sudo cp azur-lane.wiki.startup /etc/nginx/sites-available/azur-lane.wiki
	sudo ln -s /etc/nginx/sites-available/azur-lane.wiki /etc/nginx/sites-enabled
	sudo nginx -s reload

nginx-certbot:
	sudo certbot certonly --nginx -d azur-lane.wiki -d www.azur-lane.wiki
	sudo nginx -s reload

nginx-ready:
	sudo cp azur-lane.wiki /etc/nginx/sites-available/azur-lane.wiki
	sudo nginx -s reload

up:
	mkdir -p db
	docker compose up -d

down:
	docker compose down

clean:
	docker rm az-wiki-database-1 az-wiki-mediawiki-1

attach:
	docker exec -it az-wiki-mediawiki-1 bash

attach-mariadb:
	docker exec -it az-wiki-database-1 bash

update:
	docker exec -it az-wiki-mediawiki-1 php ./maintenance/update.php