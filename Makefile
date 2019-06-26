.PHONY: all install uninstall

LIBDIR ?= /usr/lib

all:
	

install:
	install --directory $(DESTDIR)/$(LIBDIR)/systemd/system $(DESTDIR)/etc/default $(DESTDIR)/usr/bin $(DESTDIR)/usr/sbin
	install --owner=root --group=root --mode=644 services/netns@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 services/netns-bridge@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 services/netns-raw@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 services/netns-veth@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 configs/netns $(DESTDIR)/etc/default/
	install --owner=root --group=root --mode=755 scripts/chnetns $(DESTDIR)/usr/bin/
	install --owner=root --group=root --mode=755 scripts/netnsinit $(DESTDIR)/usr/sbin/
	systemctl daemon-reload || true

uninstall:
	systemctl disable --now "netns-veth@" || true
	systemctl disable --now "netns-bridge@" || true
	systemctl disable --now "netns-raw@" || true
	systemctl disable --now "netns@" || true

	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns@.service
	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns-bridge@.service
	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns-raw@.service
	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns-veth@.service
	rm -f $(DESTDIR)/usr/bin/chnetns
	rm -f $(DESTDIR)/usr/sbin/netnsinit
