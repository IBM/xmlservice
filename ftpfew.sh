# bash ftpfew.sh lp0364d adc
ftp -i -n -v $1 << ftp_end
user $2

quote namefmt 1

ascii
cd /qsys.lib/xmlservice.lib/QRPGLESRC.FILE
put plugconf_h.rpgle plugconf_h.mbr
put plugpase.rpgle plugpase.mbr
put plugdb2.rpgle plugdb2.mbr
put plugipc.rpgle plugipc.mbr
put plugipc_h.rpgle plugipc_h.mbr
put plugsql_h.rpgle plugsql_h.mbr
put plugconv_h.rpgle plugconv_h.mbr
put plugconv.rpgle plugconv.mbr

quit

ftp_end

