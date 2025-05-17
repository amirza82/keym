# keym

include config.mk

SRC = keym.c
OBJ = ${SRC:.c=.o}

all: options keym

options:
	@echo keym build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"
	@echo "LD       = ${LD}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

keym: ${OBJ}
	@echo LD $@
	@${LD} -o $@ ${OBJ} ${LDFLAGS}
	@strip $@

clean:
	@echo cleaning
	@rm -f keym ${OBJ} keym-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p keym-${VERSION}
	@cp -R LICENSE Makefile README config.mk ${SRC} keym-${VERSION}
	@tar -cf keym-${VERSION}.tar keym-${VERSION}
	@gzip keym-${VERSION}.tar
	@rm -rf keym-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f keym ${DESTDIR}${PREFIX}/bin
	@echo installing man page to ${DESTDIR}${PREFIX}/share/man/man1
	@cp -f keym.1 ${DESTDIR}${PREFIX}/share/man/man1
	@chmod 755 ${DESTDIR}${PREFIX}/bin/keym

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/keym
	@echo removing manual from ${DESTDIR}${PREFIX}/share/man
	@rm -f ${DESTDIR}${PREFIX}/share/man/man1/keym.1

.PHONY: all options clean dist install uninstall
