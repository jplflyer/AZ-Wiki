# Azur Lane Public Wiki
This project will stand up a MediaWiki to serve as a publicly-edited Wiki for Azur Lane players. Content
will be directed to beginning and intermediate players. Advanced players already have the official Wiki,
but I find it to be highly cryptic when explaining anything, and they don't let you sign up to be an editor.

# Steps
* Download / move this repository somewhere useful.
* Ensure make is installed. `sudo apt-get install build-essential`
* `make nginx` to configure nginx. See the DNS section below.
* `make up` to start our containers
* `make update` to run the update.php script. Do this once.

After that, you can change the logos file and it should be live. Change LocalSettings.php and those
changes should be immediately live.

# DNS
The steps above will copy azur-lane.wiki into place for nginx to notice. That works if you own
the domain. It won't work otherwise, and you may need to make your own changes.
