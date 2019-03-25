#
#  Copyright (C) 2018 Gaël PORTAY
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

.PHONY: install uninstall
install uninstall:
	for subdir in nginx gitea; \
	do \
		$(MAKE) -C $$subdir $@; \
	done
