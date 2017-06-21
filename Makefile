### gmake TGT=YIPS
### gmake TGT=ZS5
### gmake TGT=ZS6
### gmake TGT=ZS7
### gmake TGT=IBM
### gmake TGT=RUBY
###
### Dependencies:
### Assumes minimum bash (perzl?)
###
### Assumes system400 command and utilities
### https://bitbucket.org/litmis/system400
###
### Assumes updated yips gmake (4.2)
### http://www.youngiprofessionals.com/wiki/index.php/PASE/OpenSourceBinaries
###

### ILE compile scripts
CCRPG       = crtrpgmod
CCRPGSQL	= crtsqlrpgi
CCPGM       = crtpgm
CCSRVPGM    = crtsrvpgm
CCSQL		= db2script

### *PGM - $(INILIB)/xmlmain.pgm
### xmlmain.rpgle xmlthis.rpgle xmlthat.rpgle ...
XMLLIB		= XMLSERVICE
XMLCONF		= plugconf1.mod
XMLSQLTPL	= crtsql.cmd
ifeq ($(TGT), YIPS)
XMLLIB		= XMLSERVICE
XMLCONF		= plugconf3.mod
endif
ifeq ($(TGT), ZS5)
XMLLIB		= ZENDSVR
XMLCONF		= plugconf2.mod
endif
ifeq ($(TGT), ZS6)
XMLLIB		= ZENDSVR6
XMLCONF		= plugconf6.mod
endif
ifeq ($(TGT), ZS7)
XMLLIB		= ZENDPHP7
XMLCONF		= plugconf7.mod
endif
ifeq ($(TGT), IBM)
XMLLIB		= QXMLSERV
XMLCONF		= plugconfq.mod
endif
ifeq ($(TGT), RUBY)
XMLLIB		= POWER_RUBY
XMLCONF		= plugconfr.mod
endif
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
all: $(XMLMAIN) $(XMLSERVICE) $(XMLSTOREDP) $(XMLCGI) crtsqlproc

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


