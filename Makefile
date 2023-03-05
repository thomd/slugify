DESTDIR ?= $(HOME)
BINDIR = ${DESTDIR}/bin

install:
	install -d ${BINDIR}
	install -m 755 bin/slugify ${BINDIR}

uninstall:
	rm -f ${BINDIR}/slugify

test:
	@bats test/slugify.bats

.PHONY: install uninstall test


