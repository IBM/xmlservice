      /if defined(PLUGXML_H)
      /eof
      /endif
      /define PLUGXML_H

      *****************************************************
      * Copyright (c) 2010, IBM Corporation
      * All rights reserved.
      *
      * Redistribution and use in source and binary forms,
      * with or without modification, are permitted provided
      * that the following conditions are met:
      * - Redistributions of source code must retain
      *   the above copyright notice, this list of conditions
      *   and the following disclaimer.
      * - Redistributions in binary form must reproduce the
      *   above copyright notice, this list of conditions
      *   and the following disclaimer in the documentation
      *   and/or other materials provided with the distribution.
      * - Neither the name of the IBM Corporation nor the names
      *   of its contributors may be used to endorse or promote
      *   products derived from this software without specific
      *   prior written permission.
      *
      * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
      * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
      * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
      * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
      * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
      * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
      * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
      * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
      * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
      * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
      * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
      * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
      * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
      * POSSIBILITY OF SUCH DAMAGE.
      *****************************************************
      *************************************************************************
      * 1) call i CMD
      * XMLSERVICE allows calls of *CMDS on IBM i. Typically, you cut/paste
      * from a 5250 QCMD line using prompt (F4). You may use choose the utility
      * to run your command with attribute 'exec'. However, *CMDS with
      * in/out parameters, like RTVJOBA., you must use 'exec'='rexx'.
      * ---
      * <cmd [exec='cmd|system|rexx'
      *       hex='on'
      *       before='cc1/cc2/cc3/cc4'
      *       after='cc4/cc3/cc2/cc1'
      *       error='on|off|fast'
      *       ]>values (see IBM i *CMD)</cmd>
      * ---
      * cmd         - command tag
      *  values     - (see IBM i *CMD IBM i- 5250 cut/paste)
      * options
      *  exec
      *     cmd     - qcmdexe only return true/false (default)
      *     system  - system utility return CPFxxxx
      *     rexx    - rexx output parms and return CPFxxxx
      *                 (?) character type
      *                 (?N) explicit cast numeric
      *  hex (1.6.8)
      *     on      - input character hex (5147504C20202020)
      *  before
      *     cc(n)   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  after
      *     cc(n)   - output ccsid1->ccsid2->ccsid3->ccsid4
      *  error (1.7.6)
      *     on      - script stops, full error report
      *     off     - script continues, job error log (default)
      *     fast    - script continues, brief error log
      * ---
      * example run command (original)
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <cmd>ADDLIBLE LIB(DB2) POSITION(*FIRST)</cmd>
      *  </xmlservice>
      * ---
      * example output command (exec='rexx')
      *  <?xml version='1.0'?>
      *  <xmlservice>
      *  <cmd exec='rexx'>RTVJOBA USRLIBL(?) SYSLIBL(?)</cmd>
      *  <cmd exec='rexx'>RTVJOBA CCSID(?N) OUTQ(?)</cmd>
      *  <cmd exec='rexx'>RTVSYSVAL SYSVAL(QDATETIME) RTNVAR(?)</cmd>
      *  </xmlservice>
      * ---
      *   Note:
      *   - <cmd>command</cmd> should be all on one line (no LFs)
      *   - <cmd> run in XMLSERVICE job.
      *     cmd    - qcmdexe only return true/false       (default)
      *     system - system utility return CPFxxxx        (1.5.2)
      *              <cmd exec='system'><error>CPF2103</error></cmd>
      *     rexx   - rexx output parms and return CPFxxxx (1.5.2)
      *              <cmd exec='rexx'><error>CPF2103</error></cmd>
      *   - exec='rexx'
      *     All parms are assume to be character unless
      *     (?N) to explicit cast to numeric (rtvjoba). Most
      *     RTVxxxx that ask for a CL variable RTNVAR will
      *     not require the (?N) cast (IBM i manuals).
      *     QTEMP/XMLREXX(HOW) is created on demand
      *     by RPG module plugile (Yips download).
      *     QTEMP/OUTREXX(OUTREXX) is created for
      *     command temp data between RPG and REXX.
      *   - Up to four conversions can take place
      *     for the truly complex ccsid issues (1.6.8)
      *     <cmd hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
      *       flow:
      *       -> PHP client bin2hex('wild_ascii_raw_chars')
      *       -> xmlservice hex2bin back to 'wild_ascii_raw_chars'
      *       -> xmlservice convert cc1->cc2->cc3->cc4 (before)
      *       -> xmlservice make ILE call
      *       -> xmlservice convert cc4->cc3->cc2->cc1 (after)
      *       -> xmlservice tohex "xml_hex_back"
      *       -> PHP client $chars = pack('H*',"xml_hex_back")
      *       output (incompatible change hex/ccsid 1.7.4+):
      *       <cmd exec='rexx' hex='on' before='819/37' after='37/819'>
      *         <success><![CDATA[+++ success RTVJOBA USRLIBL(?) SYSLIBL(?)]]></success>
      *         <row><data desc='USRLIBL'><hex><![CDATA[5147504C20202020202020]]></hex></data></row>
      *         <row><data desc='SYSLIBL'><hex><![CDATA[5153595320202020202020]]></hex></data></row>
      *       </cmd>
      *   - error='on,off,fast' (1.7.6)
      *       on  - script stops, full error report
      *       off - script continues, job error log (default)
      *       fast - script continues, brief error log
      *************************************************************************
      * 2) call PASE utility
      * XMLSERVICE allows calls of PASE utilities on IBM i. Typically, you cut/paste
      * from a PASE command line (call qp2term). PASE shell 'sh' is used for
      * execution of your utilities, which, is default behavior of PASE popen() API.
      * ---
      * <sh [rows='on|off'
      *      hex='on'
      *      before='cc1/cc2/cc3/cc4'
      *      after='cc4/cc3/cc2/cc1'
      *      error='on|off|fast'
      *      ]>values (see PASE utility)</sh>
      * ---
      * sh          - shell tag
      *  values     - (see PASE utility - call qp2term cut/paste)
      * options
      *  rows
      *     on      - return rows lines
      *     off     - return one string (default)
      *  hex (1.7.4)
      *     on      - input character hex (5147504C20202020)
      *  before
      *     cc(n)   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  after
      *     cc(n)   - output ccsid1->ccsid2->ccsid3->ccsid4
      * ---
      *  error (1.7.6)
      *     on      - script stops, full error report
      *     off     - script continues, job error log (default)
      *     fast    - script continues, brief error log
      * ---
      * example run PASE shell
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <sh rows='on'>/QOpenSys/usr/bin/system 'wrkactjob' | grep -i fr</sh>
      *  </xmlservice>
      * ---
      * Note:
      *   - syntax looks as if typed on console (call qp2term)
      *     <sh>pase utility</sh> runs "slower" because a child job
      *     is created to run each PASE utility (normal Unix behavior).
      *     All other XML/ILE functions run within XMLSERVICE job.
      *   - Using nested shells within this sh shell may
      *     produce unpredictable results.
      *   - hex='on' before='' after='' -- same as <cmd> (1.7.0)
      *       output (incompatible change hex/ccsid 1.7.4+):
      *       <sh rows='on' hex='on' before='819/37' after='37/819'>
      *         <row><hex>746F74616C2031363636313034</hex></row>
      *       </sh>
      *       output (rows='off' 1.7.4+):
      *       <sh hex='on' before='819/37' after='37/819'>
      *         <hex>746F74616C2031363636313034</hex>
      *       </sh>
      *   - error='on,off,fast' (1.7.6)
      *       on  - script stops, full error report
      *       off - script continues, job error log (default)
      *       fast - script continues, brief error log
      *************************************************************************
      * 2.5) call QSH utility (1.9.8+)
      * XMLSERVICE allows calls of QSH utilities on IBM i. Typically, you cut/paste
      * from a QSH command line. STRQSH is used for execution of your utilities.
      * ---
      * <qsh [rows='on|off'
      *      hex='on'
      *      before='cc1/cc2/cc3/cc4'
      *      after='cc4/cc3/cc2/cc1'
      *      error='on|off|fast'
      *      ]>values (see QSH utility)</qsh>
      * ---
      * qsh         - shell tag
      *  values     - (see QSH utility - qsh cut/paste)
      * options
      *  rows
      *     on      - return rows lines
      *     off     - return one string (default)
      *  hex (1.7.4)
      *     on      - input character hex (5147504C20202020)
      *  before
      *     cc(n)   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  after
      *     cc(n)   - output ccsid1->ccsid2->ccsid3->ccsid4
      * ---
      *  error (1.7.6)
      *     on      - script stops, full error report
      *     off     - script continues, job error log (default)
      *     fast    - script continues, brief error log
      * ---
      * example run QSH shell
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <qsh rows='on'>/usr/bin/system 'wrkactjob' | /usr/bin/grep -i fr</qsh>
      *  </xmlservice>
      * ---
      * Note:
      *   - Recommend qualify qsh utilities with /usr/bin.
      *     This will avoid ccsid conversion between PASE/QSH utilities.
      *   - syntax looks as if typed on console (qsh)
      *     <qsh>QSH utility</qsh> runs "slower" because a child job
      *     is created to run each QSH utility (normal Unix behavior).
      *   - Using nested shells within this qsh shell may
      *     produce unpredictable results.
      *   - hex='on' before='' after='' -- same as <cmd> (1.7.0)
      *   - error='on,off,fast' (1.7.6)
      *       on  - script stops, full error report
      *       off - script continues, job error log (default)
      *       fast - script continues, brief error log
      *************************************************************************
      * 3) call PGM/SRVPGM
      * XMLSERVICE allows calls of *PGM and *SRVPGM on IBM i. Typically, you match
      * call parameters, including data structures, and/or simple data elements.
      * ---
      * pgm name (*PGM or *SRVPGM)
      * <pgm name=''
      *      [lib=''
      *       func=''
      *       mode='opm|ile'
      *       error='on|off|fast'
      *       ]>values (see <parm> and <return>) </pgm>
      * ---
      * pgm         - IBM i *PGM or *SRVPGM name (tag)
      *  values     - (see parm and return)
      * options
      *  lib
      *     library - IBM i library name
      *  func
      *     function- IBM i *SRVPGM function name
      *  mode
      *     ile     - ILE and PASE memory (default)
      *     opm     - ILE only memory (PASE can not view)
      *  error (1.7.6)
      *     on      - script stops, full error report
      *     off     - script continues, job error log (default)
      *     fast    - script continues, brief error log
      *
      * ---
      * pgm parameters
      * <parm [io='in|out|both|omit'
      *        by='val|ref'
      *        ]>values (see <ds> and <data>)</parm>
      * ---
      * parm        - parm name (tag)
      *  values     - (see ds or data)
      * options
      *  io
      *     in      - input only
      *     out     - output only
      *     both    - input/output only (default)
      *     omit    - omit (1.2.3)
      *  by
      *     ref     - pass by reference (default)
      *     val     - pass by value (do not use, untested)
      *
      * ---
      * pgm return
      * <return>values (see <ds> and <data>)</return>
      * ---
      * return      - return tag
      *  values     - (see ds or data)
      * options
      *  na         - no options
      *
      * ---
      * pgm data structure
      * <ds [dim='n' dou='label'
      *      len='label'
      *      data='records'
      *      ]>values (see <ds> or <data>)</ds>
      * ---
      * ds          - data structure tag
      * values      - (see ds or data)
      * options
      *  dim
      *   n         - array dimension value (default dim1)
      *  dou
      *   label     - match array dou terminate parm label (see data)
      *  len (1.5.4)
      *   label     - match calculate length of ds parm lable (see data)
      *  data (1.7.5)
      *   records   - data in records tag
      *
      * ---
      * pgm data elements
      * <data type='data types'
      *       [dim='n'
      *       varying='on|off|2|4'
      *       enddo='label'
      *       setlen='label'
      *       offset='label'
      *       hex='on|off' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'
      *       trim='on|off'
      *       next='label'
      *       ]>(value)</data>
      * ---
      * data        - data value name (tag)
      *  values     - value,
      * type
      *     3i0                   int8/byte     D myint8   3i 0
      *     5i0                   int16/short   D myint16  5i 0
      *     10i0                  int32/int     D myint32 10i 0
      *     20i0                  int64/int64   D myint64 20i 0
      *     3u0                   uint8/ubyte   D myint8   3u 0
      *     5u0                   uint16/ushort D myint16  5u 0
      *     10u0                  uint32/uint   D myint32 10u 0
      *     20u0                  uint64/uint64 D myint64 20u 0
      *     32a                   char          D mychar  32a
      *     32a   {varying2} varchar            D mychar  32a   varying
      *     32a   {varying4} varchar4           D mychar  32a   varying(4)
      *     12p2                  packed        D mydec   12p 2
      *     12s2                  zoned         D myzone  12s 2
      *     4f2                   float         D myfloat  4f
      *     8f4                   real/double   D myfloat  8f
      *     3b                    binary        D mybin   (any)
      *     40h                   hole (no out) D myhole  (any)
      * options
      *  dim
      *     n       - array dimension value (default dim1)
      *  varying
      *     on      - character varying data (same as varying2)
      *     off     - character non-varying data (default)
      *     2       - character varying data
      *     4       - character varying data
      *  enddou
      *     label   - match array dou terminate parm label (see ds)
      *  setlen (1.5.4)
      *     label   - match calculate length of ds parm lable (see ds)
      *  offset
      *     label   - match offset label (see overlay)
      *  hex (1.6.8)
      *     on      - input character hex (5147504C20202020)
      *  before
      *     cc(n)   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  after
      *     cc(n)   - output ccsid1->ccsid2->ccsid3->ccsid4
      *  trim (1.7.1)
      *     on      - trim character (default)
      *     off     - no trim character
      *  next (1.9.2)
      *     label   - match next offset label (see overlay)
      *
      * ---
      * pgm parameters/return overlay
      * <overlay
      *       [io='in|out|both'
      *        offset='n|label'
      *        top='on|off|n'
      *        setnext='nextoff'
      *        ]>(see <ds> and <data>)</overlay>
      * ---
      * overlay     - structure overlay name (tag)
      *  values     - (see ds or data)
      * options
      *  io
      *     in      - input only
      *     out     - output only
      *     both    - input/output only (default)
      *  offset
      *     n       - overlay bytes offset relative
      *     label   - overlay match bytes offset label (see data)
      *  setnext (1.9.2)
      *     label   - overlay match next offset label (see data)
      *  top
      *     n       - overlay parm number (see parm)
      *     on      - overlay parm first (see parm)
      *     off     - overlay parm last seen (see parm)
      * ---
      * example run a PGM
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <cmd>CHGLIBL LIBL(XMLSERVICE) CURLIB(XMLSERVICE)</cmd>
      *  <pgm name='ZZCALL' lib=''>
      *   <parm  io='both'>
      *     <data type='1A' var='INCHARA'>a</data>
      *   </parm>
      *   <parm  io='both'>
      *     <data type='1A' var='INCHARB'>b</data>
      *   </parm>
      *   <parm  io='both'>
      *     <data type='7p4' var='INDEC1'>11.1111</data>
      *   </parm>
      *   <parm  io='both'>
      *     <data type='12p2' var='INDEC2'>222.22</data>
      *   </parm>
      *   <parm  io='both'>
      *    <ds>
      *     <data type='1A' var='INDS1.DSCHARA'>x</data>
      *     <data type='1A' var='INDS1.DSCHARB'>y</data>
      *     <data type='7p4' var='INDS1.DSDEC1'>66.6666</data>
      *     <data type='12p2' var='INDS1.DSDEC2'>77777.77</data>
      *    </ds>
      *   </parm>
      *   <return>
      *    <data type='10i0'>0</data>
      *   </return>
      *  </pgm>
      *  </xmlservice>
      * ---
      * example run a SRVPGM
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <pgm name='ZZSRV' lib='XMLSERVICE' func='ZZARRAY'>
      *   <parm comment='search this name'>
      *    <data var='myName' type='10A'>Ranger</data>
      *   </parm>
      *   <parm comment='max allowed return'>
      *    <data var='myMax' type='10i0'>5</data>
      *   </parm>
      *   <parm comment='actual count returned'>
      *    <data var='myCount' type='10i0' enddo='mycount'>0</data>
      *   </parm>
      *   <return>
      *    <ds var='dcRec_t' dim='999' dou='mycount'>
      *      <data var='dcMyName' type='10A'>na</data>
      *      <data var='dcMyJob' type='4096A'>na</data>
      *      <data var='dcMyRank' type='10i0'>0</data>
      *      <data var='dcMyPay' type='12p2'>0.0</data>
      *    </ds>
      *   </return>
      *  </pgm>
      *  </xmlservice>
      * ---
      * example optional ccsid convert name/lib format (1.6.8)
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <pgm>
      *   <name hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('&fredflin')</name>
      *   <lib hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('omlated')</lib>
      *   <func hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('me&proc')</func>
      *   <parm>
      *    <ds dim='3'>
      *      <data type='1A'>a</data>
      *    </ds>
      *   </parm>
      *   <return>
      *    <ds dim='999'>
      *      <data type='10i0'>0</data>
      *    </ds>
      *    </return>
      *  </pgm>
      *  </xmlservice>
      * ---
      * Note:
      *   - data types (similar RPG):
      *     ----------------------------------------------------------------------
      *     int8/byte     D myint8   3i 0            <data type='3i0'/>
      *     int16/short   D myint16  5i 0            <data type='5i0'/>
      *     int32/int     D myint32 10i 0            <data type='10i0'/>
      *     int64/int64   D myint64 20i 0            <data type='20i0'/>
      *     uint8/ubyte   D myint8   3u 0            <data type='3u0'/>
      *     uint16/ushort D myint16  5u 0            <data type='5u0'/>
      *     uint32/uint   D myint32 10u 0            <data type='10u0'/>
      *     uint64/uint64 D myint64 20u 0            <data type='20u0'/>
      *     char          D mychar  32a              <data type='32a'/>
      *     varchar       D mychar  32a   varying    <data type='32a' varying='2'/>
      *     varchar4      D mychar  32a   varying(4) <data type='32a' varying='4'/>
      *     packed        D mydec   12p 2            <data type='12p2'/>
      *     zoned         D myzone  12s 2            <data type='12s2'/>
      *     float         D myfloat  4f              <data type='4f2'/>
      *     real/double   D myfloat  8f              <data type='8f4'/>
      *     binary        D mybin   (any)            <data type='3b'>F0F1F2</data>
      *     hole (no out) D myhole  (any)            <data type='40h'/>
      *     ------------------------------------------------------------------------
      *     type='na' [varying='on|off|2|4'] - character (32A)
      *       <data type='32a'/>
      *       <data type='32a' varying='on'>ranger</data>
      *       <data type='32a'><![CDATA[<i am ranger>]]></data>
      *       <data type='200A' hex='on' before='1208/930' after='930/1208'>
      *       bin2hex($japan_raw_ascii_data)
      *       </data>
      *     type='npn' - packed decimal (12p2)
      *       <data type='12p2'/>
      *       <data type='12p2'>30.29</data>
      *     type='nsn' - zoned decimal (12s2)
      *       <data type='12s2'/>
      *       <data type='12s2'>30.29</data>
      *     type='nin' - signed integer (5i0, 10i0, 20i0)
      *       <data type='20i0'/>
      *       <data type='10i0'>-30</data>
      *     type='nun' - unsigned integer (5u0, 10u0, 20u0)
      *       <data type='20u0'/>
      *       <data type='10u0'>30</data>
      *     type='nfn' - floating point (4f2, 8f4)
      *       <data type='4f2'/>
      *       <data type='4f2'>30.34</data>
      *       <data type='8f4'>30.34</data>
      *     type='nb' - binary HEX char (2b, 400b)
      *       <data type='5b'>F0F1F2CDEF</data>
      *       <data type='2b'>1FBC</data>
      *       <data type='2b'>0F0F</data>
      *       - HEX upper case ('1FBC' not '1fbc')
      *       - high/low bits (HEX='0F0F' not HEX='F0F')
      *     type='nh' - 'hole' zero in, nothing out (4096h) (1.2.3)
      *       <data type='400h'/>
      *   - PGM/SRVPGM calls (<pgm>,<parm>,<data>,<return>) use syntax
      *     that looks like RPG to describe the data parameters
      *     (type='4b', type='32a', type='4f', type='10i0', type='12p2',
      *     etc.).
      *   - <data dim='n'> - dim='n' is new to 1.2 version and beyond,
      *     older versions did not include this feature.
      *   - Parameters using dou='label', enddo='label',
      *     label must match for this to work,
      *     then processing will only return records up to enddo limits.
      *   - Type 'h' for 'hole' is used to input x'00' fill 'hole'
      *     in the parameter geometry. It can be used to skip over
      *     a chunk of complex data that you really did not want to
      *     deal with or see in output XML. It is also very handy to
      *     use with overlay when output data is variable
      *     or unpredictable (1.2.3)
      *     input:
      *      <ds>
      *        <data type='40a'>good stuff</data>     <---offset 0
      *        <data type='400h'/>                    <---400 x'00' input
      *        <data type='32a'>more good stuff</data><---offset 440
      *      </ds>
      *     output:
      *      <ds>
      *        <data type='40a'>stuff back</data>     <--- offset 0
      *        <data type='400h'> </data>             <--- ignored output
      *        <data type='32a'>stuff back</data>     <--- offset 440
      *      </ds>
      *   - Added parm='omit' for RPG OPTIONS(*OMIT) parameter. A
      *     *NULL will be passed in this location.
      *     All parm io='omit' will be excluded from XML
      *     output returned because *NULL parameter has no data (1.2.3).
      *       <parm comment='my name' io='omit'>
      *         <data var='myName' type='10A'>Ranger</data> <--ignore *NULL
      *       </parm>
      *       RPG procedure (SRVPGM function):
      *       D zzomit PI 50A varying
      *       D myName 10A options(*OMIT) <---- optional omitted (*NULL)
      *       D yourName 10A
      *   - Added len='label'/setlen='label' to allow for
      *     automatic length calculation for various system
      *     APIs that want a %size(thing) parameter.
      *     This should work across parameters and within
      *     parameters (any order), but nesting len/setlen is
      *     not allowed.
      *       <parm  io="both" comment='Error code'>
      *        <ds comment='Format ERRC0100' len='rec2'>
      *         <data type='10i0' comment='returned'>0</data>
      *         <data type='10i0' comment='available' setlen='rec2'>0</data>
      *         <data type='7A' comment='Exception ID'> </data>
      *         <data type='1A' comment='Reserved'> </data>
      *        </ds>
      *       </parm>
      *   - Up to four conversions can take place
      *     for the truly complex ccsid issues (1.6.8)
      *      <data type='A' hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
      *      flow:
      *      -> PHP client bin2hex('wild_ascii_raw_chars')
      *      -> xmlservice hex2bin back to 'wild_ascii_raw_chars'
      *      -> xmlservice convert cc1->cc2->cc3->cc4 (before)
      *      -> xmlservice make ILE call
      *      -> xmlservice convert cc4->cc3->cc2->cc1 (after)
      *      -> xmlservice tohex "xml_hex_back"
      *      -> PHP client $chars = pack('H*',"xml_hex_back")
      *   - V5R4 accomidation for OPM programs like CLP (1.6.8)
      *      - mode='opm' uses non-teraspace memory to build parm lists
      *        that are used with _CALLPGMV for a "pure" OPM call mode
      *      - mode='ile' default using teraspace for "mixed" memory
      *        compatible with PASE calls (IBM i possiblilities)
      *   - Allow trim control character/binary <data ... trim='on|off'>
      *      - trim='on'  -- right trim  (default character type='na')
      *      - trim='off' -- include all (default binary type='nb')
      *   - see <overlay> for offset='label'
      *      <data offset='label'>            <-- memory location to pop off a
      *                                           variable/changing offset value
      *                                           for use in overlay()
      *      <overlay top='n' offset='label'> <-- top='n' overlay parameter 'n',
      *                                           then add offset='label' pop value
      *      - offset='label' allows label location to pop off a <data> offset value
      *        at this data location to add position offset <overlay offset='label'>
      *      - 'label' is NOT a position location for <overlay>, it only holds
      *        a offset value in this <data> memory location for things like
      *        system APIs with offset-2-next.
      *   - data='records' - data follows in record format
      *      fast "many records" i/o big data (see below)  (1.7.5)
      *      <parm comment='wsopstdcnt'>
      *       <data type='3s0' enddo='wsopstdcnt'/>
      *      </parm>
      *      <parm comment='findMe1'>
      *       <ds var='findMe1' data='records'>
      *        <ds var='dcRec1_t' array='on'>
      *         <ds var='dcRec1_t'>
      *          <data var='dcMyName1' type='10A'/>
      *          <ds var='dcRec2_t'>
      *           <data var='dcMyName2' type='10A'/>
      *           <ds var='dcRec3_t'>
      *            <data var='dcMyName3' type='10A'/>
      *            <ds var='dcRec_t' dim='999' dou='wsopstdcnt'>
      *             <data var='dcMyName' type='10A'/>
      *             <data var='dcMyJob' type='4096A'/>
      *             <data var='dcMyRank' type='10i0'/>
      *             <data var='dcMyPay' type='12p2'/>
      *            </ds>
      *           </ds>
      *          </ds>
      *         </ds>
      *        </ds>
      *       </ds>
      *       <records delimit=':'>:Rgr:B:Ok:nd1:nd1:1:1.1:...:</records>
      *      </parm>
      *      a) <records delimit=':'> simply match in order input
      *         of any complex structure. Output matches
      *         order input (see above)
      *      b) <records  delimit=':'> delimit can be any character
      *         not in your complex records (see above)
      *      c) works with any <parm> or <return>
      *      d) dou/enddo works, but tricky script to design (be careful)
      *   - setnext='nextoff' / next='nextoff' - see overlay  (1.9.2)
      *   - len/setlen - auto-len calculate ds setlen='here' (1.5.4)
      *   - error='on,off,fast' (1.7.6)
      *       on  - script stops, full error report (default)
      *       off - script continues, job error log
      *      fast - script continues, brief error log
      *   - pgm parameters/return overlay (custom offset='bytes', input/output):
      *     <overlay> works "relative" to "previous" <parm> in
      *               "order of appearance XML"
      *               or absolute position to (top='n')
      *     <pgm>
      *     --->absolute parm             <---relative parm
      *     ---><parm>complex stuff</parm><-------------------
      *     |   <overlay>complex over parm 1   </overlay>____|
      *     |
      *     |--><parm>complex stuff</parm><-------------------
      *     ||  <overlay>complex over parm 2   </overlay>____|
      *     ||  :
      *     ||  <parm>complex stuff</parm><-------------------
      *     ||  <overlay>complex over last parm</overlay>____|
      *     ||  :
      *     |___<overlay top='on'>over top parm</overlay>
      *      |  :
      *      |__<overlay top='2'>over parm 2  </overlay>
      *     </pgm>
      *   - top='on|n' allow overlay position to parameter n
      *      ... top='on' absolute parm='1' (1.2.1)
      *      ... top='n' absolute parm='n' (1.2.2)
      *      ... offset='n' bytes offset relative
      *          to top='n' position (parm 1,2,3, etc)
      *   - Once the top='n' parm location is etablished, offset='n'
      *     will move overlay to offset within the parameter.
      *     <data offset='label'>            <-- memory location to pop off a
      *                                          variable/changing offset value
      *                                          for use in overlay()
      *     <overlay top='n' offset='label'> <-- top='n' overlay parameter 'n',
      *                                          then add offset='label' pop value
      *     - offset='label' allows label location to pop off a <data> offset value
      *       at this data location to add position offset <overlay offset='label'>
      *     - 'label' is NOT a position location for <overlay>, it only holds
      *       a offset value in this <data> memory location for things like
      *       system APIs with offset-2-next.
      *   - setnext='nextoff' / next='nextoff'  (1.9.2)
      *      <pgm name='QSZRTVPR'>
      *       <parm io='both'>
      *        <ds comment='PRDR0200'>
      *         :
      *         <data type='10i0' offset='myOffset'></data>
      *         :
      *       </ds>
      *      </parm>
      *       :
      *      <overlay io='out' top='1' offset='myOffset'>
      *       <ds>
      *        <data type='10A'></data>
      *        <data type='2A'></data>
      *        <data type='10i0' enddo='prim'></data>
      *        <data type='10i0' offset='myOffset2'></data>
      *       </ds>
      *       </overlay>
      *       <overlay io='out' top='1' offset='myOffset2'
      *                dim='10' dou='prim' setnext='nextoff'>
      *       <ds>
      *        <data type='10i0' next='nextoff'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10i0'></data>
      *        <data type='10A'></data>
      *       </ds>
      *      </overlay>
      *************************************************************************

      *****************************************************
      * global vars
      *****************************************************
     D XML_PGM_TOP_TRUE...
     D                 c                   const(x'01')
     D XML_PGM_TOP_FALSE...
     D                 c                   const(x'00')

     D XML_PGM_OPM_TRUE...
     D                 c                   const(x'01')
     D XML_PGM_OPM_FALSE...
     D                 c                   const(x'00')

     D XML_PGM_ERROR_TRUE...
     D                 c                   const(x'01')
     D XML_PGM_ERROR_FALSE...
     D                 c                   const(x'00')

     D XML_OVR_TOP_TRUE...
     D                 c                   const(x'01')
     D XML_OVR_TOP_FALSE...
     D                 c                   const(x'00')


     D XML_PARM_OMIT_TRUE...
     D                 c                   const(x'01')
     D XML_PARM_OMIT_FALSE...
     D                 c                   const(x'00')

     D XML_ATTR_HEX_TRUE...
     D                 c                   const(x'01')
     D XML_ATTR_HEX_FALSE...
     D                 c                   const(x'00')

     D XML_ATTR_TRIM_TRUE...
     D                 c                   const(x'01')
     D XML_ATTR_TRIM_FALSE...
     D                 c                   const(x'02')
     D XML_ATTR_TRIM_DEFAULT...
     D                 c                   const(x'00')

     D XML_ATTR_CDATA_TRUE...
     D                 c                   const(x'01')
     D XML_ATTR_CDATA_FALSE...
     D                 c                   const(x'00')

     D XML_FUNC_PGM...
     D                 c                   const(x'00')
     D XML_FUNC_SRVPGM...
     D                 c                   const('S')

     D XML_IS_PARM...
     D                 c                   const(x'00')
     D XML_IS_RETURN...
     D                 c                   const('R')

     D XML_BY_VAL...
     D                 c                   const('V')
     D XML_BY_REF...
     D                 c                   const(x'00')
     D XML_BY_MBR...
     D                 c                   const('M')

     D XML_PTR_ILE...
     D                 c                   const('I')
     D XML_PTR_PASE...
     D                 c                   const('P')
     D XML_PTR_NADA...
     D                 c                   const(x'00')

     D XML_IO_INPUT...
     D                 c                   const('I')
     D XML_IO_OUTPUT...
     D                 c                   const('O')
     D XML_IO_BOTH...
     D                 c                   const(x'00')

     D XML_VARY_4...
     D                 c                   const(x'04')
     D XML_VARY_ON...
     D                 c                   const(x'02')
     D XML_VARY_OFF...
     D                 c                   const(x'00')

     D XML_ATTR_VAL_NADA...
     D                 c                   const(x'00')
     D XML_ATTR_VAL_A...
     D                 c                   const('A')
     D XML_ATTR_VAL_C...
     D                 c                   const('C')
     D XML_ATTR_VAL_I...
     D                 c                   const('I')
     D XML_ATTR_VAL_U...
     D                 c                   const('U')
     D XML_ATTR_VAL_P...
     D                 c                   const('P')
     D XML_ATTR_VAL_S...
     D                 c                   const('S')
     D XML_ATTR_VAL_F...
     D                 c                   const('F')
     D XML_ATTR_VAL_D...
     D                 c                   const('D')
     D XML_ATTR_VAL_B...
     D                 c                   const('B')
     D XML_ATTR_VAL_H...
     D                 c                   const('H')

     D XML_ELEMENT_OPEN...
     D                 c                   const('O')
     D XML_ELEMENT_CONN...
     D                 c                   const('C')
     D XML_ELEMENT_STMT...
     D                 c                   const('S')
     D XML_ELEMENT_BOTH...
     D                 c                   const('B')
     D XML_ELEMENT_CLOSE...
     D                 c                   const('E')
     D XML_ELEMENT_CLOSE_NOLF...
     D                 c                   const('N')

     D XML_IS_RECORDS_FALSE...
     D                 c                   const(x'00')
     D XML_IS_RECORDS_TRUE...
     D                 c                   const('R')
     D XML_IS_RECORDS_DS...
     D                 c                   const('S')
     D XML_IS_RECORDS_DATA...
     D                 c                   const('D')


      *****************************************************
      * global xml
      *****************************************************
     D xmlStatic       PR
     D   aCtlP                         *   value

     D xmlOutUsed      PR            10i 0
     D xmlOutRoom      PR            10i 0
     D xmlOutReset     PR

     D xmlSetCDATA     PR
     D   setCDATA                     1N   value
     D xmlGetCDATA     PR             1N
     D xmlcCDATA1      PR             9A
     D xmlcCDATA2      PR             3A

     D xmlGetESCP      PR             1N
     D xmlSidCDATA     PR
     D  toCCSID                      10i 0 value

     D xmlResetCDATA...
     D                 PR

     D xmlCTOR         PR
     D   node                              likeds(xmlNode_t)

     D xmlCOPY         PR
     D   node                              likeds(xmlNode_t)
     D   node2                             likeds(xmlNode_t)

     D xmlSetHead      PR
     D   data                          *   value
     D   dataSz                      10i 0 value

     D xmlGetHead      PR          2048A

     D xmlPreSbm       PR             1N

     D xmlPreRun       PR             1N

     D xmlRun          PR             1N

     D xmlHack         PR             1N

     D xmlTerm         PR             1N

     D xmlLic          PR             1N

     D xmlSess         PR             1N
     D   addHead                      1N   value options(*nopass)
     D   addJobNbr                    1N   value options(*nopass)

     D xmlPerf         PR             1N
     D   ipcCtl                            likeds(ipcRec_t)

     D xmlPerfRpt      PR
     D   pData                         *   value
     D   report                   32000A

     D xmlError        PR             1N
     D   isfull                       1N   value
     D   isjoblog                     1N   value
     D   ijobName                    10A   value options(*nopass)
     D   ijobUserID                  10A   value options(*nopass)
     D   ijobNbr                      6A   value options(*nopass)
     D   ifast                        1N   value options(*nopass)

     D xmlOutput       PR
     D   string                        *   value
     D   stringLen                   10i 0 value
     D   addLF                        1N   value
     D   subSlash                     1N   value options(*nopass)

     D xmlDump         PR
     D   msg                         15A   value
     D   pTop                          *   value
     D   pBot                          *   value
     D   isHex                        1N   value

     D xmlExec32       PR             1N
     D cmd                             *   value
     D cmdLen                        10i 0 value
     D isRows                         1N   value
     D keepBottom                     1N   value
     D isCDATA                        1N   value
     D out                             *   value
     D outLen                        10i 0 value
     D retLen                        10i 0
     D useQsh                         1N   value


      *****************************************************
      * global batch slots
      *****************************************************
     D xmlBatAny       PR            10i 0

     D xmlBatCopy      PR             1N
     D   runMemP                       *   value

     D xmlBatXML       PR             1N
     D   runMemP                       *

     D xmlBatGet       PR             1N
     D   runMemP                       *   value

     D xmlBatDone      PR
     D   runMemP                       *   value



