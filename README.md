# README #

XMLSERVICE is a single library of RPG source providing an XML-based protocol to access IBM i PGM, CMD, SRVPGM, DB2, PASE utilities and interactive commands. Many production IBM i sites successfully use XMLSERVICE, PHP Toolkit, Ruby Toolkit, node.js toolkit, python, .net, Java, RPG and many others.

### What is this repository for? ###

* RPG code repository (1.9.2-SG testing)
* Original home Yips: http://youngiprofessionals.com/wiki/index.php/XMLSERVICE/XMLSERVICE
* New home bitbucket: https://bitbucket.org/inext/xmlservice-rpg


### How do I get set up? ###

Download the zip file and follow IBM i steps:

```
First, add XMLSERVICE to library list:
 > ADDLIBLE XMLSERVICE

XMLSERVICE: test library XMLSERVICE, good for trying new versions
 > CRTCLPGM PGM(XMLSERVICE/CRTXML) SRCFILE(XMLSERVICE/QCLSRC)
 > call crtxml -- XMLSERVICE library only
```


### XMLSERVICE default connection configurations (included) ###

### REST interface (xmlcgi.rpgle)
```
ScriptAlias /cgi-bin/ /QSYS.LIB/XMLSERVICE.LIB/
<Directory /QSYS.LIB/XMLSERVICE.LIB/>
  AllowOverride None
  order allow,deny
  allow from all
  SetHandler cgi-script
  Options +ExecCGI
</Directory>
```

### DB2 stored procedure with I/O param (crtsql.cmd)
```
XMLSERVICE/iPLUGxx(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(xx), OUT C0 CLOB(xx))
```

### DB2 stored procedure with fetch result set (crtsql.cmd)
```
XMLSERVICE/iPLUGRxx(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(xx))
```

### DB2 stored procedure multiple input (CNT=0 input complete) with fetch result set (crtsql.cmd)
```
XMLSERVICE/iPLUGRC32K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI VARCHAR(32700), IN CNT INTEGER)
```

### Contribution guidelines ###

* git normal

### Who do I talk to? ###

* adc@us.ibm.com
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### Git (manually) ###

```
$ git init
Reinitialized existing Git repository ...
$ git remote add origin https://rangercairns@bitbucket.org/inext/xmlservice-rpg.git
$ echo "Tony Cairns" >> contributors.txt
$ git add .
$ git commit -m 'Initial commit with contributors'
[master (root-commit) 602b7c0] Initial commit with contributors
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 contributors.txt
$ git push -u origin master
Counting objects: 3, done.
Writing objects: 100% (3/3), 239 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://rangercairns@bitbucket.org/inext/xmlservice-rpg.git
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
$ 
```

