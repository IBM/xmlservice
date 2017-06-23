### /QOpenSys/usr/bin/make xmlservice
### /QOpenSys/usr/bin/make yips
### /QOpenSys/usr/bin/make zs5
### /QOpenSys/usr/bin/make zs6
### /QOpenSys/usr/bin/make zs7
### /QOpenSys/usr/bin/make ibm
### /QOpenSys/usr/bin/make ruby
###
### Assumes borgi command and utilities
### https://bitbucket.org/litmis/borgi
###

### ILE compile scripts
CCRPG       = crtrpgmod
CCRPGSQL	= crtsqlrpgi
CCPGM       = crtpgm
CCSRVPGM    = crtsrvpgm
CCSQL		= db2script

### *PGM - $(INILIB)/xmlmain.pgm
### xmlmain.rpgle xmlthis.rpgle xmlthat.rpgle ...
XMLLIB		= NULL
XMLCONF		= NULL
XMLSQLTPL	= crtsql.cmd
XMLSQLRPL	= XMLSERVICE $(XMLLIB)
XMLMAIN		= xmlmain.pgm
XMLSERVICE	= xmlservice.pgm
XMLSTOREDP	= xmlstoredp.srvpgm
XMLCGI		= xmlcgi.pgm

XMLCOMMOBJS = $(XMLCONF) plugbug.mod plugipc.mod plugrun.mod plugperf.mod \
				plugcach.mod plugerr.mod plugsql.mod plugdb2.mod \
				plugpase.mod pluglic.mod plugsig.mod plugconv.mod plugxml.mod \
				plugile.mod
XMLMAINOBJS = xmlmain.mod $(XMLCOMMOBJS)
XMLSERVOBJS = xmlservice.mod $(XMLCOMMOBJS)
XMLCGIOBJS	= xmlcgi.mod $(XMLCOMMOBJS)
XMLSTOROBJS = xmlstoredp.modsql $(XMLCOMMOBJS)

### tells make all things to do (order)
# do this if given an invalid target
.DEFAULT:
	@$(MAKE) help
help:
	@echo "------------------------------------------------------------"
	@echo "do '$(MAKE) xxx' where xxx=xmlservice,yips,zs5,zs6,zs7,ibm,ruby"
	@echo "------------------------------------------------------------"
xmlservice:
	@$(MAKE) XMLLIB="XMLSERVICE" XMLCONF="plugconf1.mod" go
yips:
	@$(MAKE) XMLLIB="XMLSERVICE" XMLCONF="plugconf3.mod" go
zs5:
	@$(MAKE) XMLLIB="ZENDSVR" XMLCONF="plugconf2.mod" go
zs6:
	@$(MAKE) XMLLIB="ZENDSVR6" XMLCONF="plugconf6.mod" go
zs7:
	@$(MAKE) XMLLIB="ZENDPHP7" XMLCONF="plugconf7.mod" go
ibm:
	@$(MAKE) XMLLIB="QXMLSERV" XMLCONF="plugconfq.mod" go
ruby:
	@$(MAKE) XMLLIB="POWER_RUBY" XMLCONF="plugconfr.mod" go

go: $(XMLMAIN) $(XMLSERVICE) $(XMLSTOREDP) $(XMLCGI) crtsqlproc

.SUFFIXES: .mod .rpgle .modsql .rpglesql
### CRTRPGMOD
.rpgle.mod:
	$(CCRPG) --root $(CHROOT) --lib $(XMLLIB) --src $<
### CRTSQLRPGI
.rpglesql.modsql:
	$(CCRPGSQL) --root $(CHROOT) --lib $(XMLLIB) --src $<

### -- CRTPGM
$(XMLMAIN): $(XMLMAINOBJS)
	$(CCPGM) --root $(CHROOT) --pgm $(XMLMAIN) --lib $(XMLLIB) --mod $(XMLMAINOBJS)
$(XMLSERVICE): $(XMLSERVOBJS)
	$(CCPGM) --root $(CHROOT) --pgm $(XMLSERVICE) --lib $(XMLLIB) --mod $(XMLSERVOBJS)
$(XMLCGI): $(XMLCGIOBJS)
	$(CCPGM) --root $(CHROOT) --pgm $(XMLCGI) --lib $(XMLLIB) --mod $(XMLCGIOBJS) --option "BNDSRVPGM(QHTTPSVR/QZSRCORE)"
### -- CRTSRVPGM
$(XMLSTOREDP): $(XMLSTOROBJS)
	$(CCSRVPGM) --root $(CHROOT) --pgm $(XMLSTOREDP) --lib $(XMLLIB) --mod $(XMLSTOROBJS) --option "EXPORT(*ALL) ACTGRP(*CALLER)"
### -- create stored procedures (iPLUG512K, etc.)
crtsqlproc:
	$(CCSQL) -f $(XMLSQLTPL) -r $(XMLSQLRPL)
### -- housekeeping(optional)
clean:
	rm -f $(XMLMAIN)
	rm -f $(XMLSERVICE)
	rm -f $(XMLSTOREDP)
	rm -f *.mod


