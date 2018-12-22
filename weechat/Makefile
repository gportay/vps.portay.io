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
unitdir ?= /lib/systemd/system

.PHONY: all
all: docker-compose.yml

.PHONY: install
install:
	install -d $$HOME/.config/docker-compose/
	install -D -m0644 Dockerfile $(DESTDIR)$$HOME/.config/docker-compose/Dockerfile
	install -D -m0644 docker-compose.yml $(DESTDIR)$$HOME/.config/docker-compose/weechat.yml
	install -d $$HOME/.config/systemd/user/
	install -D -m0644 weechat.service $(DESTDIR)$$HOME/.config/systemd/user/weechat.service
	install -d $(DESTDIR)$$HOME/bin/
	install -D support/weechat $(DESTDIR)$$HOME/bin/weechat

docker-compose.yml: SHELL=/bin/bash
docker-compose.yml: docker-compose.yml.in
	sed -e "s,\$$USER,$$USER,g" \
	    -e "s,\$$UID,$$UID,g" \
	    -e "s,\$$GROUPS,$$GROUPS,g" \
	    $< >$@

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$$HOME/bin/weechat
	rm -f $(DESTDIR)$$HOME/.config/systemd/user/weechat.service
	rm -f $(DESTDIR)$$HOME/.config/docker-compose/weechat.yml
	rm -f $(DESTDIR)$$HOME/.config/docker-compose/Dockerfile

.PHONY: letsencrypt
letsencrypt: SHELL=/bin/bash
letsencrypt:
	touch relay.pem.tmp
	sudo cat /etc/letsencrypt/live/vps.portay.io/{privkey,fullchain}.pem >relay.pem.tmp
	mv relay.pem{.tmp,}

.PHONY: clean
clean:
	rm -f docker-compose.yml relay.pem

