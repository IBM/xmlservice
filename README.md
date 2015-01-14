# README #

XMLSERVICE is a single library of RPG source providing an XML-based protocol to access IBM i PGM, CMD, SRVPGM, DB2, PASE utilities and interactive commands. Many production IBM i sites successfully use XMLSERVICE, PHP Toolkit, Ruby Toolkit, node.js toolkit, python, .net, Java, RPG and many others.

### What is this repository for? ###

* Original home Yips: http://youngiprofessionals.com/wiki/index.php/XMLSERVICE/XMLSERVICE
* New home bitbucket: https://bitbucket.org/inext/xmlservice-rpg


### How do I get set up? ###

Download zip file, transfer SAVF and RSTLIB(XMLSERVICE), then compile:

```
 > ADDLIBLE XMLSERVICE
 > CRTCLPGM PGM(XMLSERVICE/CRTXML) SRCFILE(XMLSERVICE/QCLSRC)
 > call crtxml
```


### How do I configure? ###

You may choose either REST or DB2 XMLSERVICE interfaces.

### REST interface via Apache (xmlcgi.rpgle)
```
/www/apachedft/conf/httpd.conf:

ScriptAlias /cgi-bin/ /QSYS.LIB/XMLSERVICE.LIB/
<Directory /QSYS.LIB/XMLSERVICE.LIB/>
  AllowOverride None
  order allow,deny
  allow from all
  SetHandler cgi-script
  Options +ExecCGI
</Directory>
```

### DB2 stored procedure (crtsql.cmd)
```
DB2 stored procedure with I/O param
XMLSERVICE/iPLUGxx(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(xx), OUT C0 CLOB(xx))

DB2 stored procedure with fetch result set
XMLSERVICE/iPLUGRxx(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(xx))

DB2 stored procedure multiple input (CNT=0 input complete) with fetch result set
XMLSERVICE/iPLUGRC32K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI VARCHAR(32700), IN CNT INTEGER)

Where xx sizes: 4K, 32K, 65K, 512K, 1M, 5M, 10M, 15M
```


### Contribution guidelines ###

* not available (yet)

### Who do I talk to? ###

* adc@us.ibm.com
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### Git (manually) ###

```
$ mkdir xmlservice
$ cd xmlservice
$ git init
$ git remote add origin https://rangercairns@bitbucket.org/inext/xmlservice-rpg.git
$ echo "Tony Cairns" >> contributors.txt
$ git add .
$ git commit -m 'Initial commit with contributors'
$ git push -u origin master [--force]
```

