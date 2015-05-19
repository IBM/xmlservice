# bash ftpfew.sh lp0264d adc
ftp -i -n -v $1 << ftp_end
user $2

quote namefmt 1

ascii

cd /qsys.lib/xmlservice.lib/QCLSRC.FILE
put crttest6.clp crttest6.mbr

cd /qsys.lib/xmlservice.lib/QRPGLESRC.FILE
put zzvlad2.rpgle zzvlad2.mbr
put zzsrv6.rpgle zzsrv6.mbr

quit

ftp_end

