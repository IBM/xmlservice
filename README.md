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

### Debug
In the event you need to do a more raw/direct test of XMLSERVICE (instead of going through an iToolkit) you can invoke it directly from the ACS "Run SQL Scripts" interface.  Below is an example of calling the `QWCRSVAL` *(Retrieve System Values)* API.  

**NOTE:** You must escape the single quotes by doubling them up.

```
CALL XMLSERVICE.iPLUG512K(
'*NA', 
'*here', 
'<?xml version=''1.0''?><myscript><pgm name=''QWCRSVAL'' lib=''QSYS'' error=''fast''><parm io=''out''><ds len=''rec1''><data type=''10i0''>0</data><data type=''10i0''>0</data><data type=''10A''></data><data type=''1A''></data><data type=''1A''></data><data type=''10i0''>0</data><data type=''10i0''>0</data></ds></parm><parm><data type=''10i0'' setlen=''rec1''>0</data></parm><parm><data type=''10i0''>1</data></parm><parm><data type=''10A''>QCCSID</data></parm><parm io=''both''><ds len=''rec2''><data type=''10i0''>0</data><data type=''10i0'' setlen=''rec2''>0</data><data type=''7A''></data><data type=''1A''></data></ds></parm></pgm></myscript>', 
?)
```

### iToolkits
XMLSERVICE is commonly via a language-specific toolkit.  The following are the known iToolkits.

- [PHP iToolkit](https://github.com/zendtech/IbmiToolkit)
- [Ruby iToolkit](https://bitbucket.org/litmis/ruby-itoolkit)
- [Node.js iToolkit](https://bitbucket.org/litmis/nodejs-itoolkit)
- [Python iToolkit](https://bitbucket.org/litmis/python-itoolkit)
- [Swift iToolkit](https://bitbucket.org/litmis/swift-itoolkit)
- [.NET](http://xmlservicei.codeplex.com/)


### Contribution guidelines ###

* not available (future)

### Who do I talk to? ###

* adc@us.ibm.com
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)