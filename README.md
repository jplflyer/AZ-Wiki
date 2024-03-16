# Azur Lane Public Wiki
This project will stand up a MediaWiki to serve as a publicly-edited Wiki for Azur Lane players. Content
will be directed to beginning and intermediate players. Advanced players already have the official Wiki,
but I find it to be highly cryptic when explaining anything, and they don't let you sign up to be an editor.

# Steps
* Install certbot. I don't have all the directions, but add these:
    * sudo add-apt-repository ppa:certbot/certbot
    * sudo apt install python3-certbot-nginx

* Install docker from the lengthy explanation here: https://docs.docker.com/engine/install/ubuntu/.

    You have to do the post-install stuff or it won't work very well for you. Specifically:
    * `sudo service docker start`
    * `sudo groupadd docker`
    * `sudo usermod -aG docker $USER`
    * log out and back in
    * `docker ps`

* Register your domain and configure DNS
* Download / move this repository somewhere useful.
* Ensure make is installed. `sudo apt-get install build-essential`
* `make up` to start our containers
* `make update` to run the update.php script. Do this once.
* Follow all the directions under Nginx and DNS

After that, you can change the logos file and it should be live. Change LocalSettings.php and those
changes should be immediately live.

# Nginx and DNS
I use certbot (letsencrypt) to handle SSL certs. The Makefile knows this. The script assumes
azur-lane.wiki, which of course, no one has access to. But if you decide to duplicate what I'm
doing, you should:

1. Register a domain
2. Configure DNS to point to your server
3. Fix files based on your domain
    * Rename `azur-lane.wiki` and `azur-lane.wiki.startup` as appropriate.
    * Edit those two files plus `Makefile` and change `azur-lane.wiki` in all places to match
      your domain name. You can do a global search and replace.
4. `make nginx-init`. This will copy files to nginx and force a config file reload.
    * Test it by hitting your domain with a browser. You should get a simple `this is a test` page.
5. `make nginx-certbot`. This will:
    * Run certbot. Tell it to use the nginx plugin. You'll get a cert.
    * Copy azur-lane.wiki into place. This one now points to your server instead of flat files.
    * Reload nginx.

At that point, you should have a running wiki.