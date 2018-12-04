      /if defined(PLUGCACH_H)
      /eof
      /endif
      /define PLUGCACH_H
   
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
      * Cache points ...
      * ---------------------------
      * 1) Memory allocations               -- cacClrBig, cacAddBig, cacScanBig
      *    Error records                    -- cacClrErr, cacAddErr, cacScanErr
      *    Performance records              -- cacClrPrf, cacAddPrf, cacScanPrf
      * ---------------------------
      * 2) Program                          -- original pgm design
      *    <pgm name='ZZEXMP' lib='MYLIB'>
      *                                     -- cacClrPgm, cacAddPgm, cacScanPgm
      *                                        (lib.name.sym<>actmark,procptr)
      *     <parm io='both'>
      *       <data type='1A'>a</data>
      *     </parm>
      *     <parm io='both'>
      *       <data type='1A'>b</data>
      *     </parm>
      *     <parm io='both'>
      *       <data type='7p4'>1.1111</data>
      *     </parm>
      *     <parm io='both'>
      *       <data type='12p2'>2.22</data>
      *                                     -- cacClrTyp, cacAddTyp, cacScanTyp
      *                                        (type='1A', type='12p2')
      *     </parm>
      *     <parm io='both'>
      *      <ds dim='32'>
      *       <data type='1A'>x</data>
      *       <data type='1A'>y</data>
      *       <data type='7p4'>6.6666</data>
      *       <data type='12p2'>77.77</data>
      *                                     -- cacClrF64, cacAddF64, cacScanF64
      *                                        ('77.77'<>77.77)
      *      </ds>
      *     </parm>
      *     <parm io='both'>
      *      <ds len='rec2'>
      *                                     -- cacClrLen, cacAddLen, cacScanLen
      *                                        (len='rec2'<>setlen='rec2')
      *       <data type='10i0'>0</data>
      *       <data type='10i0' setlen='rec2'>0</data>
      *                                     -- cacxxxLen
      *                                        (len='rec2'<>setlen='rec2')
      *       <data type='7A'> </data>
      *       <data type='1A'> </data>
      *      </ds>
      *     </parm>
      *     <parm io='both'>
      *      <data type='10i0' enddo='mycount'>0</data>
      *                                     -- cacxxxDou
      *                                        (dou='mycount'<>enddo='mycount')
      *     </parm>
      *     <return>
      *      <ds dim='999' dou='mycount'>
      *                                     -- cacClrDou, cacAddDou, cacScanDou
      *                                        (dou='mycount'<>enddo='mycount')
      *        <data type='10A'>na</data>
      *        <data type='4096A'>na</data>
      *        <data type='10i0'>0</data>
      *        <data type='12p2'>0.0</data>
      *      </ds>
      *     </return>
      *      <overlay io='out'>
      *                                     -- cacClrOvr, cacAddOvr, cacScanOvr
      *                                        (offset='200' top='6')
      *       <ds dim='5'>
      *         <data type='10A'>na</data>
      *         <data type='4096A'>na</data>
      *         <data type='10i0'>0</data>
      *         <data type='12p2'>0.0</data>
      *       </ds>
      *      </overlay>
      *    </pgm>
      * ---------------------------
      * 3) SQL
      *    <sql>
      *    <options options='noauto' autocommit='off'/>       
      *                                     -- cacClrOPT, cacAddOPT, cacScanOPT
      *                                        (options='noauto'<> ... )
      *    <connect conn='myconn' options='noauto'/>       
      *                                     -- cacClrDB2, cacAddDB2, cacScanDB2
      *                                        (conn='myconn'<> ...)
      *    <prepare conn='myconn' stmt='mylob'>
      *      UPDATE animal1 SET essay = ?, where id = ?
      *    </prepare>
      *                                     -- cacClrStm, cacAddStm, cacScanStm
      *                                        (stmt='mylob'<> ...)
      *    <execute stmt='mylob'>
      *      <parm io='in'>frog courtin</parm>
      *      <parm io='in'>9</parm>
      *    </execute>
      *    <query stmt='myread'>
      *      select id, essay, picture from animal1 where id = 9
      *    </query>
      *    <describe stmt='myread' desc='col'/>
      *    <fetch stmt='myread' block='all' desc='on'/>
      *    <commit conn='myconn' action='rollback'/>
      *    <free/>
      *    </sql>
      *************************************************************************

      *****************************************************
      * all caches
      *****************************************************
     D CAC_LEVEL_ERROR...
     D                 c                   const(0)
     D CAC_LEVEL_PGM...
     D                 c                   const(1)
     D CAC_LEVEL_HEAP...
     D                 c                   const(3)
     D CAC_LEVEL_SQL...
     D                 c                   const(5)
     D CAC_LEVEL_ALL...
     D                 c                   const(9)

     D cacStatic       PR
     D  level                        10i 0 value

      *****************************************************
      * cache error records
      *****************************************************
     D cacClrErr       PR

     D cacScanErr      PR             1N
     D   idx                         10i 0 value
     D   rec                               likeds(erRec_t)

     D cacAddErr       PR
     D   errXml                      10i 0 value
     D   errHelp                     60A   value
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)

      *****************************************************
      * cache perfomance records
      *****************************************************
     D cacClrPrf       PR

     D cacScanPrf      PR             1N
     D   rptBuff                       *   value
     D   rptLen                      10i 0 value

     D cacAddPrf       PR
     D   myCode                       5i 0 value
     D   myOnOff                      1N   value options(*nopass)


      *****************************************************
      * Big memory cache
      *****************************************************
     D CAC_HEAP_ILE_TMP...
     D                 c                   const('T')
     D CAC_HEAP_ILE_IPC...
     D                 c                   const('I')
     D CAC_HEAP_ILE_REUSE...
     D                 c                   const('R')
     D CAC_HEAP_PGM_OPM...
     D                 c                   const('O')
     D CAC_HEAP_PGM_PASE...
     D                 c                   const('P')

     D cacClrBig       PR
     D  index                        10i 0 value options(*nopass)
     D  ctype                         1A   value options(*nopass)

     D cacScanBig      PR              *
     D  index                        10i 0 value
     D  size                         10i 0 options(*nopass)
     D  useSz                        10i 0 options(*nopass)

     D cacAddBig       PR            10i 0
     D  bsize                        10i 0 value
     D  btype                         1A   value

      *****************************************************
      * xml batch buffers
      *****************************************************
     D CAC_BAT_ADD_INPUT...
     D                 c                   const(x'00')
     D CAC_BAT_XML_GO...
     D                 c                   const('G')
     D CAC_BAT_XML_RUN...
     D                 c                   const('R')
     D CAC_BAT_XML_SIZE...
     D                 c                   const('S')
     D CAC_BAT_GET_AGAIN...
     D                 c                   const('A')
     D CAC_BAT_GET_OUTPUT...
     D                 c                   const('O')
     D CAC_BAT_GET_WRITE...
     D                 c                   const('W')

     D cacClrBat       PR

     D cacScanBat      PR            10i 0
     D   batType                      1A   value
     D   batIPtr                       *
     D   batIsz                      10i 0
     D   batOPtr                       *
     D   batOsz                      10i 0
     D   index                       10i 0 value options(*nopass)

      *****************************************************
      * ILE parms attribute-2-nbr type caching (ILE pgm)
      *****************************************************
     D cacClrTyp       PR

     D cacScanTyp      PR             1N
     D   type                        16A   value
     D   myAttr                       1A
     D   myDigits                    10i 0
     D   myFrac                      10i 0

     D cacAddTyp       PR
     D   type                        16A   value
     D   myAttr                       1A
     D   myDigits                    10i 0
     D   myFrac                      10i 0

      *****************************************************
      * ILE parms string-2-real converts (ILE pgm)
      *****************************************************
     D cacClrF64       PR
     D   isOut                        1N   value

     D CAC_F64_SCAN_STR_SAME...
     D                 c                   const('S')
     D CAC_F64_SCAN_DOUBLE_SAME...
     D                 c                   const('R')
     D CAC_F64_SCAN_DECIMAL_SAME...
     D                 c                   const('D')

     D cacScanF64      PR             1N
     D   isOut                        1N   value
     D   type                         1A   value
     D   valPtrP                       *   value
     D   f64                          8f
     D   ptrP                          *
     D   sz                          10i 0
     D   strP                          *
     D   strSz                       10i 0
     D   xmlStrP                       *   value
     D   xmlStrSz                    10i 0 value
     D   xmlAttr                      1A   value
     D   xmlDigits                   10i 0 value
     D   xmlFrac                     10i 0 value
     D   pgmValSz                    10i 0 value

     D cacAddF64       PR
     D   isOut                        1N   value
     D   valPtrP                       *   value
     D   f64                          8f   value
     D   xmlStrP                       *   value
     D   xmlStrSz                    10i 0 value
     D   xmlAttr                      1A   value
     D   xmlDigits                   10i 0 value
     D   xmlFrac                     10i 0 value
     D   pgmValSz                    10i 0 value

      *****************************************************
      * pase call pgm cache (ILE pgm)
      *****************************************************
     D cacClrPgm       PR
     D  index                        10i 0 options(*nopass)


     D CAC_QP2_RSLOBJ2...
     D                 c                   const(1)
     D CAC_QP2_ILELOAD...
     D                 c                   const(2)
     D CAC_QP2_ILESYM...
     D                 c                   const(3)

     D CAC_QP2_PREPARE...
     D                 c                   const(4)

     D cacScanPgm      PR             1N
     D  type                         10i 0 value
     D  pgm1                         10A   value
     D  lib1                         10A   value
     D  sym1                        128A   value
     D  pILESym                        *
     D  actmark                      10I 0
     D  inATT                              likeds(xmlNode_t) options(*nopass)

     D cacAddPgm       PR
     D  type                         10I 0 value
     D  pgm1                         10A   value
     D  lib1                         10A   value
     D  sym1                        128A   value
     D  pILESym                        *
     D  act                          10I 0 value
     D  label                        30A   value options(*nopass)
     D  inATT                              likeds(xmlNode_t) options(*nopass)

      *****************************************************
      * xml scan element
      *****************************************************
     D cacClrXML       PR
     
     D cacFixXML       PR            10i 0

     D cacGetXML       PR            10i 0
     D  xKeyElem                     10i 0 value

     D cacUpdXML       PR            10i 0
     D  where                        10i 0 value
     D  aVeryTop                       *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value

     D cacScanXML      PR            10i 0
     D  aVeryTop                       *   value
     D  aElemTop                       *
     D  xElemTop1                      *
     D  xElemTop2                      *
     D  xDataVal1                      *
     D  xDataVal2                      *
     D  xElemEnd1                      *
     D  xElemEnd2                      *
     D  xElemNext                      *
     D  xDoNada                       1N
     D  xDoCDATA                      1N
     D  xFindElem                    10i 0
     D  aKeyElem                     10i 0

     D cacAddXML       PR            10i 0
     D  aVeryTop                       *   value
     D  aElemTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D  aDoNada                       1N   value
     D  aDoCDATA                      1N   value
     D  aFindElem                    10i 0 value
     D  aKeyElem                     10i 0 value
     D  aDups                         1N   value

      *****************************************************
      * xml element attribute caching (XML node)
      *****************************************************
     D cacClrAtt       PR

     D cacScanAtt      PR            10i 0
     D  inATT                              likeds(xmlNode_t)

     D cacAddAtt       PR
     D  inATT                              likeds(xmlNode_t)

      *****************************************************
      * xml records element attribute caching (XML node)
      *****************************************************
     D cacClrARec      PR

     D cacScanARec     PR            10i 0
     D  index                        10i 0 value
     D  inATT                              likeds(xmlNode_t)

     D cacAddARec      PR
     D  inATT                              likeds(xmlNode_t)

      *****************************************************
      * pgm labels
      *****************************************************
     D cacClrLab       PR

     D cacScanLab      PR            10i 0
     D  myLab                        30A   value
     D  inATT                              likeds(xmlNode_t)

     D cacAddLab       PR            10i 0
     D  myLab                        30A   value
     D  inATT                              likeds(xmlNode_t)

      *****************************************************
      * xml pgm do/enddo caching (XML node)
      *****************************************************
     D cacClrDou       PR

     D cacAddDou       PR             1N
     D   node                              likeds(xmlNode_t) 

     D cacPopDou       PR            10i 0
     D   node                              likeds(xmlNode_t) 

      *****************************************************
      * xml pgm offset (XML node)
      *****************************************************
     D cacClrOff       PR

     D cacAddOff       PR             1N
     D   node                              likeds(xmlNode_t) 

     D cacPopOff       PR            10i 0
     D   node                              likeds(xmlNode_t) 

      *****************************************************
      * xml overlay next offset (XML node)
      *****************************************************
     D cacClrNxt       PR

     D cacAddNxt       PR             1N
     D   node                              likeds(xmlNode_t) 

     D cacPopNxt       PR            10i 0
     D   node                              likeds(xmlNode_t) 

      *****************************************************
      * xml pgm len DS caching (XML node)
      *****************************************************
     D cacClrLen       PR

     D CAC_LEN_BEG...
     D                 c                   const(1)
     D CAC_LEN_END...
     D                 c                   const(2)
     D CAC_LEN_SET...
     D                 c                   const(3)

     D cacAddLen       PR             1N
     D   type                        10I 0 value
     D   node                              likeds(xmlNode_t) 

     D cacPushLen      PR             1N
     D   node                              likeds(xmlNode_t) 

      *****************************************************
      * pgm overlay markers
      *****************************************************
     D cacClrOvr       PR

     D CAC_OVR_TOP...
     D                 c                   const(110001)
     D CAC_OVR_START...
     D                 c                   const(110002)
     D CAC_OVR_END...
     D                 c                   const(110003)

     D cacScanOvr      PR
     D   type                        10i 0 value
     D   offset                      10i 0 value
     D   mOrigP                        *
     D   mArgvP                        *
     D   mArgvSz                     10i 0
     D   mParmP                        *
     D   mParmSz                     10i 0
     D   mRetP                         *
     D   mRetSz                      10i 0
     D   mSigP                         *
     D   mSigSz                      10i 0

     D cacAddOvr       PR
     D   type                        10i 0 value
     D   mOrigP                        *   value
     D   mArgvP                        *   value
     D   mArgvSz                     10i 0 value
     D   mParmP                        *   value
     D   mParmSz                     10i 0 value
     D   mRetP                         *   value
     D   mRetSz                      10i 0 value
     D   mSigP                         *   value
     D   mSigSz                      10i 0 value


      *****************************************************
      * iconv records 
      *****************************************************
     D cacClrCnv       PR

     D cacScanCnv      PR             1N
     D  fromCCSID                    10i 0 Value
     D  toCCSID                      10i 0 Value
     D  conv                               likeds(ciconv_t)

     D cacAddCnv       PR
     D  conv                               likeds(ciconv_t)

     D cacCpyCnv       PR
     D  ptrTgt                         *   value
     D  ptrSrc                         *   value

     D cacNulCnv       PR
     D  convTgt                            likeds(ciconv_t)

      *****************************************************
      * db2 options cache (sql)
      *****************************************************
     D cacClrOPT       PR

     D CAC_OPT_NEW...
     D                 c                   const(1)
     D CAC_OPT_ANY...
     D                 c                   const(2)
     D CAC_OPT_UPDATE...
     D                 c                   const(3)
     D CAC_OPT_ACTIVE...
     D                 c                   const(4)
     D CAC_OPT_DELETE...
     D                 c                   const(5)
     D cacScanOPT      PR             1N
     D  type                         10I 0 value
     D  here                         10I 0 value
     D  label                        10A
     D  pOpt                           *

      *****************************************************
      * db2 connect cache (sql)
      *****************************************************
     D cacClrDB2       PR

     D CAC_CONN_NEW...
     D                 c                   const(1)
     D CAC_CONN_ANY...
     D                 c                   const(2)
     D CAC_CONN_UPDATE...
     D                 c                   const(3)
     D CAC_CONN_ACTIVE...
     D                 c                   const(4)
     D CAC_CONN_DELETE...
     D                 c                   const(5)
     D cacScanDB2      PR             1N
     D  type                         10I 0 value
     D  here                         10I 0
     D  henv                         10I 0
     D  hdbc                         10I 0
     D  label                        10A
     D  options                      10A
     D  db                           10A
     D  uid                          10A
     D  pwd                          10A

      *****************************************************
      * db2 statement cache (sql)
      *****************************************************
     D cacClrStm       PR

     D CAC_STMT_NEW...
     D                 c                   const(1)
     D CAC_STMT_ANY...
     D                 c                   const(2)
     D CAC_STMT_UPDATE...
     D                 c                   const(3)
     D CAC_STMT_ACTIVE...
     D                 c                   const(4)
     D CAC_STMT_DELETE...
     D                 c                   const(5)
     D CAC_STMT_ANY_CONN...
     D                 c                   const(6)
     D CAC_STMT_ALLOC_COLT...
     D                 c                   const(7)
     D CAC_STMT_ALLOC_PARMT...
     D                 c                   const(8)
     D CAC_STMT_DEALLOC_COLT...
     D                 c                   const(9)
     D CAC_STMT_DEALLOC_PARMT...
     D                 c                   const(10)

     D cacScanStm      PR             1N
     D  type                         10I 0 value
     D  here                         10I 0 value
     D  hstmt                        10I 0
     D  conn                         10A
     D  label                        10A
     D  ncolT                         5i 0
     D  colT                           *
     D  nparmT                        5I 0
     D  parmT                          *

      *****************************************************
      * pase call lib cache                         (1.8.5)
      *****************************************************
     D cacClrLib       PR

     D cacScanLib      PR             1N
     D libLibName                    32A   value
     D libMbrName                    32A   value
     D libPthName                  4096A   value
     D pasePtr                       20U 0

     D cacAddLib       PR
     D libLibName                    32A   value
     D libMbrName                    32A   value
     D libPthName                  4096A   value
     D pasePtr                       20U 0 value

      *****************************************************
      * pase call lib sym cache                     (1.8.5)
      *****************************************************
     D cacClrSym       PR

     D cacScanSym      PR             1N
     D symPthNbr                     10i 0 value
     D symSymName                   256A   value
     D pasePtr                       20U 0

     D cacAddSym       PR
     D symPthNbr                     10i 0 value
     D symSymName                   256A   value
     D pasePtr                       20U 0 value



