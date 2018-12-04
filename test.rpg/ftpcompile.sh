# bash ftpcompile.sh lp0364d adc
MYPWD=$(<$HOME/.ftprc)
ftp -i -n -v $1 << ftp_end
user $2 $MYPWD

quote namefmt 1

ascii
cd /qsys.lib/xmlservice.lib/QRPGLESRC.FILE
put zznone.rpgle zznone.mbr
put zzcall.rpgle zzcall.mbr
put zzmore.rpgle zzmore.mbr
put zzsimp.rpgle zzsimp.mbr
put zzsrv.rpgle zzsrv.mbr
put zzerich.rpgle zzerich.mbr
put zzvlad.rpgle zzvlad.mbr
put zzvlad2.rpgle zzvlad2.mbr
put zzvlad3.rpgle zzvlad3.mbr
put zzdeep.rpgle zzdeep.mbr
put zzsrv6.rpgle zzsrv6.mbr
put zzcust.rpgle zzcust.mbr
put zzbigboy.rpgle zzbigboy.mbr
put zzjava.rpgle zzjava.mbr
put zzjava2.rpgle zzjava2.mbr
put zzchina.rpgle zzchina.mbr
put zzchinao.rpgle zzchinao.mbr
put zzchinap.rpgle zzchinap.mbr

cd /qsys.lib/xmlservice.lib/QCLSRC.FILE
put crttest.clp crttest.mbr
put zzshlomo.clp zzshlomo.mbr
put crttest6.clp crttest6.mbr

quit

ftp_end

