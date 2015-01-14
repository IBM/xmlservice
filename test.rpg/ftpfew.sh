# bash ftpfew.sh lp0264d adc
ftp -i -n -v $1 << ftp_end
user $2

quote namefmt 1

ascii

cd /qsys.lib/xmlservice.lib/QCLSRC.FILE
put crttest6.clp crttest6.mbr

cd /qsys.lib/xmlservice.lib/QRPGLESRC.FILE
put zzjava.rpgle zzjava.mbr
put zzjava2.rpgle zzjava2.mbr

quit

ftp_end

