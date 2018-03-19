# bash ftpfew.sh lp0364d adc
ftp -i -n -v $1 << ftp_end
user $2

quote namefmt 1

ascii
cd /qsys.lib/xmlservice.lib/QRPGLESRC.FILE
put plugconf_h.rpgle plugconf_h.mbr
put plugile.rpgle plugile.mbr

quit

ftp_end

