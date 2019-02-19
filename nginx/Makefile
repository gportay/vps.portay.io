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
systemd_unitdir ?= /lib/systemd/system

.PHONY: all
all:

.PHONY: install
install:
	install -D -m0644 nginx.service $(DESTDIR)$(PREFIX)$(systemd_unitdir)/nginx.service
	install -D -m0644 nginx-crl.service $(DESTDIR)$(PREFIX)$(systemd_unitdir)/nginx-crl.service
	install -D -m0644 nginx-crl.timer $(DESTDIR)$(PREFIX)$(systemd_unitdir)/nginx-crl.timer
	install -D -m0644 docker-compose.yml $(DESTDIR)/usr/local/lib/docker-compose/nginx.yml
	install -D -m0644 gitea.portay.io $(DESTDIR)/data/nginx/gitea.portay.io
	install -d $(DESTDIR)/data/nginx/certs

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)$(systemd_unitdir)/nginx.service
	rm -f $(DESTDIR)/usr/local/lib/nginx.yml

