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

.PHONY: all
all:

.PHONY: install
install:
	install -D support/weechat $(DESTDIR)$(PREFIX)/bin/weechat

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/weechat

.PHONY: install-user
install-user:
	$(MAKE) install PREFIX=$$HOME/.local

.PHONY: uninstall-user
uninstall-user:
	$(MAKE) uninstall PREFIX=$$HOME/.local

