# bash ftpcompile.sh lp0364d adc
MYPWD=$(<$HOME/.ftprc)
ftp -i -n -v $1 << ftp_end
user $2 $MYPWD

quote namefmt 1
bin
ascii
quote rcmd CRTLIB LIB(XMLSERVICE) TEXT('Open Source i')
quote rcmd CRTLIB LIB(QXMLSERV) TEXT('Open Source i')
quote rcmd CRTPF FILE(XMLSERVICE/QCLSRC) RCDLEN(92) FILETYPE(*SRC) MBR(*NONE) MAXMBRS(*NOMAX) TEXT('CL Open Source')
quote rcmd CRTPF FILE(XMLSERVICE/QSQLSRC) RCDLEN(92) FILETYPE(*SRC) MBR(*NONE) MAXMBRS(*NOMAX) TEXT('SQL Open Source')
quote rcmd CRTPF FILE(XMLSERVICE/QRPGLESRC) RCDLEN(92) FILETYPE(*SRC) MBR(*NONE) MAXMBRS(*NOMAX) TEXT('RPG Open Source')

cd /qsys.lib/xmlservice.lib/QRPGLESRC.FILE
put pluglic_h.rpgle pluglic_h.mbr
put plugconf_h.rpgle plugconf_h.mbr
put plugmri_h.rpgle plugmri_h.mbr
put plugpase_h.rpgle plugpase_h.mbr
put plugxml_h.rpgle plugxml_h.mbr
put plugile_h.rpgle plugile_h.mbr
put plugbug_h.rpgle plugbug_h.mbr
put plugipc_h.rpgle plugipc_h.mbr
put plugerr_h.rpgle plugerr_h.mbr
put plugrun_h.rpgle plugrun_h.mbr
put plugperf_h.rpgle plugperf_h.mbr
put plugcach_h.rpgle plugcach_h.mbr
put plugsql_h.rpgle plugsql_h.mbr
put plugdb2_h.rpgle plugdb2_h.mbr
put plugcli_h.rpgle plugcli_h.mbr
put plugsig_h.rpgle plugsig_h.mbr
put plugconv_h.rpgle plugconv_h.mbr
put pluglic.rpgle pluglic.mbr
put plugconf1.rpgle plugconf1.mbr
put plugconf2.rpgle plugconf2.mbr
put plugconf3.rpgle plugconf3.mbr
put plugconfq.rpgle plugconfq.mbr
put plugconf6.rpgle plugconf6.mbr
put plugconfr.rpgle plugconfr.mbr
put plugbug.rpgle plugbug.mbr
put plugpase.rpgle plugpase.mbr
put plugxml.rpgle plugxml.mbr
put plugipc.rpgle plugipc.mbr
put plugile.rpgle plugile.mbr
put plugerr.rpgle plugerr.mbr
put plugrun.rpgle plugrun.mbr
put plugperf.rpgle plugperf.mbr
put plugcach.rpgle plugcach.mbr
put plugsql.rpgle plugsql.mbr
put plugdb2.rpgle plugdb2.mbr
put plugsig.rpgle plugsig.mbr
put plugconv.rpgle plugconv.mbr
put xmlstoredp.rpgle xmlstoredp.mbr
put xmlservice.rpgle xmlservice.mbr
put xmlmain.rpgle xmlmain.mbr
put xmlver.rpgle xmlver.mbr
put xmlcgi.rpgle xmlcgi.mbr
put plugnone.rpgle plugnone.mbr

cd /qsys.lib/xmlservice.lib/QCLSRC.FILE
put crtxml.clp crtxml.mbr
put crtxmlV5.clp crtxmlV5.mbr
put crtxmlV6.clp crtxmlV6.mbr
put crtxml2.clp crtxml2.mbr
put crtxml2V5.clp crtxml2V5.mbr
put crtxml2V6.clp crtxml2V6.mbr
put crtxml3.clp crtxml3.mbr
put crtxmlq.clp crtxmlq.mbr
put crtxml6.clp crtxml6.mbr
put crtxml6V5.clp crtxml6V5.mbr
put crtxml6V6.clp crtxml6V6.mbr
put crtnone.clp crtnone.mbr
put crtxmlr.clp crtxmlr.mbr

cd /qsys.lib/xmlservice.lib/QSQLSRC.FILE
put crtsql.cmd crtsql.mbr
put crtsql2.cmd crtsql2.mbr
put crtsqlq.cmd crtsqlq.mbr
put crtsql6.cmd crtsql6.mbr
put crtsqlr.cmd crtsqlr.mbr
put dltsql.cmd dltsql.mbr
put dltsql2.cmd dltsql2.mbr
put dltsqlq.cmd dltsqlq.mbr
put dltsql6.cmd dltsql6.mbr
put dltsqlr.cmd dltsqlr.mbr

quit

ftp_end

