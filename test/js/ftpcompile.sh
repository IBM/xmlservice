# bash ftpcompile.sh lp0364d adc
MYPWD=$(<$HOME/.ftprc)
ftp -i -n -v $1 << ftp_end
user $2 $MYPWD

quote namefmt 1

bin
cd /www/apachedft/htdocs/
mput *

quit

ftp_end

