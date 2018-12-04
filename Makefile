LIBRARY=XMLSERVICE
DBGVIEW=*ALL

COMMON=\
	plugconf.module \
	plugbug.module \
	plugipc.module \
	plugrun.module \
	plugperf.module \
	plugcach.module \
	plugerr.module \
	plugsql.module \
	plugdb2.module \
	plugpase.module \
	pluglic.module \
	plugsig.module \
	plugconv.module \
	plugxml.module \
	plugile.module

all: xmlmain.pgm xmlservice.pgm xmlcgi.pgm xmlver.pgm xmlstoredp.srvpgm xmlstoredp.sqlinst

xmlmain.pgm: xmlmain.module $(COMMON)
	system -q "CRTPGM PGM($(LIBRARY)/$(@:%.pgm=%)) MODULE($(^:%.module=$(LIBRARY)/%))" && touch $@

xmlservice.pgm: xmlservice.module $(COMMON)
	system -q "CRTPGM PGM($(LIBRARY)/$(@:%.pgm=%)) MODULE($(^:%.module=$(LIBRARY)/%))" && touch $@

xmlver.pgm: xmlver.module
	system -q "CRTPGM PGM($(LIBRARY)/$(@:%.pgm=%)) MODULE($(^:%.module=$(LIBRARY)/%))" && touch $@

xmlcgi.pgm: xmlcgi.module $(COMMON)
	system -q "CRTPGM PGM($(LIBRARY)/$(@:%.pgm=%)) MODULE($(^:%.module=$(LIBRARY)/%)) BNDSRVPGM(QHTTPSVR/QZSRCORE)" && touch $@

xmlstoredp.srvpgm: xmlstoredp.module $(COMMON)
	system -q "CRTSRVPGM SRVPGM($(LIBRARY)/$(@:%.srvpgm=%)) MODULE($(^:%.module=$(LIBRARY)/%)) EXPORT(*ALL) ACTGRP(*CALLER)" && touch $@

%.sqlinst: src/%.sql
	system -q "RUNSQLSTM SRCSTMF('$<')" && touch $@

%.module: src/%.rpgle
	system -q "CRTRPGMOD MODULE($(LIBRARY)/$*) SRCSTMF('$<') DBGVIEW($(DBGVIEW)) REPLACE(*YES)" && touch $@
	
%.module: src/%.rpglesql
	system -q "CRTSQLRPGI OBJ($(LIBRARY)/$*) SRCSTMF('$<') OBJTYPE(*MODULE) REPLACE(*YES) COMPILEOPT('INCDIR(''src/'')')" && touch $@
