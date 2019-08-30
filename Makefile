#
#  Copyright (C) 2018-2019 Gaël PORTAY
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

PREFIX ?= /usr/local
DESTDIR ?=

letsencrypt-certonly letsencrypt-renew:
letsencrypt-%:
	# https://certbot.eff.org/docs/install.html#running-with-docker
	# https://certbot.eff.org/docs/using.html#standalone
	sudo docker run -it --rm --name certbot \
	    -v "/etc/letsencrypt:/etc/letsencrypt" \
	    -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
	    -p 80:80 -p 443:443 \
            certbot/certbot $* --standalone -d vps.portay.io

.PHONY: letsencrypt-certonly-dns-ovh
letsencrypt-certonly-dns-ovh: ovh.ini
	# https://certbot.eff.org/docs/using.html#dns-plugins
	# https://certbot-dns-ovh.readthedocs.io/en/stable/
	sudo docker run -it --rm --name certbot \
	    -v "/etc/letsencrypt:/etc/letsencrypt" \
	    -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
	    -v "$(CURDIR)/ovh.ini:/root/.secrets/certbot/ovh.ini" \
	    certbot/dns-ovh certonly \
	                    --dns-ovh \
	                    --dns-ovh-credentials /root/.secrets/certbot/ovh.ini \
	                    --dns-ovh-propagation-seconds 60 \
	                    -d vps.portay.io

.PHONY: ovh
.SILENT: ovh
ovh:
	echo '# Credentials'
	echo '#'
	echo '# Use of this plugin requires a configuration file containing OVH'
	echo '# API credentials for an account with the following access rules:'
	echo '#'
	echo '# GET /domain/zone/*'
	echo '# PUT /domain/zone/*'
	echo '# POST /domain/zone/*'
	echo '# DELETE /domain/zone/*'
	echo '#'
	echo '# These credentials can be obtained there:'
	echo '#'
	echo '# OVH Europe (endpoint: ovh-eu) https://eu.api.ovh.com/createToken/'
	echo '# OVH North America (endpoint: ovh-ca) https://ca.api.ovh.com/createToken/'
	echo '#'
	echo '# Example credentials file:'
	echo '#'
	echo '#	OVH API credentials used by Certbot'
	echo '#	dns_ovh_endpoint = ovh-eu'
	echo '#	dns_ovh_application_key = MDAwMDAwMDAwMDAw'
	echo '#	dns_ovh_application_secret = MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw'
	echo '#	dns_ovh_consumer_key = MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw'
	echo '#'

ovh.ini: EDITOR ?= vim
ovh.ini:
	$(MAKE) -s ovh >$@.tmp
	$(EDITOR) $@.tmp
	grep -q '^dns_ovh_endpoint = ovh-' $@.tmp
	grep -q '^dns_ovh_application_key = ' $@.tmp
	grep -q '^dns_ovh_application_secret = ' $@.tmp
	grep -q '^dns_ovh_consumer_key = ' $@.tmp
	mv $@.tmp $@

.PHONY: install uninstall
install uninstall:
	for subdir in nginx gitea; \
	do \
		$(MAKE) -C $$subdir $@; \
	done
