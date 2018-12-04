# bash ftpfew.sh ut28p63 adc
ftp -i -n -v $1 << ftp_end
user $2

quote namefmt 1

ascii

cd /qsys.lib/xmlservice.lib/QRPGLESRC.FILE
put zzsrv.rpgle zzsrv.mbr

quit

ftp_end

