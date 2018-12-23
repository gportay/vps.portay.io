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
	install -D -m0644 weechat@.service $(DESTDIR)$(PREFIX)$(unitdir)/weechat@.service
	install -D -m0644 docker-compose.yml $(DESTDIR)/usr/local/lib/docker-compose/weechat-$${SUDO_USER:-$$USER}.yml
	install -D -m0644 Dockerfile $(DESTDIR)/usr/local/lib/docker-compose/Dockerfile
	install -d $(DESTDIR)/data/weechat/
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -D support/weechat $(DESTDIR)$(PREFIX)/bin/weechat

docker-compose.yml: SHELL=/bin/bash
docker-compose.yml: docker-compose.yml.in
	sed -e "s,\$$USER,$$USER,g" \
	    -e "s,\$$UID,$$UID,g" \
	    -e "s,\$$GROUPS,$$GROUPS,g" \
	    $< >$@

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)$(unitdir)/weechat.service
	rm -f $(DESTDIR)/usr/local/lib/weechat.yml
	rm -f $(DESTDIR)$(PREFIX)/bin/weechat

.PHONY: install-user
install-user:
	$(MAKE) install PREFIX=$$HOME/.local unitdir=/.config/systemd/user

.PHONY: uninstall-user
uninstall-user:
	$(MAKE) uninstall PREFIX=$$HOME/.local unitdir=/.config/systemd/user

.PHONY: letsencrypt
letsencrypt: SHELL=/bin/bash
letsencrypt:
	touch weechat/ssl/relay.pem.tmp
	sudo cat /etc/letsencrypt/live/vps.portay.io/{privkey,fullchain}.pem >weechat/ssl/relay.pem.tmp
	mv weechat/ssl/relay.pem{.tmp,}

.PHONY: clean
clean:
	rm -f docker-compose.yml

