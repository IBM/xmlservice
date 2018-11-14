     H NOMAIN
     H AlwNull(*UsrCtl)
     H BNDDIR('QC2LE')

      *****************************************************
      * Copyright (c) 2010, IBM Corporation
      * All rights reserved
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

      *****************************************************
      * includes
      *****************************************************
      /copy plugconf_h
      /copy plugmri_h
      /copy plugxml_h
      /copy plugpase_h
      /copy plugile_h
      /copy plugerr_h
      /copy plugipc_h
      /copy plugcach_h
      /copy plugsql_h
      /copy plugperf_h
      /copy plugbug_h
      /copy pluglic_h
      /copy plugconv_h

      *****************************************************
      * global vars
      *****************************************************
     D sInOrgP         s               *   inz(*NULL)
     D sInSize         s             10i 0 inz(0)

     D sOutOrgP        s               *   inz(*NULL)
     D sOutSize        s             10i 0 inz(0)
     D sOutPtr         s               *   inz(*NULL)

     D sHint           s             60A   inz(*BLANKS)

     D sCache          s              1N   inz(*OFF)

     D sHeader         s           2048A   inz(*BLANKS)
     D scacElemKey     s             10i 0 inz(0)

      *****************************************************
      * global scan vars 
      *****************************************************
      * '<![CDATA[' and ends with ']]>'
     D wCDATA1         S              9C   Inz(%UCS2('<![CDATA[')) 
     D wCDATA2         S              3C   Inz(%UCS2(']]>')) 
     D s1CDATA37       S              9A   inz('<![CDATA[') 
     D s2CDATA37       S              3A   inz(']]>') 

     D sAllCDATA       s              1N   inz(*ON)
     D sOneCDATA       s              1N   inz(*ON)

     D sUCDATA1        S              9A   inz(*BLANKS) 
     D sUCDATA2        S              3A   inz(*BLANKS) 

     D sESCP           S              1N   inz(*OFF)                            

      *****************************************************
      * xml misc
      *****************************************************
     D xmlSetHint      PR
     D  aElemTop1                      *   value
     D  aElemEnd2                      *   value
     D  ooHelp                       60A   options(*nopass)
     D  o                            10i 0 value options(*nopass)
     D  oMax                         10i 0 value options(*nopass)
     D  oOff                         10i 0 value options(*nopass)

     D xmlCpyErr       PR
     D   rc                           1N
     D   o                           10i 0 value
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D  node                               likeds(xmlNode_t) 

     D xmlJobLog       PR             1N
     D   jobName                     10A   value
     D   jobUserID                   10A   value
     D   jobNbr                       6A   value
     D   cntCPF                      10i 0
     D   myCPF                        7A   dim(CPFSMAX)
     D   myTime                      25A   dim(CPFSMAX)
     D   myHint                     128A   dim(CPFSMAX)
     D   myData                   32000A

     D xmlOutRet       PR
     D  isStop                        1N   value
     D  isOk                          1N   value
     D  isCDATA                       1N   value
     D  str                            *   value
     D  stzLen                       10i 0 value
     D  doJobLog                      1N   value options(*nopass)


     D XML_BAT_SET     c                   const('S')
     D XML_BAT_SMALL   c                   const('A')
     D XML_BAT_DEAD    c                   const('D')
     D XML_BAT_FULL    c                   const('F')

     D xmlBatRpt       PR
     D   op                           1A   value
     D   nbr                         10i 0 value
     D   full                         1N   value options(*nopass)


      *****************************************************
      * xml node parsing
      *****************************************************
     D xmlRESET        PR
     D   node                              likeds(xmlNode_t) 


      *****************************************************
      * xml pgm node parsing
      *****************************************************
     D xmlWrkVal       PR             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D  addHex                        1N   value
     D  rmvCDATA                      1N   value
     D  outData                        *   value
     D  modeHexFnd                    1N
     D  ccsidFndB                     1N
     D  ccsidFndA                     1N
     d  srcLen                       10i 0
     d  outLen                       10i 0

     D xmlWrkData      PR             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlWrkDS        PR             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlWrkParm      PR             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlWrkOver      PR             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 


     D xmlWrkRec       PR             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlPooPRec      PR             1N
     D   string1                       *
     D   string2                       *
     D   string3                       *
     D   pCopy                         *
     D   index                       10i 0
     D   j                           10i 0
     D   k                           10i 0
     D   xmllen                      10i 0
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlWrkRet       PR             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlDoPgm        PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value

      *****************************************************
      * xml cmd node parsing
      *****************************************************
     D xmlDoCmd        PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value

      *****************************************************
      * xml sh node parsing
      *****************************************************
     D xmlDoSh         PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value

      *****************************************************
      * xml qsh node parsing
      *****************************************************
     D xmlDoQsh        PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value

      *****************************************************
      * xml diag node parsing
      *****************************************************
     D XML_DIAG_JOBLOG...
     D                 c                   const('J')
     D XML_DIAG_FAST...
     D                 c                   const('F')
     D XML_DIAG_CONF...
     D                 c                   const('C')

     D xmlDoDiag       PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value

      *****************************************************
      * xml sql node parsing
      *****************************************************
     D xmlSqlLab       PR
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  op                            1A   value
     D  myConn                       10A   value
     D  myStmt                       10A   value
     D  isConn                        1N
     D  isStmt                        1N


     D xmlSqlParm      PR             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
     D   stmt                        10A
     D   sqlCode                     10I 0
     D   colNbr                      10i 0
     D   sqlParm                           likeds(hBind_t)

     D xmlSqlOpts      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlConn      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlQry       PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlFtch      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlRCnt      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlLsId      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlDesc      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlCDesc     PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlPrep      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlExec      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlComm      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlFree      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlTabl      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlTabP      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlCols      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlColP      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlSpec      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlProc      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlPCol      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlPKey      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlFKey      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlSqlStat      PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 

     D xmlDoSql        PR             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value

      *****************************************************
      * xml set global
      * return (NA)
      *****************************************************
     P xmlStatic       B                   export
     D xmlStatic       PI
     D   aCtlP                         *   value
      * vars
     d i               s             10i 0
     d rc              s              1N   inz(*ON)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free

       perfAdd(PERF_ANY_WATCH_XMLSTATIC:*ON);

       sHint = *BLANKS;

       bCtlP = aCtlP;      // actual user buffer

       sInOrgP   = bCtl.ipcIClobP;
       sOutOrgP  = bCtl.ipcOClobP;
       sInSize   = bCtl.ipcIClobSz;
       sOutSize  = bCtl.ipcOClobSz;
       sAllCDATA = bCtl.ipcFlags.doCDATA;
       sOneCDATA = *OFF;

       sESCP     = bCtl.ipcFlags.doESCP;   
       // --------------
       // start output
       sOutPtr = sOutOrgP;

       // set default header
       xmlSetHead(sInOrgP:sInSize);

       perfAdd(PERF_ANY_WATCH_XMLSTATIC:*OFF);

      /end-free
     P                 E


      *****************************************************
      * xml output control
      *****************************************************
     P xmlOutReset     B                   export
     D xmlOutReset     PI
      * vars
     d rc              s              1N   inz(*ON)
      /free
       // --------------
       // back at top
       sOutPtr = sOutOrgP;
      /end-free
     P                 E

     P xmlOutUsed      B                   export
     D xmlOutUsed      PI            10i 0
      * vars
     d rc              s              1N   inz(*ON)
      /free
       // --------------
       // total space used
       return (sOutPtr - sOutOrgP);
      /end-free
     P                 E

     P xmlOutRoom      B                   export
     D xmlOutRoom      PI            10i 0
      * vars
     d rc              s              1N   inz(*ON)
      /free
       // --------------
       // how much space remains
       return sOutSize - (sOutPtr - sOutOrgP);
      /end-free
     P                 E

      *****************************************************
      * global batch slots
      *****************************************************
     P xmlBatAny       B                   export
     D xmlBatAny       PI            10i 0
      * vars
     D nbr             s             10i 0 inz(0)
     D index           s             10i 0 inz(0)
     D aCtl            DS                  likeds(ipcRec_t)
      /free
       // any batch xml to be run???
       index = cacScanBat(CAC_BAT_XML_GO
                         :aCtl.ipcIClobP:aCtl.ipcIClobSz
                         :aCtl.ipcOClobP:aCtl.ipcOClobSz);
       return index;
      /end-free
     P                 E

     P xmlBatCopy      B                   export
     D xmlBatCopy      PI             1N
     D   runMemP                       *   value
      * vars
     D nbr             s             10i 0 inz(0)
     D index           s             10i 0 inz(0)
     D aCtl            DS                  likeds(ipcRec_t)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       bCtlP = runMemP;  // actual user buffer

       // copy in
       // find available batch slot big enough or unused?
       aCtl.ipcIClobP  = bCtl.ipcIClobP;
       aCtl.ipcIClobSz = bCtl.ipcIClobSz;
       aCtl.ipcOClobP  = bCtl.ipcOClobP;
       aCtl.ipcOClobSz = bCtl.ipcOClobSz;
       index = cacScanBat(CAC_BAT_ADD_INPUT
                         :aCtl.ipcIClobP:aCtl.ipcIClobSz
                         :aCtl.ipcOClobP:aCtl.ipcOClobSz);

       // special flags
       bCtl.ipcFlags.doBatNbr = index;

       // full - all slots taken (or alloc failed)
       if index = 0;
         xmlBatRpt(XML_BAT_FULL:index:*ON);
         return *OFF;
       endif;

       // return XML report with slot used
       xmlBatRpt(XML_BAT_SET:index:*ON);

       return *ON;
      /end-free
     P                 E

     P xmlBatXML       B                   export
     D xmlBatXML       PI             1N
     D   runMemP                       *
      * vars
     D nbr             s             10i 0 inz(0)
     D index           s             10i 0 inz(0)
     D aCtl            DS                  likeds(ipcRec_t)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       bCtlP = runMemP; // actual user buffer

       // special flags
       nbr = bCtl.ipcFlags.doBatNbr;

       // find XML ready to run?
       index = cacScanBat(CAC_BAT_XML_RUN
                         :aCtl.ipcIClobP:aCtl.ipcIClobSz
                         :aCtl.ipcOClobP:aCtl.ipcOClobSz
                         :nbr);
       // bad slot index
       if index = 0;
         return *OFF;
       endif;

       // copy out buffer locations
       bCtl.ipcIClobP  = aCtl.ipcIClobP;
       bCtl.ipcIClobSz = aCtl.ipcIClobSz;
       bCtl.ipcOClobP  = aCtl.ipcOClobP;
       bCtl.ipcOClobSz = aCtl.ipcOClobSz;

       return *ON;
      /end-free
     P                 E

     P xmlBatDone      B                   export
     D xmlBatDone      PI
     D   runMemP                       *   value
      * vars
     D nbr             s             10i 0 inz(0)
     D index           s             10i 0 inz(0)
     D aCtl            DS                  likeds(ipcRec_t)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       bCtlP = runMemP;  // actual user buffer

       // special flags
       nbr = bCtl.ipcFlags.doBatNbr;

       // batch xml complete, set actual size
       aCtl.ipcOClobSz = xmlOutUsed();
       index = cacScanBat(CAC_BAT_XML_SIZE
                         :aCtl.ipcIClobP:aCtl.ipcIClobSz
                         :aCtl.ipcOClobP:aCtl.ipcOClobSz
                         :nbr);
      /end-free
     P                 E

     P xmlBatGet       B                   export
     D xmlBatGet       PI             1N
     D   runMemP                       *   value
      * vars
     D nbr             s             10i 0 inz(0)
     D index           s             10i 0 inz(0)
     D aCtl            DS                  likeds(ipcRec_t)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       bCtlP = runMemP;      // actual user buffer

       // special flags
       nbr = bCtl.ipcFlags.doBatNbr;

       // find any output?
       if nbr <= 0;
         index = cacScanBat(CAC_BAT_GET_OUTPUT
                         :aCtl.ipcIClobP:aCtl.ipcIClobSz
                         :aCtl.ipcOClobP:aCtl.ipcOClobSz);
         nbr = index;
       // find output at this index?
       else;
         index = cacScanBat(CAC_BAT_GET_OUTPUT
                         :aCtl.ipcIClobP:aCtl.ipcIClobSz
                         :aCtl.ipcOClobP:aCtl.ipcOClobSz
                         :nbr);
       endif;

       // no output found
       if index = 0;
         xmlBatRpt(XML_BAT_DEAD:nbr:*ON);
         return *OFF;
       endif;

       // check user buffer large enough
       if aCtl.ipcOClobSz > bCtl.ipcOClobSz;
         // set buffer back to waiting
         index = cacScanBat(CAC_BAT_GET_AGAIN
                         :aCtl.ipcIClobP:aCtl.ipcIClobSz
                         :aCtl.ipcOClobP:aCtl.ipcOClobSz
                         :nbr);
         xmlBatRpt(XML_BAT_SMALL:nbr:*ON);
         return *OFF;
       endif;

       // copy out
       // mark complete (user retrieved)
       aCtl.ipcIClobP  = bCtl.ipcIClobP;
       aCtl.ipcIClobSz = bCtl.ipcIClobSz;
       aCtl.ipcOClobP  = bCtl.ipcOClobP;
       aCtl.ipcOClobSz = bCtl.ipcOClobSz;
       index = cacScanBat(CAC_BAT_GET_WRITE
                       :aCtl.ipcIClobP:aCtl.ipcIClobSz
                       :aCtl.ipcOClobP:aCtl.ipcOClobSz
                       :nbr);
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * xml body
      * return (na)
      *****************************************************
     P xmlSetCDATA     B                   export
     D xmlSetCDATA     PI
     D   setCDATA                     1N   value
      /free
       if sAllCDATA = *ON;
         sOneCDATA = *ON;
       else;
         sOneCDATA = setCDATA;
       endif;
      /end-free
     P                 E

     P xmlGetCDATA     B                   export
     D xmlGetCDATA     PI             1N
      /free
       if sAllCDATA = *ON;
         return *ON;
       endif;
       return sOneCDATA;
      /end-free
     P                 E

     P xmlcCDATA1      B                   export
     D xmlcCDATA1      PI             9A
      /free
       if sUCDATA1 = *BLANKS;
         sUCDATA1 = %char(wCDATA1); // USC2 convert job ccsid (1.6.7)
       endif;
       return sUCDATA1;
      /end-free
     P                 E

     P xmlcCDATA2      B                   export
     D xmlcCDATA2      PI             3A
      /free
       if sUCDATA2 = *BLANKS;
         sUCDATA2 = %char(wCDATA2); // USC2 convert job ccsid (1.6.7)
       endif;
       return sUCDATA2;
      /end-free
     P                 E

     P xmlGetESCP      B                   export
     D xmlGetESCP      PI             1N
      /free
       return sESCP;
      /end-free
     P                 E
     P xmlSidCDATA     B                   export
     D xmlSidCDATA     PI
     D  toCCSID                      10i 0 value
      * vars
     D rc              s             10i 0 inz(0)
     D m1CDATA37       s              9A   inz(*BLANKS)
     D m2CDATA37       s             10A   inz(*BLANKS)
     D buffPtr         s               *   inz(*NULL)
     D buffLen         s             10i 0 inz(0)
     D outPtr          s               *   inz(*NULL)
     D outLen          s             10i 0 inz(0)
      /free
       sUCDATA1 = *BLANKS;
       m1CDATA37 = s1CDATA37;
       buffPtr = %addr(m1CDATA37);
       buffLen = %size(m1CDATA37);
       outPtr = %addr(sUCDATA1);
       outLen = %size(sUCDATA1);
       rc = convCCSID(37:toCCSID:buffPtr:buffLen:outPtr:outLen);
       sUCDATA2 = *BLANKS;
       m2CDATA37 = s2CDATA37;
       buffPtr = %addr(m2CDATA37);
       buffLen = %size(m2CDATA37);
       outPtr = %addr(sUCDATA2);
       outLen = %size(sUCDATA2);
       rc = convCCSID(37:toCCSID:buffPtr:buffLen:outPtr:outLen);
      /end-free
     P                 E

     P xmlResetCDATA...
     P                 B                   export
     D xmlResetCDATA...
     D                 PI
      /free
       sUCDATA1 = *BLANKS;
       sUCDATA2 = *BLANKS;
      /end-free
     P                 E

      *****************************************************
      * xml body
      * return (na)
      *****************************************************
     P xmlOutRet       B
     D xmlOutRet       PI
     D  isStop                        1N   value
     D  isOk                          1N   value
     D  isCDATA                       1N   value
     D  str                            *   value
     D  stzLen                       10i 0 value
     D  doJobLog                      1N   value options(*nopass)
      * vars
     D rc              s              1N   inz(*OFF)
     D report          S          65000A   inz(*BLANKS)
     D myOk1           s              9A   inz('<success>')
     D myOk2           s             10A   inz('</success>')
     D myBad1          s              7A   inz('<error>')
     D myBad2          s              8A   inz('</error>')
     D mySucc          s             12A   inz(RET_MSG_RUN_SUCCESS)
     D myFail          s             10A   inz(RET_MSG_RUN_ERROR)
     D myRetTxt        s           1024A   inz(*BLANKS)
     D mySTATUS2       S             10i 0 inz(0)
     D myMSGID2        S              7a   inz(*BLANKS)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D retLen          s             10i 0 inz(0)
     D myClrErr        s              1N   inz(*ON)
     D myJobLog        s              1N   inz(*ON)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
      /free
      
       // stop will give full error list
       // HUGE mistake change to isOk =*OFF 
       // not rc = *off (1.7.6)
       if isOk = *OFF and isStop = *ON;
         return;
       endif;

       // CDATA check override
       if isCDATA = *OFF;
         isCDATA = xmlGetCDATA();
       endif;
       cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
       cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)

       if %parms >= 5;
         myJobLog = doJobLog;
       endif;

       // <success or error>
       // oooooooooooooooooo
       if isOk = *ON;
         string = %addr(myOk1);
         stringLen = 9;
         xmlOutput(string:stringLen:*OFF);
       else;
         string = %addr(myBad1);
         stringLen = 7;
         xmlOutput(string:stringLen:*OFF);
       endif;

       // <![CDATA[
       // ooooooooo
       if isCDATA = *ON;
         string = %addr(cCDATA1);
         stringLen = 9;
         xmlOutput(string:stringLen:*OFF);
       endif;

       // <success or error>+++ success
       // <success or error>*** error
       //                   oooooooooooo
       if isOk = *ON;
         string = %addr(mySucc);
         stringLen = 12;
         xmlOutput(string:stringLen:*OFF);
       else;
         string = %addr(myFail);
         stringLen = 10;
         xmlOutput(string:stringLen:*OFF);
       endif;

       // selected output data (hint)
       // <success or error>+++ success my hint passed
       // <success or error>*** error
       //                               oooooooooooooo
       if stzLen > 0;
         xmlOutput(str:stzLen:*OFF);
       endif;

       // ]]>
       // ooo
       if isCDATA = *ON;
         string = %addr(cCDATA2);
         stringLen = 3;
         xmlOutput(string:stringLen:*OFF);
       endif;

       // xml end
       // </success or /error>
       // oooooooooooooooooo
       if isOk = *ON;
         string = %addr(myOk2);
         stringLen = 10;
         xmlOutput(string:stringLen:*ON);
       else;
         string = %addr(myBad2);
         stringLen = 8;
         xmlOutput(string:stringLen:*ON);
       endif;

       // Alan request always get diag joblog on <error> (1.6.2)
       // ... not sure this is a good idea dude (ADC) 
       if isOk = *OFF;
         // compatibility (1.6.7)
         // <error>n</error>
         // oooooooooooooooo
         mySTATUS2 = ileStatus2();
         if mySTATUS2 <> 0;
           report = myBad1
                  + %char(mySTATUS2)
                  + myBad2;
           string = %addr(report);
           stringLen = %len(%trim(report));
           xmlOutput(string:stringLen:*ON);
         endif;
         // compatibility (1.6.7)
         // <error>CPFxxxx</error>
         // oooooooooooooooo
         myMSGID2 = ileMsgId2();
         if myMSGID2 <> *BLANKS;
           report = myBad1 
                  + %trim(myMSGID2)
                  + myBad2;
           string = %addr(report);
           stringLen = %len(%trim(report));
           xmlOutput(string:stringLen:*ON);
         endif;
         // job log (always call, but joblog off is fast)
         rc = xmlError(*OFF:myJobLog);
       endif;
      /end-free
     P                 E

      *****************************************************
      * xml body
      * return (na)
      *****************************************************
     P xmlSetHint      B
     D xmlSetHint      PI
     D  aElemTop1                      *   value
     D  aElemEnd2                      *   value
     D  ooHelp                       60A   options(*nopass)
     D  o                            10i 0 value options(*nopass)
     D  oMax                         10i 0 value options(*nopass)
     D  oOff                         10i 0 value options(*nopass)
      * vars
     D ooHint          s            512A   inz(*BLANKS)
     D poHint          s               *   inz(*NULL)
     D ooLen           s             10i 0 inz(-1)
     D oo              s             10i 0 inz(-1)
     D ooMax           s             10i 0 inz(-1)
     D ooOff           s             10i 0 inz(-1)
      /free
       if %parms >= 4;
         oo = o;
       endif;
       if %parms >= 5;
         ooMax = oMax;
       endif;
       if %parms >= 6;
         ooOff = oOff;
       endif;
       // element to copy
       if aElemTop1 <> *NULL 
       and aElemEnd2 <> *NULL
       and aElemTop1 < aElemEnd2;
         poHint = %addr(ooHint);
         ooLen = aElemEnd2 - aElemTop1;
         if ooLen > %size(sHint) - 1;
           ooLen = %size(sHint) - 1;
         endif;
         ooHint = %str(aElemTop1:ooLen);
         ooLen = %len(%trim(ooHint));
         if ooLen > 1;
           bigJunkOut(poHint:poHint + ooLen:*ON);
         endif;
         // dim
         if oo > 0 and ooMax > 1;
           ooHint = 'd('+ %char(oo) 
                  + '-' + %char(ooMax) + ') ' 
                  + ooHint;
         endif;
         // offset
         if ooOff > -1;
           ooHint = 'p(' + %char(ooOff) + ') ' 
                  + ooHint;
         endif;
         // save hint
         if %parms >= 3;
           ooHelp = ooHint;
         else;
           sHint = ooHint;
         endif;
       endif;
      /end-free
     P                 E

      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlCpyErr       B
     D xmlCpyErr       PI
     D   rc                           1N
     D   o                           10i 0 value
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D  node                               likeds(xmlNode_t) 
      * vars
     D ooHint          s             60A   inz(*BLANKS)
     D ooOff           s             10i 0 inz(0)
     D ooMax           s             10i 0 inz(0)
     D pHex1           s               *   inz(*NULL)
     D pHex2           s               *   inz(*NULL)
      /free
       if node.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
         rc = *OFF;

         Monitor;
           if aVeryTop <> *NULL 
           and aElemTop1 <> *NULL
           and aVeryTop < aElemTop1;
             ooOff = aElemTop1 - aVeryTop;
           endif; 
         On-error;
         Endmon;

         // max dim
         ooMax = node.xmlOccurs;
         pHex1 = %addr(node.pgmValHex);
         pHex2 = pHex1 + %size(node.pgmValHex);

         if op = 'I';

           if aElemTop1 <> *NULL 
           and aElemTop2 <> *NULL
           and aElemTop2 > aElemTop1 + 1;
             xmlSetHint(aElemTop1:aElemTop2:ooHint:o:ooMax:ooOff);
           endif;
           errsSevere(XML_ERROR_COPYIN_EXCEPTION:ooHint);

           if aDataVal1 <> *NULL 
           and aDataVal2 <> *NULL
           and aDataVal2 > aDataVal1 + 1;
             xmlSetHint(aDataVal1:aDataVal2+1:ooHint:o:ooMax:ooOff);
             errsSevere(XML_ERROR_COPYIN_DATA:ooHint);
           endif;

           if node.pgmValHex <> *BLANKS;
             xmlSetHint(pHex1:pHex2:ooHint:o:ooMax:ooOff);
             errsSevere(XML_ERROR_COPYIN_DATA:ooHint);
           endif;

         elseif op = 'O';

           if aElemTop1 <> *NULL 
           and aElemTop2 <> *NULL
           and aElemTop2 > aElemTop1 + 1;
             xmlSetHint(aElemTop1:aElemTop2:ooHint:o:ooMax:ooOff);
           endif;
           errsSevere(XML_ERROR_COPYOUT_EXCEPTION:ooHint);

           if node.pgmValHex <> *BLANKS;
             xmlSetHint(pHex1:pHex2:ooHint:o:ooMax:ooOff);
             errsSevere(XML_ERROR_COPYOUT_DATA:ooHint);
           endif;


         elseif op = 'Z';

           if aElemTop1 <> *NULL 
           and aElemTop2 <> *NULL
           and aElemTop2 > aElemTop1 + 1;
             xmlSetHint(aElemTop1:aElemTop2:ooHint:o:ooMax:ooOff);
           endif;
           errsSevere(XML_ERROR_RUN_FAIL:ooHint);

         endif;



       endif;
      /end-free
     P                 E


      *****************************************************
      * xml node ctor
      * return (NA)
      *****************************************************
     P xmlCTOR         B                   export
     D xmlCTOR         PI
     D   node                              likeds(xmlNode_t) 
      /free

       // value attributes
       node.xmlAttr         = XML_ATTR_VAL_NADA;
       node.xmlVary         = XML_VARY_OFF;
       node.xmlTrim         = XML_ATTR_TRIM_DEFAULT;
       node.xmlIsHex        = XML_ATTR_HEX_FALSE;
       node.xmlDigits       = 0;
       node.xmlFrac         = 0;
       node.xmlIsCDATA      = XML_ATTR_CDATA_FALSE;
       // value ccsid attributes
       node.xmlbCCSID1      = 0;
       node.xmlbCCSID2      = 0;
       node.xmlbCCSID3      = 0;
       node.xmlbCCSID4      = 0;
       node.xmlaCCSID1      = 0;
       node.xmlaCCSID2      = 0;
       node.xmlaCCSID3      = 0;
       node.xmlaCCSID4      = 0;

       node.xmlIO           = XML_IO_BOTH;     // parent parm
       node.xmlBy           = XML_BY_REF;      // parent parm
       node.xmlPrmRet       = XML_IS_PARM;     // parent parm
       node.xmlCallAs       = XML_FUNC_PGM;    // parent parm
       node.pgmPtrTyp       = XML_PTR_NADA;    // ile set
       node.pgmValErr       = XML_PGM_ERROR_FALSE; // ile set
       node.pgmValHex       = *BLANKS;             // ile set
       node.pgmArgTop       = XML_PGM_TOP_FALSE; // parent parm
       node.pgmOPMMem       = XML_PGM_OPM_FALSE; // parent parm

       // dim
       node.xmlOccurs       = 0;

       // cache used
       node.cacElemCnt      = 0;
       node.cacElemTop1     = 0;

       // ile push/pop
       node.pgmTruOff       = 0;
       node.cacTruLen       = 0;
       node.xmlStrP         = *NULL;
       node.xmlStrSz        = 0;
       node.pgmSigPo        = 0;
       node.pgmSigSz        = 0;
       node.pgmArgPo        = 0;
       node.pgmArgSz        = 0;
       node.pgmValPo        = 0;
       node.pgmValSz        = 0;
       node.pgmRetPo        = 0;
       node.pgmRetSz        = 0;

       // cache attributes
       node.pgmIndex        = 0;

       // dou
       node.cacDouDim       = 0;
       node.cacDouEnd       = 0;

       // setlen
       node.cacLenOne       = 0;
       node.cacLenSet       = 0;
       node.cacLenBeg       = 0;
       node.cacLenOff1      = 0;
       node.cacLenOff2      = 0;

       // omit
       node.xmlIsOmit       = XML_PARM_OMIT_FALSE;

       // overlay
       node.xmlIsTop        = XML_OVR_TOP_FALSE;
       node.xmlTopNbr       = 0;
       node.cacOffOvr       = 0;
       node.cacOffEnd       = 0;
       node.xmlOffNbr       = 0;
       node.cacNxtOvr       = 0;
       node.cacNxtOff       = 0;
       
       // <records>
       node.cacIsRec        = XML_IS_RECORDS_FALSE;
       node.cacIsRecT       = XML_IS_RECORDS_FALSE;
       node.cacIsRecD       = XML_IS_RECORDS_FALSE;

      /end-free
     P                 E

      *****************************************************
      * xml node copy
      * return (NA)
      *****************************************************
     P xmlCOPY         B                   export
     D xmlCOPY         PI
     D   node                              likeds(xmlNode_t) 
     D   node2                             likeds(xmlNode_t) 
      /free

       // value attributes
       node.xmlAttr         = node2.xmlAttr;
       node.xmlVary         = node2.xmlVary;
       node.xmlTrim         = node2.xmlTrim;
       node.xmlIsHex        = node2.xmlIsHex;
       node.xmlDigits       = node2.xmlDigits;
       node.xmlFrac         = node2.xmlFrac;
       node.xmlIsCDATA      = node2.xmlIsCDATA;
       // value ccsid attributes
       node.xmlbCCSID1      = node2.xmlbCCSID1;
       node.xmlbCCSID2      = node2.xmlbCCSID2;
       node.xmlbCCSID3      = node2.xmlbCCSID3;
       node.xmlbCCSID4      = node2.xmlbCCSID4;
       node.xmlaCCSID1      = node2.xmlaCCSID1;
       node.xmlaCCSID2      = node2.xmlaCCSID2;
       node.xmlaCCSID3      = node2.xmlaCCSID3;
       node.xmlaCCSID4      = node2.xmlaCCSID4;

       node.xmlIO           = node2.xmlIO;     // parent parm
       node.xmlBy           = node2.xmlBy;     // parent parm
       node.xmlPrmRet       = node2.xmlPrmRet; // parent parm
       node.xmlCallAs       = node2.xmlCallAs; // parent parm
       node.pgmPtrTyp       = node2.pgmPtrTyp; // ile set
       node.pgmValErr       = node2.pgmValErr; // ile set
       node.pgmValHex       = node2.pgmValHex; // ile set
       node.pgmArgTop       = node2.pgmArgTop; // parent parm
       node.pgmOPMMem       = node2.pgmOPMMem; // parent parm

       if xmlGetCDATA() = *ON;
         node.xmlIsCDATA    = XML_ATTR_CDATA_TRUE;
       endif;

       // dim
       node.xmlOccurs       = node2.xmlOccurs;

       // cache used
       node.cacElemCnt      = node2.cacElemCnt;
       node.cacElemTop1     = node2.cacElemTop1;

       // ile push/pop
       node.pgmTruOff       = node2.pgmTruOff;
       node.cacTruLen       = node2.cacTruLen;
       node.xmlStrP         = node2.xmlStrP;
       node.xmlStrSz        = node2.xmlStrSz;
       node.pgmSigPo        = node2.pgmSigPo;
       node.pgmSigSz        = node2.pgmSigSz;
       node.pgmArgPo        = node2.pgmArgPo;
       node.pgmArgSz        = node2.pgmArgSz;
       node.pgmValPo        = node2.pgmValPo;
       node.pgmValSz        = node2.pgmValSz;
       node.pgmRetPo        = node2.pgmRetPo;
       node.pgmRetSz        = node2.pgmRetSz;

       // cache attributes
       node.pgmIndex        = node2.pgmIndex;

       // dou
       node.cacDouDim       = node2.cacDouDim;
       node.cacDouEnd       = node2.cacDouEnd;

       // setlen
       node.cacLenOne       = node2.cacLenOne;
       node.cacLenSet       = node2.cacLenSet;
       node.cacLenBeg       = node2.cacLenBeg;
       node.cacLenOff1      = node2.cacLenOff1;
       node.cacLenOff2      = node2.cacLenOff2;

       // omit
       node.xmlIsOmit       = node2.xmlIsOmit;

       // overlay
       node.xmlIsTop        = node2.xmlIsTop;
       node.xmlTopNbr       = node2.xmlTopNbr;
       node.cacOffOvr       = node2.cacOffOvr;
       node.cacOffEnd       = node2.cacOffEnd;
       node.xmlOffNbr       = node2.xmlOffNbr;
       node.cacNxtOvr       = node2.cacNxtOvr;
       node.cacNxtOff       = node2.cacNxtOff;
       
       // <records>
       node.cacIsRec        = node2.cacIsRec;
       node.cacIsRecT       = node2.cacIsRecT;
       node.cacIsRecD       = node2.cacIsRecD;

      /end-free
     P                 E

      *****************************************************
      * xml node reset
      * return (NA)
      *****************************************************
     P xmlRESET        B
     D xmlRESET        PI
     D   node                              likeds(xmlNode_t) 
      /free
       // value attributes
       node.xmlAttr         = *BLANKS;
       node.xmlVary         = XML_VARY_OFF;
       node.xmlTrim         = XML_ATTR_TRIM_DEFAULT;
       node.xmlIsHex        = XML_ATTR_HEX_FALSE;
       node.xmlDigits       = 0;
       node.xmlFrac         = 0;

       // value ccsid attributes
       node.xmlbCCSID1      = 0;
       node.xmlbCCSID2      = 0;
       node.xmlbCCSID3      = 0;
       node.xmlbCCSID4      = 0;
       node.xmlaCCSID1      = 0;
       node.xmlaCCSID2      = 0;
       node.xmlaCCSID3      = 0;
       node.xmlaCCSID4      = 0;

       // dim
       node.xmlOccurs       = 0;

       // cache used
       node.cacElemCnt      = 0;
       node.cacElemTop1     = 0;

       // dou
       node.cacDouDim       = 0;
       node.cacDouEnd       = 0;

       // setlen
       node.cacLenOne       = 0;
       node.cacLenSet       = 0;
       node.cacLenBeg       = 0;
       node.cacLenOff1      = 0;
       node.cacLenOff2      = 0;

       // overlay
       node.cacOffOvr       = 0;
       node.cacOffEnd       = 0;
       node.xmlOffNbr       = 0;

      /end-free
     P                 E

      *****************************************************
      * xml output
      * return (NA)
      *****************************************************
     P xmlOutput       B                   export
     D xmlOutput       PI
     D   string                        *   value
     D   stringLen                   10i 0 value
     D   addLF                        1N   value
     D   subSlash                     1N   value options(*nopass)
      * vars
     D pCopy           s               *
     D myCopy          ds                  likeds(over_t) based(pCopy)
      /free
       cpybytes(sOutPtr:string:stringLen);
       // ...\>
       // -to-
       // ...>
       if %parms >= 4 and subSlash = *ON;
         pCopy = sOutPtr + stringLen - 2;
         myCopy.bytex = '>';
         sOutPtr += (stringLen - 1);
       else;
         sOutPtr += stringLen;
       endif;

       if addLF = *ON;
         pCopy = sOutPtr;
         myCopy.bytex = x'25';
         sOutPtr += 1;
       endif;

      /end-free
     P                 E

      *****************************************************
      * xml dump
      * return (NA)
      *****************************************************
     P xmlDump         B                   export
     D xmlDump         PI
     D   msg                         15A   value
     D   pTop                          *   value
     D   pBot                          *   value
     D   isHex                        1N   value
      * vars
     D ooLen           s             10i 0 inz(0)
     D report          S          32000A   inz(*BLANKS)
     D buff            S             32A   inz(*BLANKS)
     D buffn           S             67A   inz(*BLANKS)
     D pCopy           s               *
     D myCopy          ds                  likeds(over_t) based(pCopy)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
      /free
       if pTop = *NULL 
       or pBot = *NULL
       or pTop >= pBot;
         return;
       endif; 

       cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
       cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)

       pCopy = sOutPtr - 1;
       if myCopy.bytex <> x'25';
         report = %trim(report) + x'25';
       endif;

       report = %trim(report) + '<dump>' + cCDATA1;

       report = %trim(report) + msg + '-->';

       // more ... 32 characters
       ooLen = pBot - pTop;
       if (ooLen > %size(myCopy.ubufx));
         pCopy = pTop;
         buff = %trim(myCopy.ubufx);
         bigJunkOut(%addr(buff):%addr(buff)+%size(buff):*ON:*ON);
         report = %trim(report) + buff + '...';
         pCopy = (pBot + 1) - %size(myCopy.ubufx);
         buff = %trim(myCopy.ubufx);
         bigJunkOut(%addr(buff):%addr(buff)+%size(buff):*ON:*ON);
         report = %trim(report) + buff + '<--';
       // up to 32 characters
       else;
         buffn = %trim(%str(pTop:ooLen + 1));
         bigJunkOut(%addr(buffn):%addr(buffn)+%size(buffn):*ON:*ON);
         report = %trim(report) + buffn + '<--';
       endif;

       report = %trim(report) + cCDATA2 + '</dump>';

       // <dump>data...data</dump>
       // oooooooooooooooooooooooo
       string = %addr(report);
       stringLen = %len(%trim(report));
       xmlOutput(string:stringLen:*ON);

      /end-free
     P                 E


      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlWrkVal       B
     D xmlWrkVal       PI             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D  addHex                        1N   value
     D  rmvCDATA                      1N   value
     D  outData                        *   value
     D  modeHexFnd                    1N
     D  ccsidFndB                     1N
     D  ccsidFndA                     1N
     d  srcLen                       10i 0
     d  outLen                       10i 0
      * vars
     D myNode          ds                  likeds(xmlNode_t) 
     D ooHint          s             60A   inz(*BLANKS)
     D rc1             s             10i 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D rc9             s              1N   inz(*ON)
     D addCDATA        s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D trimSz          s             10i 0 inz(0)
     D trimSz9         s             10i 0 inz(0)
     D tmpLen          s             10i 0 inz(0)
     D tmpLen2         s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D j               s             10i 0 inz(0)
     D iloop           s             10i 0 inz(0)
     D waszero         s              1A   inz(x'00')
     D toblk           s              1A   inz(x'40')
     D outData9        s               *   inz(*NULL)
      * nbr conversion (ccsid)
     d tmpNbr          s             32A   inz(*BLANKS)
     D tmpCtl          s           1032A   inz(*BLANKS)
     D tmpCtl2         s           1032A   inz(*BLANKS)
     D doNbr           s             10i 0 dim(XMLMAXATTR) inz(-1)
     D doChar          s             64A   dim(XMLMAXATTR) inz(*BLANKS)
      * ccsid convert
     D convRc          s             10i 0 inz(0)
     D convPad         s             10i 0 inz(0)
     D convX40         s             10i 0 inz(64)
     D convHex         s              1N   inz(*OFF)
     D convVary        s              1A   inz(XML_VARY_OFF)
     D cntCCSID        s             10i 0 inz(0)
     D srcCCSID        s             10i 0 dim(XMLMAXATTR) inz(0)
     D tgtCCSID        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * search elements
     D keyElem         s             10i 0 inz(-1)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * search elements
     D akeyElem        s             10i 0 inz(-1)
     D afindElem       s             10i 0 inz(-1)
     D apTop           s               *   inz(*NULL)
     D apLst           s               *   inz(*NULL)
     D aelem           s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D adoNest         s              1N   dim(XMLMAXATTR) inz(*OFF)
     D adoNada         s              1N   inz(*OFF)
     D adoCDATA        s              1N   inz(*OFF)
     D apB1            s               *   inz(*NULL)
     D apB2            s               *   inz(*NULL)
     D apD1            s               *   inz(*NULL)
     D apD2            s               *   inz(*NULL)
     D apE1            s               *   inz(*NULL)
     D apE2            s               *   inz(*NULL)
     D apNxt           s               *   inz(*NULL)
      /free
      
       // default answer
       srcLen     = 0;
       modeHexFnd = *OFF;
       ccsidFndB  = *OFF;
       ccsidFndA  = *OFF;
      
       // node CTOR
       xmlCTOR(myNode);
       if xmlGetCDATA() = *ON or isCDATA = *ON;
         myNode.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
       endif;
       // check fast cache
       if aVeryTop = *NULL;
         i = 0;
       else;
         scacElemKey += 1;
         myNode.cacElemTop1 = aElemTop1- aVeryTop;
         i = cacScanAtt(myNode);
       endif;
       // slow way
       if i = 0;
         // <xxxxx before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1' hex='on|off']>
         // -- or --
         // <xxxxx before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1' hex='on|off']>
         //        1                        2                       3
         search(1) = 'before';
         search(2) = 'after';
         search(3) = 'hex';
         rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
         if rc = *ON;
           if valueLen(1) <> 0; // before='CCSIDFrom/CCSIDTo'
             tmpCtl = 'before(' + %trim(%str(pValue(1):valueLen(1))) + ')';
             rc     = bigDimOpt('before':tmpCtl:doChar:doNbr);
             for j = 1 to 4;
               if doNbr(j) > -42;
                 if j = 1;
                   myNode.xmlbCCSID1 = doNbr(j);
                 elseif j = 2;
                   myNode.xmlbCCSID2 = doNbr(j);
                 elseif j = 3;
                   myNode.xmlbCCSID3 = doNbr(j);
                 else;
                   myNode.xmlbCCSID4 = doNbr(j);
                 endif;
               endif;
             endfor;
           endif;
           if valueLen(2) <> 0; // after='CCSIDFrom/CCSIDTo'
             tmpCtl = 'after(' + %trim(%str(pValue(2):valueLen(2))) + ')';
             rc     = bigDimOpt('after':tmpCtl:doChar:doNbr);
             for j = 1 to 4;
               if doNbr(j) > -42;
                 if j = 1;
                   myNode.xmlaCCSID1 = doNbr(j);
                 elseif j = 2;
                   myNode.xmlaCCSID2 = doNbr(j);
                 elseif j = 3;
                   myNode.xmlaCCSID3 = doNbr(j);
                 else;
                   myNode.xmlaCCSID4 = doNbr(j);
                 endif;
               endif;
             endfor;
           endif;
           if valueLen(3) <> 0; // hex='on|off'
             if 'on' = %str(pValue(3):2);
               myNode.xmlIsHex = XML_ATTR_HEX_TRUE;
             endif;
           endif;
         endif;
         // save fast cache
         cacAddAtt(myNode);
       endif;

       // <xxxxx  /> (short XML)
       if isNada = *ON; // no data
         rc = *ON;
         return rc;
       endif;
       
       // find hex convert parse?
       if myNode.xmlIsHex = XML_ATTR_HEX_TRUE;
         modeHexFnd = *ON;
         convHex = *ON;
       else;
         addHex = *OFF;
       endif;

       // find conversion CCSID?
       if myNode.xmlbCCSID1 > 0;
         ccsidFndB = *ON;
       endif;
       if myNode.xmlaCCSID1 > 0;
         ccsidFndA = *ON;
       endif;
       select;
       when op = 'I' or op = 'K';
         if myNode.xmlbCCSID1 > 0;
           cntCCSID = 1;
           srcCCSID(1) = myNode.xmlbCCSID1;
           tgtCCSID(1) = myNode.xmlbCCSID2;
           if myNode.xmlbCCSID3 > 0;
             cntCCSID = 2;
             srcCCSID(2) =  tgtCCSID(1);
             tgtCCSID(2) = myNode.xmlbCCSID3;
           endif;
           if myNode.xmlbCCSID4 > 0;
             cntCCSID = 3;
             srcCCSID(3) =  tgtCCSID(2);
             tgtCCSID(3) = myNode.xmlbCCSID4;
           endif;
         endif;
       when op = 'O' or op = 'P';
         if myNode.xmlaCCSID1 > 0;
           cntCCSID = 1;
           srcCCSID(1) = myNode.xmlaCCSID1;
           tgtCCSID(1) = myNode.xmlaCCSID2;
           if myNode.xmlaCCSID3 > 0;
             cntCCSID = 2;
             srcCCSID(2) =  tgtCCSID(1);
             tgtCCSID(2) = myNode.xmlaCCSID3;
           endif;
           if myNode.xmlaCCSID4 > 0;
             cntCCSID = 3;
             srcCCSID(3) =  tgtCCSID(2);
             tgtCCSID(3) = myNode.xmlaCCSID4;
           endif;
         endif;
       other;
       endsl;
       
       // output <row>...</row>??? @ADC (1.7.4)
       trimSz = 0;
       rc = *ON;
       rc9 = *ON;
       if (op = 'O' or op = 'P') and (cntCCSID > 0 or convHex = *ON);
         outData9 = outData;
         pTop = aDataVal1;
         pNxt = aDataVal1;
         pLst = aDataVal2;
         elem(1) = 'row';
         dou pNxt = *NULL 
         or rc = *OFF
         or rc9 = *OFF
         or pNxt >= pLst;
          if myNode.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
            addCDATA = *ON;
          else;
            addCDATA = *OFF;
          endif;
          trimSz9 = 0;
          pTop = pNxt;
          findElem = bigElem(pTop:pLst:elem:doNest
                     :doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
          select;
          // <row ...> ... </row>
          // B        1    2    E
          when findElem = 1;
            if pD1 <> *NULL 
            and pD2 <> *NULL
            and pD2 > pD1;
              if addCDATA = *OFF and doCDATA;
                addCDATA = *ON;
              endif;
              apTop = pD1;
              apNxt = pD1;
              apLst = pD2;
              aelem(1) = 'data';
              afindElem = bigElem(apTop:apLst:aelem:adoNest
                :adoNada:adoCDATA:apB1:apB2:apD1:apD2:apE1:apE2:apNxt);
              // expand attribute section to include both keys
              // <row ...><data ...> ... </data></row>
              // B                 1    2            E
              if afindElem = 1;
                pB2 = apB2;
                pD1 = apD1;
                pD2 = apD2;
                pE1 = apE1;
                if addCDATA = *OFF and adoCDATA = *ON;
                  addCDATA = *ON;
                endif;
              endif;
            endif;
            // convert/copy
            tmpCtl = %str(pB1:pB2 - pB1+1);
            tmpLen = %len(%trim(tmpCtl));
            tmpCtl2 = %str(pE1:pE2 - pE1+1);
            tmpCtl2 = %trim(tmpCtl2) + x'25';
            tmpLen2 = %len(%trim(tmpCtl2));
            if outLen-trimSz-tmpLen-tmpLen2 > tmpLen+tmpLen2;
              cpybytes(outData9:%addr(tmpCtl):tmpLen);
              outData9 += tmpLen;
              trimSz += tmpLen;
            else;
              leave;
            endif;
            if outLen-trimSz-tmpLen2 > tmpLen2 + 8
            and pD1 <> *NULL 
            and pD2 <> *NULL
            and pD2 > pD1;
              string = pD1;
              stringLen = pD2 - pD1 + 1;
              select;
              when op = 'O'; // output trim format
                rc9 = trimChar(outData9:outLen-trimSz-tmpLen2
                    :string:stringLen
                    :trimSz9
                    :convPad:convVary:convHex
                    :cntCCSID:srcCCSID:tgtCCSID
                    :*OFF:*OFF:*OFF:addHex:addCDATA);
              when op= 'P'; // output pad format
                rc9 = fullChar(outData9:outLen-trimSz-tmpLen2
                    :string:stringLen
                    :trimSz9
                    :convX40:convVary:convHex
                    :cntCCSID:srcCCSID:tgtCCSID
                    :*OFF:*OFF:*OFF:addHex:addCDATA);
              other;
              endsl;
            endif;
            trimSz += trimSz9;
            outData9 += trimSz9;
            if outLen-trimSz-tmpLen2 > tmpLen2;
              cpybytes(outData9:%addr(tmpCtl2):tmpLen2);
              outData9 += tmpLen2;
              trimSz += tmpLen2;
            endif;
          when findElem = -1;
            rc = *OFF;
          other;
          endsl;
         enddo;
       endif;
       
       // convert/copy
       if trimSz = 0 and rc9 = *ON;
         addCDATA = bigCDATA(aDataVal1:aDataVal2:pD1:pD2);
         string = pD1;
         stringLen = pD2 - pD1 + 1;
         select;
         when op = 'I'; // input only format
           rc9 = fillChar(outData:outLen
                   :string:stringLen
                   :trimSz
                   :convPad:convVary:convHex
                   :cntCCSID:srcCCSID:tgtCCSID
                   :rmvCDATA:*OFF:*OFF);
         when op = 'K'; // input only format
           rc9 = fillChar(outData:outLen
                   :string:stringLen
                   :trimSz
                   :convX40:convVary:convHex
                   :cntCCSID:srcCCSID:tgtCCSID
                   :rmvCDATA:*OFF:*OFF);
         when op = 'O'; // output trim format
           rc9 = trimChar(outData:outLen
                   :string:stringLen
                   :trimSz
                   :convPad:convVary:convHex
                   :cntCCSID:srcCCSID:tgtCCSID
                   :rmvCDATA:*OFF:*OFF:addHex:addCDATA);
         when op= 'P'; // output pad format
           rc9 = fullChar(outData:outLen
                   :string:stringLen
                   :trimSz
                   :convX40:convVary:convHex
                   :cntCCSID:srcCCSID:tgtCCSID
                   :rmvCDATA:*OFF:*OFF:addHex:addCDATA);
         other;
         endsl;
       endif;
       
       // error conversion?
       if rc9 = *OFF or myNode.pgmValErr = XML_PGM_ERROR_TRUE;
         myNode.pgmValErr = XML_PGM_ERROR_TRUE;
         outLen = 0;
         return *OFF;
       endif;

       outLen = trimSz;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlWrkData      B
     D xmlWrkData      PI             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooHint          s             60A   inz(*BLANKS)
     D myNode          ds                  likeds(xmlNode_t) 
     D ooEndData       s             10A   inz('</data>')
     D rc              s              1N   inz(*ON)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D j               s             10i 0 inz(0)
     D o               s             10i 0 inz(0)
      * nbr conversion (ccsid)
     d tmpNbr          s             32A   inz(*BLANKS)
     D tmpCtl          s           1032A   inz(*BLANKS)
     D doNbr           s             10i 0 dim(XMLMAXATTR) inz(-1)
     D doChar          s             64A   dim(XMLMAXATTR) inz(*BLANKS)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * dup input
     d dupbeg          s               *   inz(*NULL)
     d dupend          s               *   inz(*NULL)
      /free
       // node copy
       xmlCOPY(myNode:node);
       // check fast cache
       scacElemKey += 1;
       myNode.cacElemTop1 = aElemTop1- aVeryTop;
       myNode.cacIsRecT = XML_IS_RECORDS_DATA;
       i = cacScanAtt(myNode);
       // slow way
       if i = 0;
         xmlRESET(myNode);
         myNode.cacElemTop1 = aElemTop1- aVeryTop;

         // <data type="data types" [varying="on|off|2|4" enddo="z" dim="n" 
         //       1                  2                    3         4
         //       setlen="label" offset="label"
         //       5              6
         //       before="CCSIDFrom/CCSIDTo" after="CCSIDFrom/CCSIDTo" hex='on|off'
         //       7                          8                         9
         //       trim="on|off" next='x']>
         //       10            11
         search(1) = 'type';
         search(2) = 'varying';
         search(3) = 'enddo';
         search(4) = 'dim';
         search(5) = 'setlen';
         search(6) = 'offset';
         search(7) = 'before';
         search(8) = 'after';
         search(9) = 'hex';
         search(10) = 'trim';
         search(11) = 'next';
         rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
         if rc = *ON;
           if valueLen(1) <> 0; // type='data types'
             rc = bigValType(pValue(1):valueLen(1):
                             myNode.xmlAttr:myNode.xmlDigits:myNode.xmlFrac);
           endif;
           if valueLen(2) <> 0; // varying='on|off|2|4'
             if 'on' = %str(pValue(2):2) or '2' = %str(pValue(2):1);
               myNode.xmlVary = XML_VARY_ON;
             elseif '4' = %str(pValue(2):1);
               myNode.xmlVary = XML_VARY_4;
             endif;
           endif;
           if valueLen(3) <> 0; // enddo='z'
             myNode.cacDouEnd = cacAddLab(%str(pValue(3):valueLen(3)):myNode);
           endif;
           if valueLen(4) <> 0; // dim='n'
             tmpNbr = %str(pValue(4):valueLen(4));
             myNode.xmlOccurs = %int(tmpNbr);
           endif;
           if valueLen(5) <> 0; // setlen='label'
             myNode.cacLenSet = cacAddLab(%str(pValue(5):valueLen(5)):myNode);
           endif;
           if valueLen(6) <> 0; // offset='label'
             myNode.cacOffEnd = cacAddLab(%str(pValue(6):valueLen(6)):myNode);
           endif;
           if valueLen(7) <> 0; // before='CCSIDFrom/CCSIDTo'
             tmpCtl = 'before(' + %trim(%str(pValue(7):valueLen(7))) + ')';
             rc     = bigDimOpt('before':tmpCtl:doChar:doNbr);
             for j = 1 to 2;
               if doNbr(j) > -42;
                 if j = 1;
                   myNode.xmlbCCSID1 = doNbr(j);
                 elseif j = 2;
                   myNode.xmlbCCSID2 = doNbr(j);
                 elseif j = 3;
                   myNode.xmlbCCSID3 = doNbr(j);
                 else;
                   myNode.xmlbCCSID4 = doNbr(j);
                 endif;
               endif;
             endfor;
           endif;
           if valueLen(8) <> 0; // after='CCSIDFrom/CCSIDTo'
             tmpCtl = 'after(' + %trim(%str(pValue(8):valueLen(8))) + ')';
             rc     = bigDimOpt('after':tmpCtl:doChar:doNbr);
             for j = 1 to 2;
               if doNbr(j) > -42;
                 if j = 1;
                   myNode.xmlaCCSID1 = doNbr(j);
                 elseif j = 2;
                   myNode.xmlaCCSID2 = doNbr(j);
                 elseif j = 3;
                   myNode.xmlaCCSID3 = doNbr(j);
                 else;
                   myNode.xmlaCCSID4 = doNbr(j);
                 endif;
               endif;
             endfor;
           endif;
           if valueLen(9) <> 0; // hex='on|off'
             if 'on' = %str(pValue(9):2);
               myNode.xmlIsHex = XML_ATTR_HEX_TRUE;
             endif;
           endif;
           if valueLen(10) <> 0; // trim='on|off'
             if 'on' = %str(pValue(10):2);
               myNode.xmlTrim = XML_ATTR_TRIM_TRUE;
             elseif 'off' = %str(pValue(10):3);
               myNode.xmlTrim = XML_ATTR_TRIM_FALSE;
             endif;
           endif;
           if valueLen(11) <> 0; // next='label'
             myNode.cacNxtOff = cacAddLab(%str(pValue(11):valueLen(11)):myNode);
           endif;
         endif;
         // save fast cache
         myNode.cacIsRecT = XML_IS_RECORDS_DATA;
         cacAddAtt(myNode);
       endif;

       // ------
       // reset selective parent directives
       myNode.xmlIO     = node.xmlIO;

       // ------
       // dim='n' - at least once
       if myNode.xmlOccurs < 1; // @ADC 1.6.9 Always one
         myNode.xmlOccurs = 1;
       endif;
       
       // -------
       // <records>
       if myNode.cacIsRec = XML_IS_RECORDS_TRUE;
         if op = 'O';
           op = 'W';
         else;
           op = 'R';
         endif;
         cacAddARec(myNode);
       endif;
       
       for o = 1 to myNode.xmlOccurs;

       if op = 'I';
         if dupbeg = *NULL;
           if myNode.xmlPrmRet = XML_IS_PARM;
             dupbeg = ileAddr(*OFF);
           else;
             dupbeg = ileAddr(*ON);
           endif;
         else;
           if myNode.xmlPrmRet = XML_IS_PARM;
             ileDup(*OFF:dupbeg:dupend);
           else;
             ileDup(*ON:dupbeg:dupend);
           endif;
           iter;
         endif;
       endif;

       // ------
       // reset selective parent directives
       myNode.pgmArgTop = node.pgmArgTop;  // ADC 1.6.8
       myNode.xmlBy     = node.xmlBy;      // ADC 1.6.8

       // <data> ... </data>
       //       xxxxx
       // -- or --
       // <data /> (short XML)
       if isNada = *ON or aDataVal2 - aDataVal1 < 0; // no data
         myNode.xmlStrP = aElemTop2;
         myNode.xmlStrSz = 0;
       else;
         myNode.xmlStrP   = aDataVal1;
         myNode.xmlStrSz  = aDataVal2 - aDataVal1 + 1;
       endif;

       // manual CDATA (1.8.1)
       if isCDATA = *ON;
         myNode.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
       endif;

       // <data type='data types' [varying='on|off' enddo='z']>...
       // ooooooooooooooooooooooooooooooooooooooooooooooooooooo
       if (op = 'O' or op = 'W') and myNode.xmlIO <> XML_IO_INPUT;
         xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*OFF:isNada);
       endif;

       // push or pop data
       if op = 'I';
         rc = ilePushData(myNode);        // copy in 
       elseif op = 'O';
         // <data> ... </data>
         //       xxxxx
         rc = ilePopData(sOutPtr:myNode); // copy out
       endif;
       // better hint 1.6.9
       if myNode.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
         xmlCpyErr(rc:o:op:isNada:isCDATA:aVeryTop:
                   aElemTop1:aElemTop2:
                   aDataVal1:aDataVal2:
                   aElemEnd1:aElemEnd2:
                   aElemNext:myNode);
         return *OFF;
       endif;

       // </data>...
       // ooooooo
       if (op = 'O' or op = 'W') and myNode.xmlIO <> XML_IO_INPUT;
         xmlOutput(%addr(ooEndData):7:*ON);
       endif; // allow for overlay output (1.9.2)
       // elseif op = 'I'; // allow for overlay output (1.9.2)
         // offset(*) cache
         if myNode.cacOffEnd > 0;
           rc = cacAddOff(myNode);
         endif;
         // dou enddo(*) cache
         if myNode.cacDouEnd > 0;
           rc = cacAddDou(myNode);
         endif;
         // len setlen(*)
         if myNode.cacLenSet > 0;
           rc = cacAddLen(CAC_LEN_SET:myNode);
         endif;
         // next(*) setnext
         if myNode.cacNxtOff > 0;
           rc = cacAddNxt(myNode);
         endif;
       // endif; // allow for overlay output (1.9.2)

       // ------
       // reset selective parent directives
       node.pgmArgTop = XML_PGM_TOP_FALSE; // ADC 1.6.8
       node.xmlBy = XML_BY_MBR;            // ADC 1.6.8

       // -------
       // <records>
       if myNode.cacIsRec = XML_IS_RECORDS_TRUE;
         leave;
       endif;

       if op = 'I';
         if dupend = *NULL;
           if myNode.xmlPrmRet = XML_IS_PARM;
             dupend = ileAddr(*OFF);
           else;
             dupend = ileAddr(*ON);
           endif;
         endif;
       endif;

       endfor;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlWrkDS        B
     D xmlWrkDS        PI             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D myNode          ds                  likeds(xmlNode_t) 
     D ooEndDS         s             10A   inz('</ds>')
     D ooHint          s             60A   inz(*BLANKS)
     D rc              s              1N   inz(*ON)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D o               s             10i 0 inz(0)
     d tmpNbr          s             32A   inz(*BLANKS)
     D maxOccurs       s             10i 0 inz(1)
     D pTmpPtr         s               *   inz(*NULL)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * search elements
     D whereElem       s             10i 0 inz(-1)
     D keyElem         s             10i 0 inz(-1)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * dup input
     d dupbeg          s               *   inz(*NULL)
     d dupend          s               *   inz(*NULL)
      /free
       // node copy
       xmlCOPY(myNode:node);
       // check fast cache
       scacElemKey += 1;
       myNode.cacElemTop1 = aElemTop1- aVeryTop;
       i = cacScanAtt(myNode);
       // slow way
       if i = 0;
         xmlRESET(myNode);
         myNode.cacElemTop1 = aElemTop1- aVeryTop;
         myNode.cacLenBeg = 0;

         // <ds [dou='z' dim='n' len='label' data='records']>
         // -- or --
         // <ds [dou="z" dim="n" len="label" data='records']>
         //       1      2       3           4
         search(1) = 'dou';
         search(2) = 'dim';
         search(3) = 'len';
         search(4) = 'data';
         rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
         if rc = *ON;
           if valueLen(1) <> 0; // dou='z'
             myNode.cacDouDim = cacAddLab(%str(pValue(1):valueLen(1)):myNode);
           endif;
           if valueLen(2) <> 0; // dim='n'
             tmpNbr = %str(pValue(2):valueLen(2));
             myNode.xmlOccurs = %int(tmpNbr);
           endif;
           if valueLen(3) <> 0; // len='label'
             myNode.cacLenBeg = cacAddLab(%str(pValue(3):valueLen(3)):myNode);
           endif;
           if valueLen(4) <> 0; // data='records'
             myNode.cacIsRec = XML_IS_RECORDS_TRUE;
             myNode.cacIsRecT = XML_IS_RECORDS_DS;
           endif;
         endif;
         // save fast cache
         cacAddAtt(myNode);
       endif;

       // ------
       // reset selective parent directives
       myNode.xmlIO     = node.xmlIO; // @ADC 1.6.9 parent correct
       if myNode.cacIsRec = XML_IS_RECORDS_FALSE;
         myNode.cacIsRec = node.cacIsRec;
         myNode.cacIsRecT = node.cacIsRecT;
       endif;

       // ---------------------------
       // len='label' (first n values)
       if op = 'I' and myNode.cacLenBeg > 0;
         myNode.cacTruLen = ileSzParm(pTmpPtr);
         rc = cacAddLen(CAC_LEN_BEG:myNode);
       endif;

       // ------
       // dim='n' - at least once
       if myNode.xmlOccurs < 1;  // @ADC 1.6.9 Always one
         myNode.xmlOccurs = 1;
       endif;
       if op = 'O' and myNode.cacDouDim > 0;
         maxOccurs = cacPopDou(myNode);
       else;
         maxOccurs = myNode.xmlOccurs;
       endif;

       // -------
       // <records>
       if myNode.cacIsRec = XML_IS_RECORDS_TRUE;
         cacAddARec(myNode);
       endif;

       for o = 1 to myNode.xmlOccurs;

       if op = 'I';
         if dupbeg = *NULL;
           if myNode.xmlPrmRet = XML_IS_PARM;
             dupbeg = ileAddr(*OFF);
           else;
             dupbeg = ileAddr(*ON);
           endif;
         else;
           if myNode.xmlPrmRet = XML_IS_PARM;
             ileDup(*OFF:dupbeg:dupend);
           else;
             ileDup(*ON:dupbeg:dupend);
           endif;
           iter;
         endif;
       endif;

       // ------
       // reset selective parent directives
       myNode.pgmArgTop = node.pgmArgTop;  // ADC 1.6.8
       myNode.xmlBy     = node.xmlBy;      // ADC 1.6.8

       // we need to process all output
       // returned from the ILE call
       // top to bottom of memory
       // to correctly pop data ptrs,
       // even if no output xml returned
       // because we have reached
       // dou='label' maximum
       if op = 'O' and o > maxOccurs;
         myNode.xmlIO = XML_IO_INPUT;
       endif;

       // <ds [dim='n' dou='z']>...
       // oooooooooooooooooooooo
       if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
         xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*ON:isNada);
       endif;

       // --------------
       // copy in/out
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'data';
       elem(2) = 'ds';
       doNest(2) = *ON;
       dou pNxt = *NULL 
        or rc = *OFF
        or pNxt >= pLst;
         pTop = pNxt;
         i = cacScanXML(aVeryTop:pTop:pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                       :doNada:doCDATA:findElem:keyElem);
         if i = 0;
           findElem = bigElem(pTop:pLst:elem:doNest
                    :doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         endif;
         select;
         // <(/)junk> ... </junk>
         //           ... EOF
         // B             E
         when findElem = 0;
          if op = 'O';
           // < ... > ... <
           // oooooooooooo
           string = pB1;
           stringLen = pNxt - pB1;
           xmlOutput(string:stringLen:*OFF);
          endif;
         // <data ...> ... </data>
         // B        1    2      E
         when findElem = 1;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkData(op:doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                  :myNode);
         // <ds ...> ... </ds>
         // B       1   2    E
         when findElem = 2;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkDS(op:doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                  :myNode);
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
         // better hint 1.6.9
         if myNode.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
           xmlCpyErr(rc:o:op:isNada:isCDATA:aVeryTop:
                   aElemTop1:aElemTop2:
                   aDataVal1:aDataVal2:
                   aElemEnd1:aElemEnd2:
                   aElemNext:myNode);
           return *OFF;
         endif;
       enddo;

       // </ds>...
       // ooooo
       if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
         xmlOutput(%addr(ooEndDS):5:*ON);
       endif;

       // ------
       // reset selective parent directives
       node.pgmArgTop = myNode.pgmArgTop; // ADC 1.6.8
       node.xmlBy     = myNode.xmlBy;     // ADC 1.6.8

       // -------
       // <records>
       if myNode.cacIsRec = XML_IS_RECORDS_TRUE;
         leave;
       endif;

       if op = 'I';
         if dupend = *NULL;
           if myNode.xmlPrmRet = XML_IS_PARM;
             dupend = ileAddr(*OFF);
           else;
             dupend = ileAddr(*ON);
           endif;
         endif;
       endif;

       endfor;

       // calculating total length DS
       // and this is the last <data>
       // so it has the last offset
       if op = 'I' and myNode.cacLenBeg > 0;
         myNode.cacTruLen = ileSzParm(pTmpPtr);
         rc = cacAddLen(CAC_LEN_END:myNode);
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlWrkParm      B
     D xmlWrkParm      PI             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D myNode          ds                  likeds(xmlNode_t) 
     D ooEndParm       s             10A   inz('</parm>')
     D rc              s              1N   inz(*ON)
     D reTop           s              1N   inz(*ON)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * search elements
     D whereElem       s             10i 0 inz(-1)
     D keyElem         s             10i 0 inz(-1)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      /free
       // mark start ILE data locations
       // for overlay processing
       ileMark(ILE_SAVE_START:node.xmlPrmRet);

       // node copy
       xmlCOPY(myNode:node);
       // check fast cache
       scacElemKey += 1;
       myNode.cacElemTop1 = aElemTop1- aVeryTop;
       i = cacScanAtt(myNode);
       // slow way
       if i = 0;
         xmlRESET(myNode);
         myNode.cacElemTop1 = aElemTop1- aVeryTop;

         // <parm [io='in|out|both|omit' by='val|ref']>
         // -- or --
         // <parm [io="in|out|both|omit" by="val|ref"]>
         //        1                     2
         search(1) = 'io';
         search(2) = 'by';
         rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
         if rc = *ON;
           if valueLen(1) <> 0; // io='in|out|both|omit'
             if 'in' = %str(pValue(1):2) or 'omit' = %str(pValue(1):4);
               myNode.xmlIO = XML_IO_INPUT;
               if 'omit' = %str(pValue(1):4);
                 myNode.xmlIsOmit = XML_PARM_OMIT_TRUE;
               endif;
             elseif 'out' = %str(pValue(1):3);
               myNode.xmlIO = XML_IO_OUTPUT;
             endif;
           endif;
           if valueLen(2) <> 0; // by='val|ref'
             if 'val' = %str(pValue(2):3);
               myNode.xmlBy = XML_BY_VAL;
             endif;
           endif;
         endif;
         // save fast cache
         cacAddAtt(myNode);
       endif;

       // ------
       // reset selective parent directives
       myNode.pgmArgTop = XML_PGM_TOP_TRUE; // ADC 1.6.8

       if myNode.xmlIsOmit = XML_PARM_OMIT_TRUE;
         myNode.xmlStrP   = aElemTop2;
         myNode.xmlStrSz  = 0;
         myNode.xmlDigits = 1;
         myNode.xmlAttr   = XML_ATTR_VAL_H;
         myNode.xmlFrac   = 0;
         myNode.xmlVary   = XML_VARY_OFF;
         rc = ilePushData(myNode);
       else;
        // <records>
        cacClrARec();
         
        // <parm [io='in|out|both' by='val|ref']>...
        // oooooooooooooooooooooooooooooooooooooo
        if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
          xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*ON:isNada);
        endif;

        // --------------
        // copy in/out
        rc = *ON;
        pTop = aDataVal1;
        pNxt = aDataVal1;
        pLst = aDataVal2;
        elem(1) = 'data';
        elem(2) = 'ds';
        elem(3) = 'records';
        doNest(2) = *ON;
        dou pNxt = *NULL or rc = *OFF;
         pTop = pNxt;
         i = cacScanXML(aVeryTop:pTop:pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                       :doNada:doCDATA:findElem:keyElem);
         if i = 0;
           findElem = bigElem(pTop:pLst:elem:doNest
                    :doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         endif;
         select;
         // <(/)junk> ... </junk>
         //           ... EOF
         // B             E
         when findElem = 0;
          if op = 'O';
           // < ... > ... <
           // oooooooooooo
           string = pB1;
           stringLen = pNxt - pB1;
           xmlOutput(string:stringLen:*OFF);
          endif;
         // <data ...> ... </data>
         // B        1    2      E
         when findElem = 1;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkData(op:doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                  :myNode);
         // <ds ...> ... </ds>
         // B       1   2    E
         when findElem = 2;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkDS(op:doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                  :myNode);
         // <records ...> ... </records>
         // B           1    2         E
         when findElem = 3;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           // ------
           // reset selective parent directives
           if reTop = *ON;
             myNode.pgmArgTop = XML_PGM_TOP_TRUE; // ADC 1.6.8
             myNode.xmlBy     = node.xmlBy;       // ADC 1.6.8
             reTop = *OFF;
           endif;
           rc = xmlWrkRec(op:doNada:doCDATA:aVeryTop
                   :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
           // <records>
           cacClrARec();
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
         // better hint 1.6.9
         if myNode.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
           xmlCpyErr(rc:0:op:isNada:isCDATA:aVeryTop:
                   aElemTop1:aElemTop2:
                   aDataVal1:aDataVal2:
                   aElemEnd1:aElemEnd2:
                   aElemNext:myNode);
           return *OFF;
         endif;
        enddo;

        // </parm>...
        // ooooooo
        if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
          xmlOutput(%addr(ooEndParm):7:*ON);
        endif;
       endif;

       // mark end ILE data locations
       // for overlay processing
       ileMark(ILE_SAVE_END:node.xmlPrmRet);

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlWrkRet       B
     D xmlWrkRet       PI             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D myNode          ds                  likeds(xmlNode_t) 
     D ooEndRet        s             10A   inz('</return>')
     D rc              s              1N   inz(*ON)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D pIO             s               *   inz(*NULL)
     D pIOType         s               *   inz(*NULL)
     D pBy             s               *   inz(*NULL)
     D pByType         s               *   inz(*NULL)
      * search elements
     D whereElem       s             10i 0 inz(-1)
     D keyElem         s             10i 0 inz(-1)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      /free
       // mark start ILE data locations
       // for overlay processing
       ileMark(ILE_SAVE_START:node.xmlPrmRet);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <records>
       cacClrARec();

       // ------
       // reset selective parent directives

       // <return>...
       // oooooooo
       if op = 'O';
         xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*ON:isNada);
       endif;

       // --------------
       // copy in/out
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'data';
       elem(2) = 'ds';
       elem(3) = 'records';
       doNest(2) = *ON;
       dou pNxt = *NULL or rc = *OFF;
         pTop = pNxt;
         i = cacScanXML(aVeryTop:pTop:pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                       :doNada:doCDATA:findElem:keyElem);
         if i = 0;
           findElem = bigElem(pTop:pLst:elem:doNest
                    :doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         endif;
         select;
         // <(/)junk> ... </junk>
         //           ... EOF
         // B             E
         when findElem = 0;
          if op = 'O';
           // < ... > ... <
           // oooooooooooo
           string = pB1;
           stringLen = pNxt - pB1;
           xmlOutput(string:stringLen:*OFF);
          endif;
         // <data ...> ... </data>
         // B        1    2      E
         when findElem = 1;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkData(op:doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                  :myNode);
         // <ds ...> ... </ds>
         // B       1   2    E
         when findElem = 2;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkDS(op:doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                  :myNode);
         // <records ...> ... </records>
         // B           1    2         E
         when findElem = 3;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkRec(op:doNada:doCDATA:aVeryTop
                   :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
           // <records>
           cacClrARec();
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
         // better hint 1.6.9
         if myNode.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
           xmlCpyErr(rc:0:op:isNada:isCDATA:aVeryTop:
                   aElemTop1:aElemTop2:
                   aDataVal1:aDataVal2:
                   aElemEnd1:aElemEnd2:
                   aElemNext:myNode);
           return *OFF;
         endif;
       enddo;

       // </return>...
       // ooooooooo
       if op = 'O';
         xmlOutput(%addr(ooEndRet):9:*ON);
       endif;

       // mark end ILE data locations
       // for overlay processing
       ileMark(ILE_SAVE_END:node.xmlPrmRet);

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlWrkOver      B
     D xmlWrkOver      PI             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D myNode          ds                  likeds(xmlNode_t) 
     D ooEndOver       s             10A   inz('</overlay>')
     D rc              s              1N   inz(*ON)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D o               s             10i 0 inz(0)
     d tmpNbr          s             32A   inz(*BLANKS)
     D maxOccurs       s             10i 0 inz(1)
     D memP            S               *   inz(*NULL)
     D memchar         s              1A   based(memP)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * search elements
     D whereElem       s             10i 0 inz(-1)
     D keyElem         s             10i 0 inz(-1)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      /free
       // node copy
       xmlCOPY(myNode:node);
       // check fast cache
       scacElemKey += 1;
       myNode.cacElemTop1 = aElemTop1- aVeryTop;
       i = cacScanAtt(myNode);
       // slow way
       if i = 0;
         xmlRESET(myNode);
         myNode.cacElemTop1 = aElemTop1- aVeryTop;

         // <overlay [io='in|out|both' offset='n' top='on|off|n' 
         //           dou='z' dim='n' setnext='x']>
         // -- or --
         // <overlay [io="in|out|both" offset="n" top="on|off|n" 
         //           1                2          3
         //           dou="z" dim="n" setnext="x"]>
         //           4       5       6
         search(1) = 'io';
         search(2) = 'offset';
         search(3) = 'top';
         search(4) = 'dou';
         search(5) = 'dim';
         search(6) = 'setnext';
         rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
         if rc = *ON;
           if valueLen(1) <> 0; // io='in|out|both'
             if 'in' = %str(pValue(1):2);
               myNode.xmlIO = XML_IO_INPUT;
             elseif 'out' = %str(pValue(1):3);
               myNode.xmlIO = XML_IO_OUTPUT;
             endif;
           endif;
           if valueLen(2) <> 0; // offset='n'
             memP = pValue(2);
             if memchar = '0' or memchar = '1' 
             or memchar = '2' or memchar = '3'
             or memchar = '4' or memchar = '5' 
             or memchar = '6' or memchar = '7'
             or memchar = '8' or memchar = '9';
               tmpNbr = %str(pValue(2):valueLen(2));
               myNode.xmlOffNbr = %int(tmpNbr);
             else;
               myNode.cacOffOvr = cacAddLab(%str(pValue(2):valueLen(2)):myNode);
             endif;
           endif;
           if valueLen(3) <> 0; // top='on|off'
             if 'on' = %str(pValue(3):2);
               myNode.xmlIsTop = XML_OVR_TOP_TRUE;
             elseif 'of' = %str(pValue(3):2);
               myNode.xmlIsTop = XML_OVR_TOP_FALSE;
             else; // top='n'
               tmpNbr = %str(pValue(3):valueLen(3));
               myNode.xmlTopNbr = %int(tmpNbr);
             endif;
           endif;
           if valueLen(4) <> 0; // dou='z'
             myNode.cacDouDim = cacAddLab(%str(pValue(4):valueLen(4)):myNode);
           endif;
           if valueLen(5) <> 0; // dim='n'
             tmpNbr = %str(pValue(5):valueLen(5));
             myNode.xmlOccurs = %int(tmpNbr);
           endif;
           if valueLen(6) <> 0; // setnext='x'
             myNode.cacNxtOvr = cacAddLab(%str(pValue(6):valueLen(6)):myNode);
           endif;
         endif;
         // save fast cache
         cacAddAtt(myNode);
       endif;

       // overlay forget it, no action needed
       if (op = 'I' and myNode.xmlIO = XML_IO_OUTPUT)
       or (op = 'O' and myNode.xmlIO = XML_IO_INPUT);
         return *ON;
       endif;

       // restore start ILE data locations
       // before overlay processing
       // offset='n'
       if myNode.cacOffOvr > 0;
         myNode.xmlOffNbr = cacPopOff(myNode);
       endif;
       // top param (top='1')
       if myNode.xmlIsTop = XML_OVR_TOP_TRUE;
         ileMark(ILE_RESTORE_TOP
                :myNode.xmlPrmRet:myNode.xmlOffNbr);
       // n parm (top='n')
       elseif myNode.xmlTopNbr > 0;
         ileMark(ILE_RESTORE_PARM
                :myNode.xmlPrmRet:myNode.xmlOffNbr
                :myNode.xmlTopNbr);
       // overlay current parm (no top)
       else;
         ileMark(ILE_RESTORE_START
                :myNode.xmlPrmRet:myNode.xmlOffNbr);
       endif;

       // ------
       // reset selective parent directives
       // ------
       // dim='n' - at least once
       if myNode.xmlOccurs < 1;  // @ADC 1.6.9 Always one
         myNode.xmlOccurs = 1;
       endif;
       if op = 'O' and myNode.cacDouDim > 0;
         maxOccurs = cacPopDou(myNode);
       else;
         maxOccurs = myNode.xmlOccurs;
       endif;


       for o = 1 to myNode.xmlOccurs;

       // we need to process all output
       // returned from the ILE call
       // top to bottom of memory
       // to correctly pop data ptrs,
       // even if no output xml returned
       // because we have reached
       // dou='label' maximum
       if op = 'O' and o > maxOccurs;
         myNode.xmlIO = XML_IO_INPUT;
       endif;

       // <overlay [io='in|out|both' offset='n' top='on|off']>...
       // oooooooooooooooooooooooooooooooooooooooooooooooooooo
       if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
         xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*ON:isNada);
       endif;

       // --------------
       // copy in/out
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'data';
       elem(2) = 'ds';
       doNest(2) = *ON;
       dou pNxt = *NULL or rc = *OFF;
         pTop = pNxt;
         i = cacScanXML(aVeryTop:pTop:pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                       :doNada:doCDATA:findElem:keyElem);
         if i = 0;
           findElem = bigElem(pTop:pLst:elem:doNest
                    :doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         endif;
         select;
         // <(/)junk> ... </junk>
         //           ... EOF
         // B             E
         when findElem = 0;
          if op = 'O';
           // < ... > ... <
           // oooooooooooo
           string = pB1;
           stringLen = pNxt - pB1;
           xmlOutput(string:stringLen:*OFF);
          endif;
         // <data ...> ... </data>
         // B        1    2      E
         when findElem = 1;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkData(op:doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                  :myNode);
         // <ds ...> ... </ds>
         // B       1   2    E
         when findElem = 2;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           rc = xmlWrkDS(op:doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                  :myNode);
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
         // better hint 1.6.9
         if myNode.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
           xmlCpyErr(rc:0:op:isNada:isCDATA:aVeryTop:
                   aElemTop1:aElemTop2:
                   aDataVal1:aDataVal2:
                   aElemEnd1:aElemEnd2:
                   aElemNext:myNode);
           return *OFF;
         endif;
       enddo;

       // </overlay>...
       // oooooooooo
       if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
         xmlOutput(%addr(ooEndOver):10:*ON);
       endif;

       // restore start ILE data locations
       // before next overlay processing
       if o < maxOccurs
       and myNode.cacNxtOvr > 0;
         // setnext='n'
         myNode.xmlOffNbr = cacPopNxt(myNode);
         // top param (top='1')
         if myNode.xmlIsTop = XML_OVR_TOP_TRUE;
           ileMark(ILE_RESTORE_TOP
                  :myNode.xmlPrmRet:myNode.xmlOffNbr);
         // n parm (top='n')
         elseif myNode.xmlTopNbr > 0;
           ileMark(ILE_RESTORE_PARM
                  :myNode.xmlPrmRet:myNode.xmlOffNbr
                  :myNode.xmlTopNbr);
         // overlay current parm (no top)
         else;
           ileMark(ILE_RESTORE_START
                  :myNode.xmlPrmRet:myNode.xmlOffNbr);
         endif;
       endif;

       endfor;

       // restore end ILE data locations
       // after overlay processing
       ileMark(ILE_RESTORE_END:myNode.xmlPrmRet);

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlPooPRec      B
     D xmlPooPRec      PI             1N
     D   string1                       *
     D   string2                       *
     D   string3                       *
     D   pCopy                         *
     D   index                       10i 0
     D   j                           10i 0
     D   k                           10i 0
     D   xmllen                      10i 0
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D myNode          ds                  likeds(xmlNode_t) 
     D zzNode          ds                  likeds(xmlNode_t) 
     D rc              s              1N   inz(*ON)
     D o1              s             10i 0 inz(0)
     D o2              s             10i 0 inz(0)
     D h               s             10i 0 inz(0)
     D indexTop        s             10i 0 inz(0)
     D c               s              1A   inz(' ')
     D find            s              1N   inz(*OFF)
     D maxOccurs       s             10i 0 inz(1)
      /free
       // ------
       // myNode
       indexTop = index;
       index = cacScanARec(indexTop:myNode);
       if index < 1;
         return *OFF;
       endif;
       // ------
       // dim='n' - at least once
       if myNode.xmlOccurs < 1;  // @ADC 1.6.9 Always one
         myNode.xmlOccurs = 1;
       endif;
       if op = 'O' and myNode.cacDouDim > 0;
         maxOccurs = cacPopDou(myNode);
       else;
         maxOccurs = myNode.xmlOccurs;
       endif;
       for o1 = 1 to myNode.xmlOccurs;
         rc = *ON;
         // top node (my node)
         index = cacScanARec(indexTop:zzNode);

         // we need to process all output
         // returned from the ILE call
         // top to bottom of memory
         // to correctly pop data ptrs,
         // even if no output xml returned
         // because we have reached
         // dou='label' maximum
         if op = 'O' and o1 > maxOccurs;
           myNode.xmlIO = XML_IO_INPUT;
         endif;

         // ------
         // reset selective parent directives
         myNode.pgmArgTop = node.pgmArgTop;  // ADC 1.6.8
         myNode.xmlBy     = node.xmlBy;      // ADC 1.6.8
         myNode.cacIsRecD = node.cacIsRecD;
         
         // loop through my child nodes
         dow index > 0;
           select;
           // my child node is another DS (recusive nest)
           when zzNode.cacIsRecT = XML_IS_RECORDS_DS;
             if myNode.cacElemTop1 <> zzNode.cacElemTop1;
             
               // reset selective parent directives
               zzNode.pgmArgTop = myNode.pgmArgTop;  // ADC 1.6.8
               zzNode.xmlBy     = myNode.xmlBy;      // ADC 1.6.8
               zzNode.cacIsRecD = myNode.cacIsRecD;
               if myNode.xmlIO = XML_IO_INPUT;
                 zzNode.xmlIO = XML_IO_INPUT;
               endif;

               rc = xmlPooPRec(string1:string2:string3
                    :pCopy:index:j:k:xmllen
                    :op:isNada:isCDATA:aVeryTop
                    :aElemTop1:aElemTop2
                    :pCopy + j:aDataVal2
                    :aElemEnd1:aElemEnd2:aElemNext:zzNode);

               // ------
               // reset selective parent directives
               myNode.pgmArgTop = zzNode.pgmArgTop; // ADC 1.6.8
               myNode.xmlBy     = zzNode.xmlBy;     // ADC 1.6.8

             endif;
           // my child node is simple data (do push/pop data)
           when zzNode.cacIsRecT = XML_IS_RECORDS_DATA;
             // ------
             // dim='n' - at least once
             if zzNode.xmlOccurs < 1;  // @ADC 1.6.9 Always one
               zzNode.xmlOccurs = 1;
             endif;
             for o2 = 1 to zzNode.xmlOccurs;
           
               // reset selective parent directives
               zzNode.pgmArgTop = myNode.pgmArgTop;  // ADC 1.6.8
               zzNode.xmlBy     = myNode.xmlBy;      // ADC 1.6.8
               zzNode.cacIsRecD = myNode.cacIsRecD;
               if myNode.xmlIO = XML_IO_INPUT;
                 zzNode.xmlIO = XML_IO_INPUT;
               endif;

               if op = 'I';
                 // one character at a time
                 // :x:x:...:x:
                 // 1 2
                 string1 = string3;
                 string2 = *NULL;
                 for h = k to xmllen;
                  // get next single character
                  c = lilAssist(pCopy:find:j:0:*BLANKS);
                  if c = node.cacIsRecD;
                    if string1 = *NULL;
                      string1 = pCopy + j;
                    elseif string2 = *NULL;
                      string2 = pCopy + j - 1;
                      string3 = pCopy + j;
                      leave;
                    endif;
                  endif;
                 endfor;
                 k = h;
                 if string1 = *NULL or string2 = *NULL 
                 or string2 <= string1; // no data
                   zzNode.xmlStrP = string1;
                   zzNode.xmlStrSz = 0;
                 else;
                   zzNode.xmlStrP   = string1;
                   zzNode.xmlStrSz  = string2 - string1;
                 endif;
                 rc = ilePushData(zzNode);        // copy in
               elseif op = 'O';
                 // :
                 // o
                 if op = 'O' and zzNode.xmlIO <> XML_IO_INPUT;
                   xmlOutput(%addr(node.cacIsRecD):1:*OFF);
                 endif;
                 // : ... :
                 //  ooooo
                 rc = ilePopData(sOutPtr:zzNode); // copy out
               endif; 
               if zzNode.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
                 xmlCpyErr(rc:o2:op:isNada:isCDATA:aVeryTop:
                       aElemTop1:aElemTop2:
                       string1:string2:
                       aElemEnd1:aElemEnd2:
                       aElemNext:zzNode);
                 rc = *OFF;
               endif;
               
               // ------
               // reset selective parent directives
               myNode.pgmArgTop = XML_PGM_TOP_FALSE; // ADC 1.6.8
               myNode.xmlBy     = XML_BY_MBR;        // ADC 1.6.8

             endfor;  // end my occurs simple data array
           other;
           endsl;
           if rc = *OFF;
             leave;
           endif;
           // next child node please
           if index > 0;
             index = cacScanARec(index+1:zzNode);
           endif;

           // ------
           // reset selective parent directives
           node.pgmArgTop = myNode.pgmArgTop; // ADC 1.6.8
           node.xmlBy     = myNode.xmlBy;     // ADC 1.6.8


         enddo; // end all my child nodes

         // ------
         // reset selective parent directives
         node.pgmArgTop = myNode.pgmArgTop; // ADC 1.6.8
         node.xmlBy = myNode.xmlBy;         // ADC 1.6.8

       endfor; // end my occurs array

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml body
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlWrkRec       B
     D xmlWrkRec       PI             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aVeryTop                       *   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D myNode          ds                  likeds(xmlNode_t) 
     D ooEndRecs       s             10A   inz('</records>')
     D rc              s              1N   inz(*ON)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     d tmpNbr          s             32A   inz(*BLANKS)
     D memP            S               *   inz(*NULL)
     D memchar         s              1A   based(memP)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * search elements
     D whereElem       s             10i 0 inz(-1)
     D keyElem         s             10i 0 inz(-1)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * movement through records
     D pCopy           s               *   inz(*NULL)
     D j               s             10i 0 inz(0)
     D k               s             10i 0 inz(0)
     D index           s             10i 0 inz(0)
     D xmllen          s             10i 0 inz(0)
     D string1         s               *   inz(*NULL)
     D string2         s               *   inz(*NULL)
     D string3         s               *   inz(*NULL)
      /free
       // node copy
       xmlCOPY(myNode:node);
       // check fast cache
       scacElemKey += 1;
       myNode.cacElemTop1 = aElemTop1- aVeryTop;
       i = cacScanAtt(myNode);
       // slow way
       if i = 0;
         xmlRESET(myNode);
         myNode.cacElemTop1 = aElemTop1- aVeryTop;

         // <records [delimit='c']>
         // -- or --
         // <records [delimit="c"]>
         //           1
         search(1) = 'delimit';
         rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
         if rc = *ON;
           if valueLen(1) <> 0; // delimit='c'
             myNode.cacIsRecD = %str(pValue(1):1);
           endif;
         endif;
         // save fast cache
         cacAddAtt(myNode);
       endif;

       // ------
       // reset selective parent directives

       // <records [delimit='c']>...
       // ooooooooooooooooooooooo
       if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
         xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*OFF:isNada);
       endif;
     
       // --------------
       // copy in/out
       // index node (index) 
       // and data position (pCopy)
       // should be matching locations
       // as push/pop exactly same counts
       // :x:x:...:x:
       // 1         2
       // If recursive calls, index
       // will return back to top
       pCopy = aDataVal1;
       xmllen = aDataVal2 - aDataVal1;
       k = 1;
       index = 1;
       rc = xmlPooPRec(string1:string2:string3
              :pCopy:index:j:k:xmllen
              :op:isNada:isCDATA:aVeryTop
              :aElemTop1:aElemTop2:aDataVal1:aDataVal2
              :aElemEnd1:aElemEnd2:aElemNext:myNode);

        // :
        // o --- the final delimter
        if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
          xmlOutput(%addr(myNode.cacIsRecD):1:*OFF);
        endif;
       

       // </records>...
       // oooooooooo
       if op = 'O' and myNode.xmlIO <> XML_IO_INPUT;
         xmlOutput(%addr(ooEndRecs):10:*ON);
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml program
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlDoPgm        B
     D xmlDoPgm        PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
      * vars
     D ooEndPgm        s             10A   inz('</pgm>')
     D ooHint          s             60A   inz(*BLANKS)
     D xxHint          s             60A   inz(*BLANKS)
     D i               S             10i 0 inz(0)
     d rc              s              1N   inz(*ON)
     d rc1             s              1N   inz(*ON)
     d myOPM           s              1A   inz(XML_PGM_OPM_FALSE)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     d okCache         s              1N   inz(*OFF)
     d skipCopy        s              1N   inz(*OFF)
     d byVal           s              1N   inz(*OFF)
     D mypgm           S             10A   inz(*BLANKS)
     D mylib           S             10A   inz(*BLANKS)
     D myfunc          S            128A   inz(*BLANKS)
     D mycache         S             30A   inz(*BLANKS)
     D myNode          ds                  likeds(xmlNode_t) 
     D piReturn        s               *   inz(*NULL)
     d retSize         s             10i 0 inz(0)
     D piParm          s               *   inz(*NULL)
     d piSize          s             10i 0 inz(0)
     D modeHexFnd      s              1N   inz(*OFF)
     D ccsidFndB       s              1N   inz(*OFF)
     D ccsidFndA       s              1N   inz(*OFF)
     d srcLen          s             10i 0 inz(0)
     d outLen          s             10i 0 inz(0)
     D myStopOn        s              1N   inz(*ON)
     D myJobLog        s              1N   inz(*OFF)
     D piErrFast       s               *   inz(*NULL)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * search elements
     D whereElem       s             10i 0 inz(-1)
     D keyElem         s             10i 0 inz(-1)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doFind          s             10i 0 dim(XMLMAXATTR) inz(0)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * loop me
     D pILESym         S               *   inz(*NULL)
     D actmark         S             10i 0 inz(0)
     D aVeryTop        S               *   inz(*NULL)
     D label           s             20A   inz(*BLANKS)
      /free
       Monitor;

       // hint
       scacElemKey = 0;
       aVeryTop = aElemTop1;
       xmlSetHint(aElemTop1:aElemEnd2:ooHint);
       rc = *ON;

       perfAdd(PERF_XML_SERVER_PGM_ATTR1);
       if skipCopy = *OFF;
        // <pgm name='z' [lib='z' func='z' mode='opm|ile cache='label' error='on|off|fast']>
        // -- or --
        // <pgm name="z" [lib="z" func="z" mode="opm|ile cache="label" error="on|off|fast"]">
        //      1         2       3        4             5             6
        search(1) = 'name';
        search(2) = 'lib';
        search(3) = 'func';
        search(4) = 'mode';
        search(5) = 'cache';
        search(6) = 'error';
        rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
        if rc = *ON;
         if valueLen(1) <> 0; // name='z'
           mypgm = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // lib='z'
           mylib = %str(pValue(2):valueLen(2));
         endif;
         if valueLen(3) <> 0; // func='z'
           myfunc = %str(pValue(3):valueLen(3));
         endif;
         if valueLen(4) <> 0; // mode='opm|ile' (1.6.8)
           if 'opm' = %str(pValue(4):3);
             myOPM = XML_PGM_OPM_TRUE;
           endif;
         endif;
         if valueLen(5) <> 0; // cache='label'
           mycache = %str(pValue(5):valueLen(5));
         endif;
         if valueLen(6) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(6):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(6):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(6):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
        endif;

        // -- or --
 
        // <pgm mode='opm|ile'>
        // <name hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
        // <lib hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
        // <func hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
        if mypgm = *BLANKS;
         rc = *ON;
         pTop = aDataVal1;
         pNxt = aDataVal1;
         pLst = aDataVal2;
         elem(1) = 'name';
         elem(2) = 'lib';
         elem(3) = 'func';
         dou pNxt = *NULL or rc = *OFF;
          pTop = pNxt;
          findElem = bigElem(pTop:pLst:elem:doNest:
                    doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
          select;
          // <name ...> ... </name>
          // B         1   2      E
          when findElem = 1;
            outLen = %size(mypgm);
            rc = xmlWrkVal('K':doNada:doCDATA:aVeryTop
                   :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:*OFF:*ON
                   :%addr(mypgm):modeHexFnd:ccsidFndB:ccsidFndA
                   :srcLen:outLen);
          // <lib ...> ... </lib>
          // B        1   2     E
          when findElem = 2;
            outLen = %size(mylib);
            rc = xmlWrkVal('K':doNada:doCDATA:aVeryTop
                   :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:*OFF:*ON
                   :%addr(mylib):modeHexFnd:ccsidFndB:ccsidFndA
                   :srcLen:outLen);
          // <func ...> ... </func>
          // B         1   2      E
          when findElem = 3;
            outLen = %size(myfunc);
            rc = xmlWrkVal('K':doNada:doCDATA:aVeryTop
                   :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:*OFF:*ON
                   :%addr(myfunc):modeHexFnd:ccsidFndB:ccsidFndA
                   :srcLen:outLen);
          when findElem = -1;
            rc = *OFF;
          other;
            // once <name> found, 
            // then all else is junk 
            if mypgm <> *BLANKS;
              pNxt = *NULL;
            endif;
          endsl;
          if rc = *OFF;
            perfAdd(PERF_XML_SERVER_RUN_ERROR);
            errsSevere(XML_ERROR_COPYIN_FAIL:ooHint);
            rc = *OFF;
          endif;
         enddo;
        endif;
       endif;
       perfAdd(PERF_XML_SERVER_PGM_ATTR2);

       // --------------
       // set ILE parm builder
       perfAdd(PERF_XML_SERVER_PGM_INIT1);
       cacStatic(CAC_LEVEL_PGM);
       if rc = *ON;
        rc = ileStatic(myOPM);
        if rc = *OFF;
          perfAdd(PERF_XML_SERVER_RUN_ERROR);
          rc = *OFF;
        endif;
       endif;
       
       // --------------
       // log if enabled (1.7.1)
       perfLogAdd(PERF_LOG_L_PGM
                  + ' ' + %trim(mylib) 
                  + ' ' + %trim(mypgm)
                  + ' ' + %trim(myfunc));

       // --------------
       // node create
       xmlCTOR(myNode);
       if xmlGetCDATA() = *ON;
         myNode.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
       endif;
       if myfunc = *BLANKS;
         myNode.xmlCallAs = XML_FUNC_PGM;
       else;
         myNode.xmlCallAs = XML_FUNC_SRVPGM;
       endif;
       myNode.pgmOPMMem = myOPM;
       aVeryTop = aElemTop1;
       if rc = *ON;       
        // -------------
        // locate/add attribute cache
        if mycache <> *BLANKS;
          cacAddPgm(CAC_QP2_PREPARE:mypgm:mylib:myfunc
                   :pILESym:actmark
                   :mycache:myNode);
          // program maybe previously cached
          // if myNode.pgmIndex > 0;
          // endif;
        endif;
       endif;
       perfAdd(PERF_XML_SERVER_PGM_INIT2);

       // --------------
       // fast find BIG BIG <data>  (@ADC 1.7.4)
       perfAdd(PERF_XML_SERVER_PGM_ASSIST1);
       if rc = *ON
       and aElemTop1 <> *NULL
       and aElemEnd2 <> *NULL
       and aElemEnd2 > aElemTop1
       and aElemEnd2 - aElemTop1  > 33000; // only big (1.9.2)
        elem(1) = 'parm';
        elem(2) = 'return';
        elem(3) = 'overlay';
        elem(4) = 'records';
        elem(5) = 'ds';
        elem(6) = 'data';
        doFind(1) = 1;
        doFind(2) = 2;
        doFind(3) = 3;
        doFind(4) = 3;
        doFind(5) = 2;
        doFind(6) = 1;
        i = bigAssist(aElemTop1:aElemEnd2:elem:doFind);
        elem(1) = *BLANKS;
        elem(2) = *BLANKS;
        elem(3) = *BLANKS;
        elem(4) = *BLANKS;
        elem(5) = *BLANKS;
        doFind(1) = 0;
        doFind(2) = 0;
        doFind(3) = 0;
        doFind(4) = 0;
        doFind(5) = 0;
       endif;
       perfAdd(PERF_XML_SERVER_PGM_ASSIST2);

       // ------
       // copy in (slow)
       perfAdd(PERF_XML_SERVER_PGM_COPYIN1);
       if skipCopy = *OFF and rc = *ON;
        pTop = aDataVal1;
        pNxt = aDataVal1;
        pLst = aDataVal2;
        elem(1) = 'parm';
        elem(2) = 'return';
        elem(3) = 'overlay';
        dou pNxt = *NULL or rc = *OFF;
         pTop = pNxt;
         i = cacScanXML(aVeryTop:pTop:pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                       :doNada:doCDATA:findElem:keyElem);
         if i = 0;
           findElem = bigElem(pTop:pLst:elem:doNest
                    :doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         endif;
         select;
         // <parm ...> ... </parm>
         // B        1    2      E
         when findElem = 1;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           myNode.xmlBy           = XML_BY_REF;
           myNode.xmlPrmRet       = XML_IS_PARM;
           rc = xmlWrkParm('I':doNada:doCDATA:aVeryTop
                   :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
         // <return ...> ... </return>
         // B           1   2        E
         when findElem = 2;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           myNode.xmlBy           = XML_BY_VAL;
           myNode.xmlPrmRet       = XML_IS_RETURN;
           rc = xmlWrkRet('I':doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
         // <overlay ...> ... </overlay>
         // B            1   2         E
         when findElem = 3;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           myNode.xmlBy           = XML_BY_MBR; // 1.6.8
           rc = xmlWrkOver('I':doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
         // better hint 1.6.9
         if myNode.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
           perfAdd(PERF_XML_SERVER_RUN_ERROR);
           errsSevere(XML_ERROR_COPYIN_FAIL:ooHint);
           xmlCpyErr(rc:0:'I':doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
           rc = *OFF;
         endif;
        enddo;

        // --------------
        // set any lengths
        rc1 = cacPushLen(myNode);

       endif;
       perfAdd(PERF_XML_SERVER_PGM_COPYIN2);

       // --------------
       // make the call
       skipCopy = *OFF;
       retSize = ileSzRet(piReturn);
       if ipcDoTest() < 1 and rc = *ON;
        perfAdd(PERF_XML_SERVER_PGM_CALL1);
        // --------------
        // log if enabled (1.7.1)
        piSize = ileSzParm(piParm);
        perfLogHex(PERF_LOG_L_PARM1:piParm:piSize);
        // --------------
        // call PGM or SRVPGM (opm or modern)
        if myNode.xmlCallAs = XML_FUNC_PGM;
         byVal = *OFF;
         if myNode.pgmOPMMem = XML_PGM_OPM_TRUE;
           rc = ilePGM(mypgm:mylib:piReturn);
         else;
           rc = PasePGM32(mypgm:mylib:piReturn:byVal);
         endif;
        else;
         if myNode.pgmOPMMem = XML_PGM_OPM_TRUE;
           rc = ileSRV(mypgm:mylib:myfunc:piReturn:retSize);
         else;
           rc = PaseSRV32(mypgm:mylib:myfunc:piReturn:retSize);
         endif;
        endif;
        if rc = *OFF;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
         errsSevere(XML_ERROR_RUNPGM_FAIL:ooHint);
         rc = *OFF;
        endif;
        // --------------
        // log if enabled (1.7.1)
        perfLogHex(PERF_LOG_L_PARM2:piParm:piSize);
        perfAdd(PERF_XML_SERVER_PGM_CALL2);
       endif;

       scacElemKey = 0;

       // copy out slow
       perfAdd(PERF_XML_SERVER_PGM_COPYOUT1);


       // <pgm name='z' [lib='z' func='z']>...
       // ooooooooooooooooooooooooooooooooo
       xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*ON:isNada);
       // starting here output
       piErrFast = sOutPtr;

       if skipCopy = *OFF and rc = *ON;

        // --------------
        // set ILE parm builder
        rc = ileStatic(myNode.pgmOPMMem);

        // --------------
        // copy out
        pTop = aDataVal1;
        pNxt = aDataVal1;
        pLst = aDataVal2;
        elem(1) = 'parm';
        elem(2) = 'return';
        elem(3) = 'overlay';
        dou pNxt = *NULL or rc = *OFF;
         pTop = pNxt;
         i = cacScanXML(aVeryTop:pTop:pB1:pB2:pD1:pD2:pE1:pE2:pNxt
                       :doNada:doCDATA:findElem:keyElem);
         if i = 0;
           findElem = bigElem(pTop:pLst:elem:doNest
                    :doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         endif;
         select;
         // <(/)junk> ... </junk>
         //           ... EOF
         // B             E
         when findElem = 0;
           // < ... > ... <
           // oooooooooooo
           string = pB1;
           stringLen = pNxt - pB1;
           xmlOutput(string:stringLen:*OFF);
         // <parm ...> ... </parm>
         // B        1    2      E
         when findElem = 1;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           myNode.xmlBy           = XML_BY_REF;
           myNode.xmlPrmRet       = XML_IS_PARM;
           rc = xmlWrkParm('O':doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
         // <return ...> ... </return>
         // B           1   2        E
         when findElem = 2;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           myNode.xmlBy           = XML_BY_VAL;
           myNode.xmlPrmRet       = XML_IS_RETURN;
           rc = xmlWrkRet('O':doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
         // <overlay ...> ... </overlay>
         // B            1   2         E
         when findElem = 3;
           if i = 0;
             pTop = pB1;
             whereElem = cacAddXML(aVeryTop:pTop:pB1:pB2
                      :pD1:pD2:pE1:pE2:pNxt
                      :doNada:doCDATA:findElem:keyElem:*ON);
           endif;
           myNode.xmlBy           = XML_BY_MBR; // 1.6.8
           rc = xmlWrkOver('O':doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
         // better hint 1.6.9
         if myNode.pgmValErr = XML_PGM_ERROR_TRUE or rc = *OFF;
           perfAdd(PERF_XML_SERVER_RUN_ERROR);
           errsSevere(XML_ERROR_COPYOUT_FAIL:ooHint);
           xmlCpyErr(rc:0:'O':doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
           rc = *OFF;
         endif;
        enddo;

       endif;
       perfAdd(PERF_XML_SERVER_PGM_COPYOUT2);

       On-error;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
         errsSevere(XML_ERROR_RUNPGM_EXCEPTION:ooHint);
         rc = *OFF;
       Endmon;

       // script not going to stop,
       // remove output occurred
       if rc = *OFF and myStopOn = *OFF;
          // clear starting output
          stringLen = piErrFast - sOutPtr;
          if stringLen > 0;
            memset(piErrFast:x'00':stringLen);
          endif;
          // <pgm .... >...error...</pgm>
          //            ooooooooooo
          sOutPtr = piErrFast;
       endif;

       // <pgm>success-or-fail ...</pgm>
       //      ooooooooooooooooooo
       ooHint = %trim(mylib) + ' ' + %trim(mypgm) + ' ' + %trim(myfunc) + ' ';
       string = %addr(ooHint);
       stringLen = %len(%trim(ooHint)) + 1;
       xmlOutRet(myStopOn:rc:*ON:string:stringLen:myJobLog);

       // </pgm>...
       // oooooo
       xmlOutput(%addr(ooEndPgm):6:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;

      /end-free
     P                 E

      *****************************************************
      * xml shell
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlDoSh         B
     D xmlDoSh         PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
      * vars
     D ooEndSh         s             10A   inz('</sh>')
     d rc              s              1N   inz(*OFF)
     d rc1             s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     d isRows          s              1N   inz(*OFF)
     D keepBottom      s              1N   inz(*OFF)
     D result          s             64A   inz(*BLANKS)
     d maxSz           s             10i 0 inz(0)
     d retSz           s             10i 0 inz(0)
     D ooHint          s            512A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
     d pBeg            s               *   inz(*NULL)
     d pEnd            s               *   inz(*NULL)
     D myCmd           S          65000A   inz(*BLANKS)
     D myData          S          65000A   inz(*BLANKS)
     d myDataLen       s             10i 0 inz(0)
     D modeHexFnd      s              1N   inz(*OFF)
     D ccsidFndB       s              1N   inz(*OFF)
     D ccsidFndA       s              1N   inz(*OFF)
     d srcLen          s             10i 0 inz(0)
     d outLen          s             10i 0 inz(0)
     D hex1st          s              1N   inz(*OFF)
     D outHackI        S             10i 0 inz(0)
     D outHackP        S               *   inz(*NULL)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free
       Monitor;

       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <sh [rows='on|off']  error='on|off|fast'>
       //       hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1']>
       //       ---- handled by xmlWrkVal ----
       // -- or --
       // <sh [rows="on|off"]  error="on|off|fast">
       //      1               2
       //       hex="on" before="cc1/cc2/cc3/cc4" after="cc4/cc3/cc2/cc1"]>
       //       ---- handled by xmlWrkVal ----
       search(1) = 'rows';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // rows="on|off"
           if 'on' = %str(pValue(1):2);
             isRows=*ON;
           endif;
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // --------------
       // set ILE parm builder
       // make sure pase started
       rc = ileStatic(XML_PGM_OPM_FALSE);
       if rc = *OFF;
         return *OFF;
       endif;


       // <sh [rows='on|off']>...</sh>
       // oooooooooooooooooooo
       string = aElemTop1;
       stringLen = aElemTop2 - aElemTop1 + 1;
       xmlOutput(string:stringLen:*ON:isNada);

       // --------------
       // make the call
       // <sh [rows='on|off']>...</sh>
       //                     ooo
       // string = aDataVal1;
       // stringLen = aDataVal2 - aDataVal1 + 1;
       outLen = %size(myCmd);
       rc1 = xmlWrkVal('I':isNada:isCDATA:*NULL
              :aElemTop1:aElemTop2:aDataVal1:aDataVal2
              :aElemEnd1:aElemEnd2:aElemNext:*OFF:*ON
              :%addr(myCmd):modeHexFnd:ccsidFndB:ccsidFndA
              :srcLen:outLen);
       string = %addr(myCmd);
       stringLen = outLen;

       // --------------
       // log if enabled (1.7.1)
       perfLogAdd(PERF_LOG_L_SH + ' ' + %trim(myCmd));

       // <sh [rows='on|off']>... good output ...</sh>
       //                     ooooooooooooooooooo
       maxSz = xmlOutRoom();
       pBeg = sOutPtr;
       rc = xmlExec32(string:stringLen
                     :isRows:keepBottom:isCDATA
                     :sOutPtr:maxSz:retSz:*OFF);
       sOutPtr += retSz;
       // failed
       if rc = *OFF and retSz < 1;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
         errsWarning(XML_ERROR_RUNSH_FAIL:sHint);
         // <sh [rows='on|off']>... bad output ...</sh>
         //                     oooooooooooooooooo
         if retSz < 1;
           xmlOutRet(myStopOn:rc:isCDATA:string:stringLen:myJobLog);
         endif;
       // hex convert or ccsid after will require buffer
       elseif modeHexFnd = *ON or ccsidFndA = *ON;
         sOutPtr = pBeg;
         outHackI = cacAddBig(retSz + 1:CAC_HEAP_ILE_TMP);
         outHackP = cacScanBig(outHackI);
         cpybytes(outHackP:sOutPtr:retSz);
         aDataVal1 = outHackP;
         aDataVal2 = outHackP + retSz;
         outLen = retSz * 2 + 64;
         rc1 = xmlWrkVal('O':isNada:isCDATA:*NULL
              :aElemTop1:aElemTop2:aDataVal1:aDataVal2
              :aElemEnd1:aElemEnd2:aElemNext:modeHexFnd:*OFF
              :sOutPtr:modeHexFnd:ccsidFndB:ccsidFndA
              :srcLen:outLen);
         sOutPtr += outLen;
       endif;

       On-error;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
         errsWarning(XML_ERROR_RUNSH_EXCEPTION:sHint);
         rc = *OFF;
       Endmon;

       // </sh>...
       // ooooo
       xmlOutput(%addr(ooEndSh):5:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml shell
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlDoQsh        B
     D xmlDoQsh        PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
      * vars
     D ooEndQsh        s             10A   inz('</qsh>')
     d rc              s              1N   inz(*OFF)
     d rc1             s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     d isRows          s              1N   inz(*OFF)
     D keepBottom      s              1N   inz(*OFF)
     D result          s             64A   inz(*BLANKS)
     d maxSz           s             10i 0 inz(0)
     d retSz           s             10i 0 inz(0)
     D ooHint          s            512A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
     d pBeg            s               *   inz(*NULL)
     d pEnd            s               *   inz(*NULL)
     D myCmd           S          65000A   inz(*BLANKS)
     D myData          S          65000A   inz(*BLANKS)
     d myDataLen       s             10i 0 inz(0)
     D modeHexFnd      s              1N   inz(*OFF)
     D ccsidFndB       s              1N   inz(*OFF)
     D ccsidFndA       s              1N   inz(*OFF)
     d srcLen          s             10i 0 inz(0)
     d outLen          s             10i 0 inz(0)
     D hex1st          s              1N   inz(*OFF)
     D outHackI        S             10i 0 inz(0)
     D outHackP        S               *   inz(*NULL)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free
       Monitor;

       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <qsh [rows='on|off']  error='on|off|fast'>
       //       hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1']>
       //       ---- handled by xmlWrkVal ----
       // -- or --
       // <qsh [rows="on|off"]  error="on|off|fast">
       //      1               2
       //       hex="on" before="cc1/cc2/cc3/cc4" after="cc4/cc3/cc2/cc1"]>
       //       ---- handled by xmlWrkVal ----
       search(1) = 'rows';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // rows="on|off"
           if 'on' = %str(pValue(1):2);
             isRows=*ON;
           endif;
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // --------------
       // set ILE parm builder
       rc = ileStatic(XML_PGM_OPM_TRUE);
       if rc = *OFF;
         return *OFF;
       endif;


       // <qsh [rows='on|off']>...</sh>
       // oooooooooooooooooooo
       string = aElemTop1;
       stringLen = aElemTop2 - aElemTop1 + 1;
       xmlOutput(string:stringLen:*ON:isNada);

       // --------------
       // make the call
       // <qsh [rows='on|off']>...</sh>
       //                     ooo
       // string = aDataVal1;
       // stringLen = aDataVal2 - aDataVal1 + 1;
       outLen = %size(myCmd);
       rc1 = xmlWrkVal('I':isNada:isCDATA:*NULL
              :aElemTop1:aElemTop2:aDataVal1:aDataVal2
              :aElemEnd1:aElemEnd2:aElemNext:*OFF:*ON
              :%addr(myCmd):modeHexFnd:ccsidFndB:ccsidFndA
              :srcLen:outLen);
       string = %addr(myCmd);
       stringLen = outLen;

       // --------------
       // log if enabled (1.7.1)
       perfLogAdd(PERF_LOG_L_SH + ' ' + %trim(myCmd));

       // <qsh [rows='on|off']>... good output ...</sh>
       //                     ooooooooooooooooooo
       maxSz = xmlOutRoom();
       pBeg = sOutPtr;
       rc = xmlExec32(string:stringLen
                     :isRows:keepBottom:isCDATA
                     :sOutPtr:maxSz:retSz:*ON);
       sOutPtr += retSz;
       // failed
       if rc = *OFF and retSz < 1;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
         errsWarning(XML_ERROR_RUNSH_FAIL:sHint);
         // <qsh [rows='on|off']>... bad output ...</sh>
         //                     oooooooooooooooooo
         if retSz < 1;
           xmlOutRet(myStopOn:rc:isCDATA:string:stringLen:myJobLog);
         endif;
       // hex convert or ccsid after will require buffer
       elseif modeHexFnd = *ON or ccsidFndA = *ON;
         sOutPtr = pBeg;
         outHackI = cacAddBig(retSz + 1:CAC_HEAP_ILE_TMP);
         outHackP = cacScanBig(outHackI);
         cpybytes(outHackP:sOutPtr:retSz);
         aDataVal1 = outHackP;
         aDataVal2 = outHackP + retSz;
         outLen = retSz * 2 + 64;
         rc1 = xmlWrkVal('O':isNada:isCDATA:*NULL
              :aElemTop1:aElemTop2:aDataVal1:aDataVal2
              :aElemEnd1:aElemEnd2:aElemNext:modeHexFnd:*OFF
              :sOutPtr:modeHexFnd:ccsidFndB:ccsidFndA
              :srcLen:outLen);
         sOutPtr += outLen;
       endif;

       On-error;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
         errsWarning(XML_ERROR_RUNSH_EXCEPTION:sHint);
         rc = *OFF;
       Endmon;

       // </qsh>...
       // ooooo
       xmlOutput(%addr(ooEndQsh):6:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml command
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlDoCmd        B
     D xmlDoCmd        PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
      * vars
     D ooEndCmd        s             10A   inz('</cmd>')
     d rc              s              1N   inz(*OFF)
     d rc1             s              1N   inz(*OFF)
     d string          s               *
     d stringLen       s             10i 0
     D little          s             30A   inz(*BLANKS)
     D result          s             64A   inz(*BLANKS)
     d isSystem        s              1N   inz(*OFF)
     d isRexx          s              1N   inz(*OFF)
     D myCmd           S          65000A   inz(*BLANKS)
     D myRaw           S          65000A   inz(*BLANKS)
     D myData          S          65000A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*ON)
     D ooHint          s            512A   inz(*BLANKS)
     D modeHexFnd      s              1N   inz(*OFF)
     D ccsidFndB       s              1N   inz(*OFF)
     D ccsidFndA       s              1N   inz(*OFF)
     d srcLen          s             10i 0 inz(0)
     d outLen          s             10i 0 inz(0)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <cmd [exec='cmd|system|rexx' error='on|off|fast'
       //       1                      2
       //       hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1']>
       //       ---- handled by xmlWrkVal ----
       // -- or --
       // <cmd [exec="cmd|system|rexx" error="on|off|fast"
       //       1                      2
       //       hex="on" before="cc1/cc2/cc3/cc4" after="cc4/cc3/cc2/cc1"]>
       //       ---- handled by xmlWrkVal ----
       search(1) = 'exec';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // exec="cmd|system"
           if 'sys' = %str(pValue(1):3);
             isSystem=*ON;
           elseif 'rex' = %str(pValue(1):3);
             isRexx=*ON;
           endif;
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // <cmd ...>...</cmd>
       // ooooooooo
       string = aElemTop1;
       stringLen = aElemTop2 - aElemTop1 + 1;
       xmlOutput(string:stringLen:*OFF:isNada);

       // --------------
       // make the call
       outLen = %size(myCmd);
       rc1 = xmlWrkVal('I':isNada:isCDATA:*NULL
              :aElemTop1:aElemTop2:aDataVal1:aDataVal2
              :aElemEnd1:aElemEnd2:aElemNext:*OFF:*ON
              :%addr(myCmd):modeHexFnd:ccsidFndB:ccsidFndA
              :srcLen:outLen);
       string = %addr(myCmd);
       stringLen = outLen;

       // --------------
       // log if enabled (1.7.1)
       perfLogAdd(PERF_LOG_L_CMD + ' ' + %trim(myCmd));

       if isSystem = *ON;
         rc = ileSystem(string:stringLen);
       elseif isRexx = *ON;
         rc = ileRexx(xmlGetCDATA():string:stringLen:myRaw);
         aDataVal1 = %addr(myRaw);
         aDataVal2 = aDataVal1 + %len(%trim(myRaw));
         outLen = %size(myData);
         rc1 = xmlWrkVal('O':isNada:isCDATA:*NULL
              :aElemTop1:aElemTop2:aDataVal1:aDataVal2
              :aElemEnd1:aElemEnd2:aElemNext:*ON:*OFF
              :%addr(myData):modeHexFnd:ccsidFndB:ccsidFndA
              :srcLen:outLen);
       else;
         rc = ileCmdExc(string:stringLen);
       endif;
       if rc = *ON;
         // may have changed job CCSID (1.6.8)
         xmlResetCDATA();
       else;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
         ooHint = %str(string:stringLen);
         errsWarning(XML_ERROR_RUNCMD_FAIL:ooHint);
       endif;

       // <cmd>success-or-fail ...</cmd>
       //      ooooooooooooooooooo
       xmlOutRet(myStopOn:rc:isCDATA:string:stringLen:myJobLog);

       // <row><data>...</data></row>
       // ooooooooooooooooooooooooooo
       if  isRexx = *ON;
         string = %addr(myData);
         stringLen = %len(%trim(myData));
         if stringlen > 0;
           xmlOutput(string:stringLen:*OFF);
         endif;
       endif;

       // </cmd>...
       // oooooo
       xmlOutput(%addr(ooEndCmd):6:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E


      * +++++++++++++++++++++++++++++++++++++++++++++++++++
      * xml SQL
      * +++++++++++++++++++++++++++++++++++++++++++++++++++


      *****************************************************
      * xml system supplied labels
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlLab       B
     D xmlSqlLab       PI
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  op                            1A   value
     D  myConn                       10A   value
     D  myStmt                       10A   value
     D  isConn                        1N
     D  isStmt                        1N
      * vars
     D result          s             64A   inz(*BLANKS)
      /free
       if xmlGetCDATA() = *ON;
         isCDATA = *ON;
       endif;
       select;
       when op = XML_ELEMENT_OPEN;
         if myConn = *BLANKS;
           isConn = *OFF;
         else;
           isConn = *ON;
         endif;
         if myStmt = *BLANKS;
           isStmt = *OFF;
         else;
           isStmt = *ON;
         endif;
         if isNada = *OFF;
           // <operation ...>...
           // oooooooooooooo
           xmlOutput(aElemTop1:aElemTop2 - aElemTop1:*OFF:*OFF);
         else;
           // <operation .../>...
           // oooooooooooooo
           xmlOutput(aElemTop1:aElemTop2 - aElemTop1 - 1:*OFF:*OFF);
         endif;
       when op = XML_ELEMENT_CONN
         or op = XML_ELEMENT_STMT
         or op = XML_ELEMENT_BOTH;
         if isConn = *OFF and myConn<>*BLANKS
         and (op = XML_ELEMENT_CONN or op = XML_ELEMENT_BOTH);
           // <operation ... conn='label'>...
           //               ooooooooooooo
           result = ' conn=''' + %trim(myConn) + '''';
           xmlOutput(%addr(result):%len(%trim(result))+1:*OFF:*OFF);
         endif; 
         if isStmt = *OFF and myStmt<>*BLANKS
         and (op = XML_ELEMENT_STMT or op = XML_ELEMENT_BOTH);
           // <operation ... stmt='label'>...
           //               ooooooooooooo
           result = ' stmt=''' + %trim(myStmt) + '''';
           xmlOutput(%addr(result):%len(%trim(result))+1:*OFF:*OFF);
         endif; 
       when op = XML_ELEMENT_CLOSE;
          // <operation ...>...
          //               o
          result = '>';
          xmlOutput(%addr(result):%len(%trim(result)):*ON:*OFF);
       when op = XML_ELEMENT_CLOSE_NOLF;
          // <operation ...>...
          //               o
          result = '>';
          xmlOutput(%addr(result):%len(%trim(result)):*OFF:*OFF);
       // other?
       other;
       endsl;
      /end-free
     P                 E

      *****************************************************
      * xml Opts
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlOpts      B
     D xmlSqlOpts      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndOpts       s             10A   inz('</options>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myOpts          s             10A   inz(*BLANKS)
     D setoptions      s           1024A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*ON)
     D myJobLog        s              1N   inz(*ON)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <options [options='label' ... error='on|off|fast'] />
       //           1                   2
       search(1) = 'options';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // options='label'
           myOpts = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;
       // <options [options='label' ... />
       //         1                      2
       if aElemTop2 - (aElemTop1 + 8) > 5;
         // <options [options='label' ... />
         //         1                     2
         if isNada = *ON;
           setoptions = %str(aElemTop1 + 8:aElemTop2 - (aElemTop1 + 9));
         // <options [options='label' ... >
         //         1                     2
         else;
           setoptions = %str(aElemTop1 + 8:aElemTop2 - (aElemTop1 + 8));
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <options ...>...
       // ooooooooooooo
       xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*OFF:isNada);

       // -----------
       // SQL call
       rc = sql_options_setup(myOpts:setoptions);

       // <options>success-or-fail ...</options>
       //          ooooooooooooooooooo
       string = %addr(myOpts);
       stringLen = %len(%trim(myOpts));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </options>...
       // oooooooooo
       xmlOutput(%addr(ooEndOpts):10:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Conn
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlConn      B
     D xmlSqlConn      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndConn       s             10A   inz('</connect>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDb            s             10A   inz(*BLANKS)
     D myUid           s             10A   inz(*BLANKS)
     D myPwd           s             10A   inz(*BLANKS)
     D myOpt           s             10A   inz(*BLANKS)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <connect [conn='label' db='x' uid='x' pwd='x' options='label']/>
       //           1            2      3       4       5
       search(1) = 'conn';
       search(2) = 'db';
       search(3) = 'uid';
       search(4) = 'pwd';
       search(5) = 'options';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // db='x'
           myDb   = %str(pValue(2):valueLen(2));
         endif;
         if valueLen(3) <> 0; // uid='x'
           myUid  = %str(pValue(3):valueLen(3));
         endif;
         if valueLen(4) <> 0; // pwd='x'
           myPwd  = %str(pValue(4):valueLen(4));
         endif;
         if valueLen(5) <> 0; // options='label'
           myOpt  = %str(pValue(5):valueLen(5));
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <connect ...>...
       // oooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_connect(myConn:myOpt:myDB:myUid:myPWd:sqlCode);
       perfLogAdd(PERF_LOG_L_CONNECT
                 + ' ' + %trim(myConn) 
                 + ' ' + %trim(myDB) 
                 + ' ' + %trim(myUid) 
                 + ' ' + %char(sqlCode));

       // <connect ... conn='label'>...
       //             ooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
       // <connect ...>...
       //             o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE_NOLF:myConn:*BLANKS:isConn:isStmt);

       // <connect>success-or-fail ...</connect>
       //          ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(*ON:rc:*OFF:string:stringLen);

       // </connect>...
       // oooooooooo
       xmlOutput(%addr(ooEndConn):10:*ON);

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Qry
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlQry       B
     D xmlSqlQry       PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndQry        s             10A   inz('</query>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t)
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myStmt          s             10A   inz(*BLANKS)
     D myOpt           s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*ON)
     D myJobLog        s              1N   inz(*ON)
      * sql statement
     D  stmt_str       s               *   inz(*NULL)
     D  stmt_len       s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
     D cpysome         s             32A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <query conn='label' [stmt='label' error='on|off|fast' options='label']>
       //        1             2            3              4
       search(1) = 'conn';
       search(2) = 'stmt';
       search(3) = 'error';
       search(4) = 'options';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // stmt='label'
           myStmt = %str(pValue(2):valueLen(2));
         endif;
         if valueLen(3) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(3):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(3):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(3):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
         if valueLen(4) <> 0; // options='label'
           myOpt = %str(pValue(4):valueLen(4));
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <query ...>...
       // oooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:myStmt:isConn:isStmt);

       // -----------
       // SQL call
       stmt_str  = aDataVal1;
       stmt_len  = aDataVal2 - aDataVal1 + 1;
       rc = sql_query(myConn:stmt_str:stmt_len:myStmt:myOpt:sqlCode);
       perfLogAdd(PERF_LOG_L_QUERY
                 + ' ' + %trim(myConn) 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode) 
                 + ' ' + %str(stmt_str:stmt_len));
       // <query ... conn='label' stmt='label'>...
       //           oooooooooooooooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_BOTH:myConn:myStmt:isConn:isStmt);
       // <query ...>...
       //           o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:myStmt:isConn:isStmt);

       // <query>success-or-fail ...</query>
       //        ooooooooooooooooooo
       string = stmt_str;
       stringLen = stmt_len;
       xmlOutRet(myStopOn:rc:*ON:string:stringLen:myJobLog);
       if rc = *OFF;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
       endif;

       // </query>...
       // oooooooooo
       xmlOutput(%addr(ooEndQry ):8:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Prep
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlPrep      B
     D xmlSqlPrep      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndPrep       s             10A   inz('</prepare>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myStmt          s             10A   inz(*BLANKS)
     D myOpt           s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*ON)
     D myJobLog        s              1N   inz(*ON)
      * sql statement
     D  stmt_str       s               *   inz(*NULL)
     D  stmt_len       s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
     D cpysome         s             32A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <prepare [conn='label' stmt='label' error='on|off|fast' options='label'] >
       //        1               2            3                   4
       search(1) = 'conn';
       search(2) = 'stmt';
       search(3) = 'error';
       search(4) = 'options';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // stmt='label'
           myStmt = %str(pValue(2):valueLen(2));
         endif;
         if valueLen(3) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(3):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(3):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(3):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
         if valueLen(4) <> 0; // options='label'
           myOpt = %str(pValue(4):valueLen(4));
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <prepare ...>...
       // oooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:myStmt:isConn:isStmt);

       // -----------
       // SQL call
       stmt_str  = aDataVal1;
       stmt_len  = aDataVal2 - aDataVal1 + 1;
       rc = sql_prepare(myConn:stmt_str:stmt_len:myStmt:myOpt:sqlCode);
       perfLogAdd(PERF_LOG_L_PREPARE 
                 + ' ' + %trim(myConn) 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode) 
                 + ' ' + %str(stmt_str:stmt_len));
       // <prepare ... conn='label' stmt='label'>...
       //             oooooooooooooooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_BOTH:myConn:myStmt:isConn:isStmt);
       // <prepare ...>...
       //             o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:myStmt:isConn:isStmt);

       // <prepare>success-or-fail ...</prepare>
       //          ooooooooooooooooooo
       string = stmt_str;
       stringLen = stmt_len;
       xmlOutRet(myStopOn:rc:*ON:string:stringLen:myJobLog);
       if rc = *OFF;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
       endif;

       // </prepare>...
       // oooooooooo
       xmlOutput(%addr(ooEndPrep):10:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Parm
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlParm      B
     D xmlSqlParm      PI             1N
     D   op                           1A   value
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
     D   stmt                        10A
     D   sqlCode                     10I 0
     D   colNbr                      10i 0
     D   sqlParm                           likeds(hBind_t)
      * vars
     D ooEndParm       s             10A   inz('</parm>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myIO            s              1A   inz(XML_IO_BOTH)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <parm [io='in|out|both'>
       // -- or --
       // <parm [io="in|out|both">
       //        1
       search(1) = 'io';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // io='in|out|both'
           if 'in' = %str(pValue(1):2);
             myIO = XML_IO_INPUT;
           elseif 'out' = %str(pValue(1):3);
             myIO = XML_IO_OUTPUT;
           endif;
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <parm ...>...
       // oooooooooo
       if op = 'O' and myIO <> XML_IO_INPUT;
         xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*ON:isNada);
       endif;

       // -----------
       // SQL call
       if op = 'I';
         if isNada = *OFF; 
           sqlParm.rawP = aDataVal1;
           sqlParm.rawlen = aDataVal2 - aDataVal1 + 1;
           sqlParm.rawIO = myIO;
         endif; 
         rc = *ON;
       elseif op = 'O';
         // <parm>...</parm>
         //       ooo
         rc=sql_fetch_parm(stmt:sqlCode:colNbr:sOutPtr:sqlParm);
       endif;

       // </parm>...
       // ooooooo
       if op = 'O' and myIO <> XML_IO_INPUT;
         xmlOutput(%addr(ooEndParm):7:*ON);
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Exec
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlExec      B
     D xmlSqlExec      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D i               s             10i 0 inz(0)
     D ooEndExec       s             10A   inz('</execute>')
     D rc              s              1N   inz(*OFF)
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myStmt          s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*ON)
     D myJobLog        s              1N   inz(*ON)
      * sql statement
     D  stmt_str       s               *   inz(*NULL)
     D  stmt_len       s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
     D cpysome         s             32A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     D  sqlParm1       s               *   inz(%addr(sqlParm))
     D myNode          ds                  likeds(xmlNode_t) 
      * search elements
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <execute stmt='label' error="on|off|fast">
       //          1            2
       search(1) = 'stmt';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // stmt='label'
           myStmt = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <execute ...>...
       // oooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:*BLANKS:myStmt:isConn:isStmt);

       // ------
       // <parm> - input
       // ------

       // --------------
       // set ILE parm builder
       rc = ileStatic(XML_PGM_OPM_TRUE);
       if rc = *OFF;
         return *OFF;
       endif;

       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myStmt:sqlCode:i:sqlParm(i));
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // -----------
       // SQL call
       rc = sql_execute(myStmt:sqlCode:sqlParm1);
       perfLogAdd(PERF_LOG_L_EXECUTE 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
       // <execute ... stmt='label'>...
       //             ooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_STMT:*BLANKS:myStmt:isConn:isStmt);
       // <execute ...>...
       //             o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:*BLANKS:myStmt:isConn:isStmt);

       // <execute>success-or-fail ...</execute>
       //          ooooooooooooooooooo
       string = %addr(myStmt);
       stringLen = %len(%trim(myStmt));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // ------
       // <parm> - output
       // ------

       // --------------
       // set ILE parm builder
       rc = ileStatic(XML_PGM_OPM_TRUE);
       if rc = *OFF;
         perfAdd(PERF_XML_SERVER_RUN_ERROR);
         return *OFF;
       endif;

       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('O':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myStmt:sqlCode:i:sqlParm(i));
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // </execute>...
       // oooooooooo
       xmlOutput(%addr(ooEndExec):10:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E
      *****************************************************
      * xml Comm
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlComm      B
     D xmlSqlComm      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndComm       s             10A   inz('</commit>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myRoll          s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*ON)
     D myJobLog        s              1N   inz(*ON)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
     D cpysome         s             32A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <commit conn='label' [action='rollback' error="on|off|fast" ]/>
       //         1             2                 3
       search(1) = 'conn';
       search(2) = 'action';
       search(3) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // action='rollback'
           myRoll = %str(pValue(2):valueLen(2));
         endif;
         if valueLen(3) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(3):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(3):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(3):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <commit ...>...
       // ooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       // SQL call
       if myRoll = 'rollback';
         rc = sql_end_transaction(myConn:*ON);
       else;
         rc = sql_end_transaction(myConn:*OFF);
       endif;
       perfLogAdd(PERF_LOG_L_COMMIT
                 + ' ' + %trim(myConn));

       // <commit ... conn='label'>...
       //            ooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
       // <commit ...>...
       //            o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE_NOLF:myConn:*BLANKS:isConn:isStmt);

       // <commit>success-or-fail ...</commit>
       //         ooooooooooooooooooo
       string = %addr(myRoll);
       stringLen = %len(%trim(myRoll));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </commit>...
       // ooooooooo
       xmlOutput(%addr(ooEndComm):9:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Ftch
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlFtch      B
     D xmlSqlFtch      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndFtch       s             10A   inz('</fetch>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myStmt          s             10A   inz(*BLANKS)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myRec           s             10i 0 inz(0)
     D myDesc          s              1N   inz(*ON)
     D myStopOn        s              1N   inz(*ON)
     D myJobLog        s              1N   inz(*ON)
      * sql
     D  sqlCode        s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
     D cpysome         s             32A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <fetch stmt='label' [block='all|n' rec='n' desc='on|off' error='on|off|fast']>
       //        1             2             3        4            5
       search(1) = 'stmt';
       search(2) = 'block';
       search(3) = 'rec';
       search(4) = 'desc';
       search(5) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // stmt='label'
           myStmt = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // block='x'
           if 'al' = %str(pValue(2):2);
             myBlock = SQLMAXFETCH;
           else;
             myBlock = %int(%str(pValue(2):valueLen(2)));
           endif;
         endif;
         if valueLen(3) <> 0; // block='x'
           myRec = %int(%str(pValue(3):valueLen(3)));
         endif;
         if valueLen(4) <> 0; // desc='on|off'
           if 'of' = %str(pValue(4):2);
             myDesc = *OFF;
           endif;
         endif;
         if valueLen(5) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(5):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(5):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(5):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <fetch ...>...
       // oooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:*BLANKS:myStmt:isConn:isStmt);
       if isStmt = *OFF;
         rc = sql_active_any(SQL_ACTIVE_STMT:myStmt);
         if rc = *ON;
           // <fetch ... stmt='label'>...
           //           ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_STMT:*BLANKS:myStmt:isConn:isStmt);
         endif;
       endif;
       // <fetch ...>...
       //           o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:*BLANKS:myStmt:isConn:isStmt);

       // -----------
       // SQL call
       // <row><data desc='NAME'>Rip</data><data desc='ID'>9</data></row>
       // ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
       rc = sql_fetch(myStmt:myBlock:myRec:myDesc:sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_FETCH 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));

       // <fetch>success-or-fail ...</fetch>
       //        ooooooooooooooooooo
       string = %addr(myStmt);
       stringLen = %len(%trim(myStmt));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </fetch>...
       // oooooooo
       xmlOutput(%addr(ooEndFtch):8:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml RCnt
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlRCnt      B
     D xmlSqlRCnt      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndRCnt       s             15A   inz('</rowcount>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myStmt          s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*OFF)
      * sql
     D  count          s             10I 0 inz(0)
     D  sqlCode        s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <rowcount stmt='label' [error='on|off']>
       //        1                2
       search(1) = 'stmt';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // stmt='label'
           myStmt = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
           endif;
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <rowcount ...>...
       // ooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:*BLANKS:myStmt:isConn:isStmt);
       if isStmt = *OFF;
         rc = sql_active_any(SQL_ACTIVE_STMT:myStmt);
         if rc = *ON;
           // <rowcount ... stmt='label'>...
           //              ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_STMT:*BLANKS:myStmt:isConn:isStmt);
         endif;
       endif;
       // <rowcount ...>...
       //              o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE_NOLF:*BLANKS:myStmt:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_row_count(myStmt:count:sqlCode);
       perfLogAdd(PERF_LOG_L_COUNT 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(count));

       // <rowcount>num</rowcount>
       //           ooo
       string = %addr(result);
       result = %char(count);
       stringLen = %len(%trim(result));
       xmlOutput(string:stringLen:*OFF);

       // </rowcount>...
       // ooooooooooo
       xmlOutput(%addr(ooEndRCnt):11:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml LsId
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlLsId      B
     D xmlSqlLsId      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndLsId       s             15A   inz('</identity>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*OFF)
      * sql
     D  count          s             10I 0 inz(0)
     D  sqlCode        s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <identity [conn='label' error='on|off'/>
       //        1                2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
           endif;
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <identity ...>...
       // ooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <identity ... conn='label'>...
           //              ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <identity ...>...
       //              o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE_NOLF:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       // <identity ...>2345</identity>...
       //               oooo
       rc = sql_last_insert_id(myConn:sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_LASTID 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode));

       // </identity>...
       // ooooooooooo
       xmlOutput(%addr(ooEndLsId):11:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml CDesc
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlCDesc     B
     D xmlSqlCDesc     PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndCDesc      s             15A   inz('</count>')
     D ooColBDesc      s             15A   inz('<colcount>')
     D ooColEDesc      s             15A   inz('</colcount>')
     D ooParmBDesc     s             15A   inz('<parmcount>')
     D ooParmEDesc     s             15A   inz('</parmcount>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myStmt          s             10A   inz(*BLANKS)
     D myDesc          s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*OFF)
      * sql
     D  nCols          s              5I 0 inz(0)
     D  nParms         s              5I 0 inz(0)
     D  sqlCode        s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <count stmt='label' [desc='col|parm|both' error='on|off']>
       //           1             2                    3
       search(1) = 'stmt';
       search(2) = 'desc';
       search(3) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // stmt='label'
           myStmt = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // desc="col|parm|both"
           myDesc = %str(pValue(2):valueLen(2));
         endif;
         if valueLen(3) <> 0; // error="on|off"
           if 'on' = %str(pValue(3):3);
             myStopOn = *ON;
           endif;
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <count ...>...
       // ooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:*BLANKS:myStmt:isConn:isStmt);
       if isStmt = *OFF;
         rc = sql_active_any(SQL_ACTIVE_STMT:myStmt);
         if rc = *ON;
           // <count ... stmt='label'>...
           //              ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_STMT:*BLANKS:myStmt:isConn:isStmt);
         endif;
       endif;
       // <count ...>...
       //              o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:*BLANKS:myStmt:isConn:isStmt);

       // -----------
       // SQL call
       if myDesc = 'col';
         rc = sql_col_desc_nbr(myStmt:nCols:sqlCode);
         perfLogAdd(PERF_LOG_L_COL_DESC 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
         // <colcount>...
         // oooooooooo
         xmlOutput(%addr(ooColBDesc):10:*OFF);
         // <colcount>num</colcount>
         //           ooo
         string = %addr(result);
         result = %char(nCols);
         stringLen = %len(%trim(result));
         xmlOutput(string:stringLen:*OFF);
         // </colcount>...
         // ooooooooooo
         xmlOutput(%addr(ooColEDesc):11:*ON);
       elseif myDesc = 'parm';
         rc = sql_parm_desc_nbr(myStmt:nParms:sqlCode);
         perfLogAdd(PERF_LOG_L_PARM_DESC 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
         // <parmcount>...
         // ooooooooooo
         xmlOutput(%addr(ooParmBDesc):11:*OFF);
         // <parmcount>num</parmcount>
         //            ooo
         string = %addr(result);
         result = %char(nParms);
         stringLen = %len(%trim(result));
         xmlOutput(string:stringLen:*OFF);
         // </parmcount>...
         // oooooooooooo
         xmlOutput(%addr(ooParmEDesc):12:*ON);
       else;
         rc = sql_parm_desc_nbr(myStmt:nCols:sqlCode);
         perfLogAdd(PERF_LOG_L_PARM_DESC 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
         rc = sql_col_desc_nbr(myStmt:nParms:sqlCode);
         perfLogAdd(PERF_LOG_L_COL_DESC 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
         // <colcount>...
         // oooooooooo
         xmlOutput(%addr(ooColBDesc):10:*OFF);
         // <colcount>num</colcount>
         //           ooo
         string = %addr(result);
         result = %char(nCols);
         stringLen = %len(%trim(result));
         xmlOutput(string:stringLen:*OFF);
         // </colcount>...
         // ooooooooooo
         xmlOutput(%addr(ooColEDesc):11:*ON);
         // <parmcount>...
         // ooooooooooo
         xmlOutput(%addr(ooParmBDesc):11:*OFF);
         // <parmcount>num</parmcount>
         //           ooo
         string = %addr(result);
         result = %char(nParms);
         stringLen = %len(%trim(result));
         xmlOutput(string:stringLen:*OFF);
         // </parmcount>...
         // oooooooooooo
         xmlOutput(%addr(ooParmEDesc):12:*ON);
       endif;

       // </count>...
       // oooooooo
       xmlOutput(%addr(ooEndCDesc):8:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Desc
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlDesc      B
     D xmlSqlDesc      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</describe>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myStmt          s             10A   inz(*BLANKS)
     D myDesc          s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*OFF)
      * sql
     D  count          s             10I 0 inz(0)
     D  sqlCode        s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <describe stmt='label' [desc='col|parm|both' error='on|off']>
       //           1             2                    3
       search(1) = 'stmt';
       search(2) = 'desc';
       search(3) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // stmt='label'
           myStmt = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // desc="col|parm|both"
           myDesc = %str(pValue(2):valueLen(2));
         endif;
         if valueLen(3) <> 0; // error="on|off"
           if 'on' = %str(pValue(3):3);
             myStopOn = *ON;
           endif;
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <describe ...>...
       // ooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:*BLANKS:myStmt:isConn:isStmt);
       if isStmt = *OFF;
         rc = sql_active_any(SQL_ACTIVE_STMT:myStmt);
         if rc = *ON;
           // <describe ... stmt='label'>...
           //              ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_STMT:*BLANKS:myStmt:isConn:isStmt);
         endif;
       endif;
       // <describe ...>...
       //              o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:*BLANKS:myStmt:isConn:isStmt);

       // -----------
       // SQL call
       if myDesc = 'col';
         rc = sql_fetch_col_desc(myStmt:sOutPtr:sqlCode);
         perfLogAdd(PERF_LOG_L_COL_DESC 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
       elseif myDesc = 'parm';
         rc = sql_fetch_parm_desc(myStmt:sOutPtr:sqlCode);
         perfLogAdd(PERF_LOG_L_PARM_DESC 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
       else;
         rc = sql_fetch_parm_desc(myStmt:sOutPtr:sqlCode);
         perfLogAdd(PERF_LOG_L_PARM_DESC 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
         rc = sql_fetch_col_desc(myStmt:sOutPtr:sqlCode);
         perfLogAdd(PERF_LOG_L_COL_DESC 
                 + ' ' + %trim(myStmt) 
                 + ' ' + %char(sqlCode));
       endif;

       // </describe>...
       // ooooooooooo
       xmlOutput(%addr(ooEndDesc):11:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Free
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlFree      B
     D xmlSqlFree      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndFree       s             10A   inz('</free>')
     D rc              s              1N   inz(*OFF)
     D rc1             s              1N   inz(*OFF)
     D rc2             s              1N   inz(*OFF)
     D rc3             s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myCStmt         s             10A   inz(*BLANKS)
     D myStmt          s             10A   inz(*BLANKS)
     D myOpt           s             10A   inz(*BLANKS)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * sql
     D  sqlCode        s             10I 0 inz(0)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <free [conn='all|label' cstmt='label'
       //        1                2
       //        stmt='all|label' options='all|label'
       //        3                4
       //        error='on|off|fast']>
       //        5
       search(1) = 'conn';
       search(2) = 'cstmt';
       search(3) = 'stmt';
       search(4) = 'options';
       search(5) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // cstmt='label'
           myConn = %str(pValue(2):valueLen(2));
           myCStmt= myConn;
         endif;
         if valueLen(3) <> 0; // stmt='label'
           myStmt = %str(pValue(3):valueLen(3));
         endif;
         if valueLen(4) <> 0; // options='label'
           myOpt = %str(pValue(4):valueLen(4));
         endif;
         if valueLen(5) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(5):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(5):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(5):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // <free ...>...
       // oooooooooo
       xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*OFF:isNada);

       // -----------
       // SQL call
       // <free> - free all
       if myConn = *BLANKS
       and myStmt = *BLANKS
       and myOpt = *BLANKS;
         rc1 = sql_stmt_free_all();
         rc2 = sql_connect_free_all();
         rc3 = sql_options_free_all();
       endif;
       // select type free
       if myConn <> *BLANKS;
         if myConn = 'all';
           rc1 = sql_connect_free_all();
         elseif myCStmt <> *BLANKS;
           rc1 = sql_connect_free_stmts(myConn);
         else;
           rc1 = sql_connect_free(myConn);
         endif;
       endif;
       if myStmt <> *BLANKS;
         if myStmt = 'all';
           rc1 = sql_stmt_free_all();
         else;
           rc2 = sql_stmt_free(myStmt);
         endif;
       endif;
       if myOpt <> *BLANKS;
         if myOpt = 'all';
           rc1 = sql_options_free_all();
         else;
           rc3 = sql_options_free(myOpt);
         endif;
       endif;
       if rc1 = *ON and rc2 = *ON and rc3 = *ON;
         rc = *ON;
       endif;

       // <free>success-or-fail ...</free>
       //       ooooooooooooooooooo
       result = myConn+' '+myStmt+' '+myOpt+' ';
       string = %addr(result);
       stringLen = %len(%trim(result));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </free>...
       // oooooooooo
       xmlOutput(%addr(ooEndFree):7:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml Tables
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlTabl      B
     D xmlSqlTabl      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</tables>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D itable          s            128A   inz(*BLANKS)
     D itype           s            128A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <tables [conn='label' error='on|off|fast'>
       //          1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              itable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 4;
              itype = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <tables ...>...
       // ooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <tables ... conn='label'>...
           //              ooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <table ...>...
       //           o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_tables(myConn
              :iqual:ischema:itable:itype
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_TABLES 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema) 
                 + ' ' + %trim(itable) 
                 + ' ' + %trim(itype));
                 
       // <tables>success-or-fail ...</tables>
       //         ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </tables>...
       // ooooooooo
       xmlOutput(%addr(ooEndDesc):9:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Table privileges
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlTabP      B
     D xmlSqlTabP      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</tablepriv>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D itable          s            128A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <tablepriv [conn='label' error='on|off|fast'>
       //             1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              itable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <tablepriv ...>...
       // oooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <tablepriv ... conn='label'>...
           //               ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <table ...>...
       //           o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_table_privileges(myConn
              :iqual:ischema:itable
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_TABLE_PRIV 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema) 
                 + ' ' + %trim(itable));
                 
       // <tablepriv>success-or-fail ...</tablepriv>
       //            ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </tablepriv>...
       // oooooooooooo
       xmlOutput(%addr(ooEndDesc):12:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml Columns
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlCols      B
     D xmlSqlCols      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</columns>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D itable          s            128A   inz(*BLANKS)
     D icol            s            128A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <columns [conn='label' error='on|off|fast'>
       //           1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              itable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 4;
              icol = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <columns ...>...
       // oooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <columns ... conn='label'>...
           //             ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <columns ...>...
       //             o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_columns(myConn
              :iqual:ischema:itable:icol
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_COLUMNS 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema) 
                 + ' ' + %trim(itable)
                 + ' ' + %trim(icol));

       // <columns>success-or-fail ...</columns>
       //          ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </columns>...
       // oooooooooo
       xmlOutput(%addr(ooEndDesc):10:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml Columns
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlColP      B
     D xmlSqlColP      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</columnpriv>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D itable          s            128A   inz(*BLANKS)
     D icol            s            128A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <columnpriv [conn='label' error='on|off|fast'>
       //              1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              itable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 4;
              icol = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <columnpriv ...>...
       // ooooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <columnpriv ... conn='label'>...
           //                ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <columnpriv ...>...
       //                o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_column_privileges(myConn
              :iqual:ischema:itable:icol
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_COLUMN_PRIV 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema) 
                 + ' ' + %trim(itable)
                 + ' ' + %trim(icol));
                 
       // <columnpriv>success-or-fail ...</columnpriv>
       //             ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </columnpriv>...
       // ooooooooooooo
       xmlOutput(%addr(ooEndDesc):13:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml special columns
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlSpec      B
     D xmlSqlSpec      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</special>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D itable          s            128A   inz(*BLANKS)
     D itemp           s            128A   inz(*BLANKS)
     D iscope          s              5i 0 inz(0)
     D inull           s              1N   inz(*ON)
     D search1         s              3A   inz('row')
     D search2         s              3A   inz('tra')
     D search3         s              3A   inz('ses')
     D search4         s              2A   inz('no')
     D pos1            s             10i 0 inz(0)
     D pos2            s             10i 0 inz(0)
     D pos3            s             10i 0 inz(0)
     D pos4            s             10i 0 inz(0)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <special [conn='label' error='on|off|fast'>
       //              1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              itable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 4;
              itemp = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
              pos1 = %scan(search1:itemp);
              pos2 = %scan(search2:itemp);
              pos3 = %scan(search3:itemp);
              if pos1 > 0;
                iscope = 0;
              elseif pos2 > 0;
                iscope = 1;
              else;
                iscope = 2;
              endif;
            when i = 5;
              itemp = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
              pos4 = %scan(search4:itemp);
              if pos4 > 0;
                inull = *OFF;
              endif;
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <special ...>...
       // ooooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <special ... conn='label'>...
           //                ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <special ...>...
       //                o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_special_columns(myConn
              :iqual:ischema:itable:iscope:inull
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_COLUMN_SPEC 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema) 
                 + ' ' + %trim(itable)
                 + ' ' + %char(iscope));

       // <special>success-or-fail ...</special>
       //          ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </special>...
       // ooooooooooooo
       xmlOutput(%addr(ooEndDesc):13:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Procedures
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlProc      B
     D xmlSqlProc      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</procedures>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D iproc           s            128A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <procedures [conn='label' error='on|off|fast'>
       //             1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              iproc = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <procedures ...>...
       // ooooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <procedures ... conn='label'>...
           //                ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <procedures ...>...
       //                o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_procedures(myConn
              :iqual:ischema:iproc
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_PROCS 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema)
                 + ' ' + %trim(iproc));

       // <procedures>success-or-fail ...</procedures>
       //             ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </procedures>...
       // ooooooooooooo
       xmlOutput(%addr(ooEndDesc):13:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Procedure Columns
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlPCol      B
     D xmlSqlPCol      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</pcolumns>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D iproc           s            128A   inz(*BLANKS)
     D icol            s            128A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <pcolumns [conn='label' error='on|off|fast'>
       //            1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              iproc = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 4;
              icol = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <pcolumns ...>...
       // ooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <pcolumns ... conn='label'>...
           //              ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <pcolumns ...>...
       //              o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_procedure_columns(myConn
              :iqual:ischema:iproc:icol
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_PROC_COL 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema)
                 + ' ' + %trim(iproc)
                 + ' ' + %trim(icol));

       // <pcolumns>success-or-fail ...</pcolumns>
       //           ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </pcolumns>...
       // ooooooooooo
       xmlOutput(%addr(ooEndDesc):11:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml Primary keys
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlPKey      B
     D xmlSqlPKey      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</primarykeys>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D itable          s            128A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <primarykeys [conn='label' error='on|off|fast'>
       //               1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              itable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <primarykeys ...>...
       // oooooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <primarykeys ... conn='label'>...
           //                 ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <primarykeys ...>...
       //                 o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_primary_keys(myConn
              :iqual:ischema:itable
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_PRIMARY 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema)
                 + ' ' + %trim(itable));

       // <primarykeys>success-or-fail ...</primarykeys>
       //              ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </primarykeys>...
       // oooooooooooooo
       xmlOutput(%addr(ooEndDesc):14:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml foreign keys
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlFKey      B
     D xmlSqlFKey      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</foreignkeys>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D itable          s            128A   inz(*BLANKS)
     D fqual           s            128A   inz(*BLANKS)
     D fschema         s            128A   inz(*BLANKS)
     D ftable          s            128A   inz(*BLANKS)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <foreignkeys [conn='label' error='on|off|fast'>
       //               1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              itable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 4;
              fqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 5;
              fschema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 6;
              ftable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <foreignkeys ...>...
       // oooooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <foreignkeys ... conn='label'>...
           //                 ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <foreignkeys ...>...
       //                 o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_foreign_keys(myConn
              :iqual:ischema:itable
              :fqual:fschema:ftable
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_FOREIGN 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema)
                 + ' ' + %trim(itable)
                 + ' ' + %trim(fschema)
                 + ' ' + %trim(ftable));

       // <foreignkeys>success-or-fail ...</foreignkeys>
       //              ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </foreignkeys>...
       // oooooooooooooo
       xmlOutput(%addr(ooEndDesc):14:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml statistics
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlSqlStat      B
     D xmlSqlStat      PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
     D   node                              likeds(xmlNode_t) 
      * vars
     D ooEndDesc       s             15A   inz('</statistics>')
     D rc              s              1N   inz(*OFF)
     D myNode          ds                  likeds(xmlNode_t) 
     D isConn          s              1N   inz(*OFF)
     D isStmt          s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * attributes
     D myConn          s             10A   inz(*BLANKS)
     D myDesc          s              1N   inz(*ON)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*OFF)
      * output
     d string          s               *
     d stringLen       s             10i 0
     D result          s             64A   inz(*BLANKS)
      * sql
     D  sqlCode        s             10I 0 inz(0)
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     d  sqlParm1       s               *   inz(%addr(sqlParm))
      * search elements
     D i               s             10i 0 inz(0)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * meta parms
     D iqual           s            128A   inz(*BLANKS)
     D ischema         s            128A   inz(*BLANKS)
     D itable          s            128A   inz(*BLANKS)
     D cunique         s            128A   inz(*BLANKS)
     D search1         s              3A   inz('que')
     D search2         s              3A   inz('QUE')
     D pos1            s             10i 0 inz(0)
     D pos2            s             10i 0 inz(0)
     D iall            s              1N   inz(*ON)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);
       // <statistics [conn='label' error='on|off|fast'>
       //               1             2
       search(1) = 'conn';
       search(2) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // conn='label'
           myConn = %str(pValue(1):valueLen(1));
         endif;
         if valueLen(2) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(2):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(2):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // init parms
       rc = sql_parm_ctor(sqlParm1);

       // node copy
       xmlCOPY(myNode:node);
       xmlRESET(myNode);

       // ------
       // <parm> - input
       // ------
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'parm';
       i = 1;
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <parm ...> ... </parm>
        // B         1   2         E
        when findElem = 1;
          rc = xmlSqlParm('I':doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode
                 :myConn:sqlCode:i:sqlParm(i));
          if rc = *ON and sqlParm(i).rawlen > 0;
            select;
            when i = 1;
              iqual = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 2;
              ischema = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 3;
              itable = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
            when i = 4;
              cunique = %str(sqlParm(i).rawP:sqlParm(i).rawlen);
              pos1 = %scan(search1:cunique);
              pos2 = %scan(search2:cunique);
              if pos1 > 0 or pos2 > 0;
                iall = *OFF;
              endif;
            other;
            endsl;
          endif;
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        if rc = *OFF;
          errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
          if myStopOn = *ON;
             return *OFF;
          endif;
        endif;
        i += 1;
       enddo;

       // <statistics ...>...
       // oooooooooooooooo
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_OPEN:myConn:*BLANKS:isConn:isStmt);
       if isConn = *OFF;
         rc = sql_active_any(SQL_ACTIVE_CONN:myConn);
         if rc = *ON;
           // <statistics ... conn='label'>...
           //                 ooooooooooooo
           xmlSqlLab(isNada:isCDATA
             :aElemTop1:aElemTop2
             :XML_ELEMENT_CONN:myConn:*BLANKS:isConn:isStmt);
         endif;
       endif;
       // <statistics ...>...
       //                 o
       xmlSqlLab(isNada:isCDATA
         :aElemTop1:aElemTop2
         :XML_ELEMENT_CLOSE:myConn:*BLANKS:isConn:isStmt);

       // -----------
       // SQL call
       rc = sql_statistics(myConn
              :iqual:ischema:itable:iall
              :sOutPtr:sqlCode);
       perfLogAdd(PERF_LOG_L_STATS 
                 + ' ' + %trim(myConn) 
                 + ' ' + %char(sqlCode)
                 + ' ' + %trim(ischema)
                 + ' ' + %trim(itable)
                 + ' ' + %trim(iall));

       // <statistics>success-or-fail ...</statistics>
       //             ooooooooooooooooooo
       string = %addr(myConn);
       stringLen = %len(%trim(myConn));
       xmlOutRet(myStopOn:rc:*OFF:string:stringLen:myJobLog);

       // </statistics>...
       // ooooooooooooo
       xmlOutput(%addr(ooEndDesc):13:*ON);

       // ignore errors
       if myStopOn = *OFF;
         return *ON;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml sql
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlDoSql        B
     D xmlDoSql        PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
      * vars
     D ooEndSql        s             10A   inz('</sql>')
     d rc              s              1N   inz(*OFF)
     d rc1             s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D myNode          ds                  likeds(xmlNode_t) 
     d origCDATA       s              1N   inz(*OFF)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      * search elements
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      /free
       Monitor;
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);

       // --------------
       // set ILE parm builder
       rc = ileStatic(XML_PGM_OPM_TRUE);
       if rc = *OFF;
         return *OFF;
       endif;

       // --------------
       // set SQL builder
       sqlStatic(SQL_DATABASE_DB2);
       origCDATA = sAllCDATA;      // save original global

       // node create
       xmlCTOR(myNode);
       if xmlGetCDATA() = *ON;
         myNode.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
       endif;
       myNode.xmlBy           = XML_BY_VAL;
       myNode.xmlPrmRet       = XML_IS_RETURN;

       // <sql>...
       // ooooo
       xmlOutput(aElemTop1:aElemTop2 - aElemTop1 + 1:*ON:isNada);

       // --------------
       // exec sql
       rc = *ON;
       pTop = aDataVal1;
       pNxt = aDataVal1;
       pLst = aDataVal2;
       elem(1) = 'options';
       elem(2) = 'connect';
       elem(3) = 'query';
       elem(4) = 'prepare';
       elem(5) = 'execute';
       elem(6) = 'commit';
       elem(7) = 'fetch';
       elem(8) = 'rowcount';
       elem(9) = 'describe';
       elem(10) = 'free';
       elem(11) = 'identity';
       elem(12) = 'tables';
       elem(13) = 'columns';
       elem(14) = 'procedures';
       elem(15) = 'primarykeys';
       elem(16) = 'statistics';
       elem(17) = 'foreignkeys';
       elem(18) = 'pcolumns';
       elem(19) = 'tablepriv';
       elem(20) = 'columnpriv';
       elem(21) = 'special';
       elem(22) = 'count';
       dou pNxt = *NULL or rc = *OFF;
        pTop = pNxt;
        findElem = bigElem(pTop:pLst:elem:doNest:
                   doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
        select;
        // <options ...> ... </options>
        // B            1   2         E
        when findElem = 1;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlOpts(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <connect ...> ... </connect>
        // B            1   2         E
        when findElem = 2;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlConn(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <query ...> ... </query>
        // B          1   2       E
        when findElem = 3;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlQry(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <prepare ...> ... </prepare>
        // B            1   2         E
        when findElem = 4;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlPrep(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <execute ...> ... </execute>
        // B            1   2         E
        when findElem = 5;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlExec(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <commit ...> ... </commit>
        // B           1   2        E
        when findElem = 6;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlComm(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <fetch ...> ... </fetch>
        // B          1   2       E
        when findElem = 7;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlFtch(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <rowcount ...> ... </rowcount>
        // B             1   2          E
        when findElem = 8;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlRCnt(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <describe ...> ... </describe>
        // B             1   2          E
        when findElem = 9;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlDesc(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <free ...> ... </free>
        // B         1   2      E
        when findElem = 10;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlFree(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <identity ...> ... </identity>
        // B             1   2          E
        when findElem = 11;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlLsId(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <tables ...> ... </tables>
        // B           1   2        E
        when findElem = 12;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlTabl(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <columns ...> ... </columns>
        // B            1   2         E
        when findElem = 13;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlCols(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <procedures ...> ... </procedures>
        // B               1   2            E
        when findElem = 14;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlProc(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <primarykeys ...> ... </primarykeys>
        // B                1   2             E
        when findElem = 15;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlPKey(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <statistics ...> ... </statistics>
        // B               1   2            E
        when findElem = 16;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlStat(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <foreignkeys ...> ... </foreignkeys>
        // B                1   2             E
        when findElem = 17;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlFKey(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <pcolumns ...> ... </pcolumns>
        // B             1   2          E
        when findElem = 18;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlPCol(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <tablepriv ...> ... </tablepriv>
        // B              1   2        E
        when findElem = 19;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlTabP(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
        // <columnpriv ...> ... </columnpriv>
        // B             1   2          E
        when findElem = 20;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlColP(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <special ...> ... </special>
        // B            1   2          E
        when findElem = 21;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlSpec(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        // <count ...> ... </count>
        // B             1   2          E
        when findElem = 22;
          perfAdd(PERF_XML_SERVER_SQL_RUN1);
          rc = xmlSqlCDesc(doNada:doCDATA
                 :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
          perfAdd(PERF_XML_SERVER_SQL_RUN2);
        when findElem = -1;
          rc = *OFF;
        other;
        endsl;
        // once found, always on
        // allows all sql fetch
        // to occur with cdata
        if doCDATA = *ON;
          sAllCDATA = *ON;
        endif;
       enddo;

       // </sql>...
       // oooooo
       xmlOutput(%addr(ooEndSql):6:*ON);

       On-error;
         rc = *OFF;
       Endmon;

       // dead
       Monitor;
       if rc = *OFF;
         errsSevere(XML_ERROR_SQL_EXCEPTION:sHint);
         rc1=sql_connect_free_all();
       endif;
       On-error;
       Endmon;

       sAllCDATA = origCDATA;      // restore original global
       return rc;
      /end-free
     P                 E


      * +++++++++++++++++++++++++++++++++++++++++++++++++++
      * xml Diag
      * +++++++++++++++++++++++++++++++++++++++++++++++++++


      *****************************************************
      * xml diag
      * return (*ON-good, *OFF-bad)
      *****************************************************
     P xmlDoDiag       B
     D xmlDoDiag       PI             1N
     D  isNada                        1N   value
     D  isCDATA                       1N   value
     D  aElemTop1                      *   value
     D  aElemTop2                      *   value
     D  aDataVal1                      *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
      * vars
     D ooEndDiag       s             10A   inz('</diag>')
     d rc              s              1N   inz(*OFF)
     D myStopOn        s              1N   inz(*OFF)
     D myJobLog        s              1N   inz(*ON)
     d myInfo          s              1A   inz(XML_DIAG_JOBLOG)
     D myPath          s           2048A   inz(*BLANKS)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D jobName         s             10A   inz(*BLANKS)
     D jobUserID       s             10A   inz(*BLANKS)
     D jobNbr          s              6A   inz(*BLANKS)
     D retLen          s             10i 0 inz(0)
     D report          S          65000A   inz(*BLANKS)
     D anyData         s          60000A   inz(*BLANKS)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free
       // hint
       xmlSetHint(aElemTop1:aElemEnd2);

       // <diag [info='joblog|conf|fast' job='job' user='uid' nbr='nbr' error='on|off|fast']/>
       // -- or --
       // <diag [info="joblog|conf|fast" job="job" user="uid" nbr="nbr" error="on|off|fast"]/>
       //        1                       2         3          4         5
       search(1) = 'info';
       search(2) = 'job';
       search(3) = 'user';
       search(4) = 'nbr';
       search(5) = 'error';
       rc = bigDimAttr(aElemTop1:aElemTop2:search:pName:pValue:valueLen);
       if rc = *ON;
         if valueLen(1) <> 0; // info='joblog|log'
           if 'j' = %str(pValue(1):1);
             myInfo=XML_DIAG_JOBLOG;
           elseif 'c' = %str(pValue(1):1);
             myInfo=XML_DIAG_CONF;
           elseif 'f' = %str(pValue(1):1);
             myInfo=XML_DIAG_FAST;
           endif;
         endif;
         if valueLen(2) <> 0; // job='j'
           jobName = %str(pValue(2):valueLen(2));
         endif;
         if valueLen(3) <> 0; // user='u'
           jobUserID = %str(pValue(3):valueLen(3));
         endif;
         if valueLen(4) <> 0; // nbr='n'
           jobNbr = %str(pValue(4):valueLen(4));
         endif;
          if valueLen(5) <> 0; // error="on|off|fast"
           if 'on' = %str(pValue(5):2);
             myStopOn = *ON;
             myJobLog = *OFF;
           elseif 'of' = %str(pValue(5):2);
             myStopOn = *OFF;
             myJobLog = *ON;
           elseif 'fa' = %str(pValue(5):2);
             myStopOn = *OFF;
             myJobLog = *OFF;
           endif;
         endif;
       endif;

       // <diag ...>data</diag>
       // oooooooooo
       if isNada = *ON;
         report = %trim(report) + %str(aElemTop1:aElemTop2 - aElemTop1 - 1);
         report = %trim(report) + '>';
       else;
         report = %trim(report) + %str(aElemTop1:aElemTop2 - aElemTop1 + 1);
       endif;
       string = %addr(report);
       stringLen = %len(%trim(report));
       xmlOutput(string:stringLen:*OFF);

       // <diag ...>data</diag>
       //           oooo
       retLen = 0;

       // <diag ...>...</diag>
       //           ooo
       if myInfo=XML_DIAG_JOBLOG;
         rc = xmlError(*OFF:myJobLog:jobName:jobUserID:jobNbr);
       elseif myInfo=XML_DIAG_FAST;
         rc = xmlError(*OFF:*OFF:jobName:jobUserID:jobNbr:*ON);
       // hey hook call out diag
       elseif myInfo=XML_DIAG_CONF;
         if aElemEnd2 <> *NULL and aElemEnd2 > aElemEnd1 + 1;
           anyData = %str(aElemEnd1:aElemEnd2-aElemEnd1+1);
         endif;
         rc = confDiag(jobName:jobUserID:jobNbr:anyData);
         if rc = *ON;
           retLen = %len(%trim(anyData));
           if retLen > 0;             
             string = %addr(anyData);
             stringLen = retLen;
             xmlOutput(string:stringLen:*OFF);
           endif;
         endif;
       endif;

       // <diag ...>...</diag>
       //              ooooooo
       report = ooEndDiag;
       string = %addr(report);
       stringLen = %len(%trim(report));
       xmlOutput(string:stringLen:*ON);
       
       if rc=*ON and myStopOn = *ON;
         return *OFF;
       endif;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * xml header
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlSetHead      B                   export
     D xmlSetHead      PI
     D   data                          *   value
     D   dataSz                      10i 0 value
      * vars
     D header          s           2048A   inz(*BLANKS)
     D search1         S              2A   inz('<?')
     D search          S              2A   inz('?>')
     D i               S             10i 0 inz(0)
     D pos             S             10i 0 inz(0)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
      /free
       Monitor;

       // -------------
       // HEY - custom hook (plugconfx)
       sHeader = confHeader();

       // bad data
       if data = *NULL or dataSz < 8;
         return;
       endif;

       // copy in header
       string    = data;
       stringLen = %size(header) - 1;
       if dataSz < stringLen;
         stringLen = dataSz;
       endif;
       header = %str(data:stringLen);


       // scanning beyond junk for first '<?'
       pos = %scan(search1:header);
       if pos > 1;
         string    = data + pos - 1;
         stringLen = %size(header) - 1;
         if dataSz - pos < stringLen;
           stringLen = dataSz - pos;
         endif;
         header = %str(data + pos - 1:stringLen);
       endif;


       // replace default with user supplied header
       // scanning for '?>'
       i = 1;
       dow i > 0;
         i = %scan(search:header:i+1);
         if i > 0;
           pos = i;
         endif; 
       enddo;
       // header
       if pos > 7;
         sHeader = %subst(header:1:pos+1)+x'25';
       endif;

       On-error;
       Endmon;

      /end-free
     P                 E

      *****************************************************
      * xml header
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlGetHead      B                   export
     D xmlGetHead      PI          2048A
      * vars
     D search          S              2A   inz('?>')
     D pos             S             10i 0 inz(0)
      /free
       // -------------
       // HEY - custom hook (plugconfx)
       if sHeader = *BLANKS;
         sHeader = confHeader();
       endif;

       // -------------
       // HEY - custom hook (plugconfx)
       // header ok?
       pos = %scan(search:sHeader);
       if pos < 1;
         sHeader = confHeader();
       endif;
 
       return sHeader;
      /end-free
     P                 E

      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlHack         B                   export
     D xmlHack         PI             1N
      * vars
     D rc              s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
      * hack
     D h               S             10i 0 inz(0)
     D outHackSz       S             10i 0 inz(0)
     D outHackLp       S             10i 0 inz(0)
     D uHack_t         DS                  qualified based(Template)
     D  hData                      2993a
     D  hHack                         7a
     D uHackL_t        DS                  qualified based(Template)
     D  hData                      3007a
     D outHackI        S             10i 0 inz(0)
     D outHackP        S               *   inz(*NULL)
     D dIData          S               *   inz(*NULL)
     D dROver          ds                  likeds(uHack_t) based(dIData)
     D uIOver          S               *   inz(*NULL)
     D uROver          ds                  likeds(uHack_t) based(uIOver)
     D eROver          ds                  likeds(uHackL_t) based(uIOver)
      /free
       Monitor;

       sHint = 'hack term';

       // --------------
       // occasional bad behavior extension ...
       // result set has extra data (junk)
       // XMLSERVICE workaround sends ...
       outHackSz = xmlOutUsed();
       outHackLp = %DIV(outHackSz:3000) + 1;
       outHackP  = *NULL;
       // can i copy modified back into output?
       if outHackLp * 3000 < sOutSize;
         outHackI = cacAddBig(outHackLp * 3000:CAC_HEAP_ILE_TMP);
         outHackP = cacScanBig(outHackI);
       endif;
       // found enough room for copy
       if outHackP <> *NULL;
         dIData    = sOutOrgP;  // actual data
         uIOver    = outHackP;  // hacked data
         for h = 1 to outHackLp;
           // last record
           if h = outHackLp;
             stringLen = strlen(%addr(dROver.hData));
             if stringLen > 1;
               eROver.hData = %str(%addr(dROver.hData):stringLen) 
                            + '</hack>';
             else;
               eROver.hData = '</hack>';
             endif;
             leave;
           endif;
           // just another record
           uROver.hData = dROver.hData;
           uROver.hHack = '</hack>';
           dIData += 2993;      // -7 room for '</hack>'
           uIOver += 3000;      // includes '</hack>'
         endfor;
         // back into actual output data
         xmlOutReset();
         xmlOutput(outHackP:outHackLp*3000:*OFF);
         rc = *ON;
       endif;

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlTerm         B                   export
     D xmlTerm         PI             1N
      * vars
     D rc              s              1N   inz(*ON)
     D report          S              1A   inz(x'00')
     D remain          s             10i 0 inz(0)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
      /free
       // --------------
       // bad drivers
       // ...</script>NULL
       //             oooo
       string = %addr(report);
       stringLen = 1;
       xmlOutput(string:stringLen:*OFF);

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************


      *****************************************************
      * rc=xmlExec32(...)
      * return (*ON=good, *OFF=error)
      * Note: 
      * calling PASE popen(cmd), therefore using
      * PASE memory, that needs
      * copyout back into ILE memory used by
      * ILE stored procedure or RPG alloc()
      *****************************************************
     P xmlExec32       B                   export
     D xmlExec32       PI             1N
     D cmd                             *   value
     D cmdLen                        10i 0 value
     D isRows                         1N   value
     D keepBottom                     1N   value
     D isCDATA                        1N   value
     D out                             *   value
     D outLen                        10i 0 value
     D retLen                        10i 0
     D useQsh                         1N   value
      * vars
     D fstRow          S              1N   inz(*ON)
     D rc              S              1N   inz(*OFF)
     D paseTail        S             10i 0 inz(0)
     D pOut            s               *
     D myOut           ds                  likeds(over_t) based(pOut)
     D pPrv            s               *
     D pCur            s               *
     D myDat           s          32766A   based(pCur)
     D myCopy          ds                  likeds(over_t) based(pCur)
     D begRow          s              5A   inz('<row>')
     D endRow          s              6A   inz('</row>')
     D paseMem         s               *   inz(*NULL)
     D paseLen         S             10i 0 inz(0)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
      /free
       Monitor;

       cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
       cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)

       // hint
       sHint = 'xml pase exec';

       // make the call
       if useQsh = *ON;
         paseLen = outLen;
         rc = ileExec(cmd:cmdLen:paseMem:paseLen);
       else;
         rc = PaseExec32(cmd:cmdLen:paseMem:paseLen);
       endif;

       // copy out
       if isCDATA = *OFF;
         isCDATA = xmlGetCDATA();
       endif;
       if rc = *ON and paseLen > 0;
         pCur = paseMem;
         pOut = out;
         // truncate to fit
         // ADC 32 fit one <sh><row><![CDATA[...]]></row></sh> (1.6.2)
         if paseLen > outLen - 32;
           if keepBottom = *ON;
             paseTail = paseLen - (outLen - 32);
             pCur += paseTail;
           endif;
           paseLen = outLen - 32;
         endif;
         // ----------
         // add CDATA, but not rows
         if isRows = *OFF and isCDATA = *ON;
           // <![CDATA[data]]>
           // ooooooooo
           cpybytes(pOut:%addr(cCDATA1):%size(cCDATA1));
           pOut += %size(cCDATA1);
         endif;
         // ----------
         // no convert (already ebcdic)
         if useQsh = *ON;
           retLen = paseLen;
           cpybytes(pOut:paseMem:retLen+1);
         // ----------
         // convert to ebcdic
         else;
           retLen = convPASE(pCur:paseLen:*ON:pOut:outLen);
         endif;
         if retLen > 0 
         and isRows = *OFF and isCDATA = *ON;
           // <![CDATA[data]]>
           //              ooo
           pOut += retLen-1;
           cpybytes(pOut:%addr(cCDATA2):%size(cCDATA2));
           pOut += %size(cCDATA2);
           // <![CDATA[data]]>LF
           //                 xx
           myOut.chrx = x'25';          // line feed
           // <![CDATA[data]]>LFNULL
           //                   xxxx
           pOut += 1;                   // past LF
           myOut.chrx = x'00';          // null terminate
           retLen = strlen(out);        // total length
         endif;
         // ----------
         // error
         if retLen < 1;
           // back out CDATA start
           if isRows = *OFF and isCDATA = *ON;
             pOut = out;
             memset(pOut:0:%size(cCDATA1));
           endif;
           rc = *OFF;
         // ----------
         // add rows on line breaks
         elseif isRows = *ON;
           // reuse pase buffer
           // copy ebcdic over ascii
           // (temp copy)
           cpybytes(paseMem:out:retLen+1);

           // make sure last row
           // ends with dataLFNULL
           pCur = paseMem+retLen-1;
           if myCopy.chrx <> x'25';
             // dataLF
             //     oo
             pCur += 1;
             myCopy.chrx = x'25';
           endif;
           // dataLFNULL
           //       oooo
           pCur += 1;
           myCopy.chrx = x'00';

           // where LF are rows
           pOut = out;
           pCur = paseMem;
           pPrv = pCur;
           pCur = strchr(pPrv:x'25');
           dow pCur <> *NULL;
             if retLen + (pCur - pPrv) > outLen;
               leave;
             endif;
             if fstRow = *OFF;
               myOut.chrx = x'25';
               pOut += 1;
             else;
               fstRow = *OFF;
             endif;
             // <row>data</row>
             // ooooo
             cpybytes(pOut:%addr(begRow):%size(begRow));
             pOut += %size(begRow);
             if isCDATA = *ON;   // ADC (1.6.2)
               // <![CDATA[data]]>
               // ooooooooo
               cpybytes(pOut:%addr(cCDATA1):%size(cCDATA1));
               pOut += %size(cCDATA1);
             endif;
             // <row>data</row>
             //      oooo
             if (pCur-pPrv) > 0;
               cpybytes(pOut:pPrv:(pCur-pPrv));
               pOut += (pCur-pPrv);
             endif;
             if isCDATA = *ON;   // ADC (1.6.2)
               // <![CDATA[data]]>
               //              ooo
               cpybytes(pOut:%addr(cCDATA2):%size(cCDATA2));
               pOut += %size(cCDATA2);
             endif;
             // <row>data</row>
             //          oooooo
             cpybytes(pOut:%addr(endRow):%size(endRow));
             pOut += %size(endRow);
             // <row>data</row>NULL
             //                xxxx
             myOut.chrx = x'00';        // null terminate
             retLen = strlen(out);      // total length
             pPrv = (pCur + 1);         // past eol
             pCur = strchr(pPrv:x'25'); // next line
           enddo;
           // <row>data</row>LF
           //                xx
           myOut.chrx = x'25';          // line feed
           // <row>data</row>LFNULL
           //                  xxxx
           pOut += 1;                   // past LF
           myOut.chrx = x'00';          // null terminate
           retLen = strlen(out);        // total length
         endif;
       endif;

       On-error;
         errsWarning(XML_ERROR_RUNSH_EXCEPTION:sHint);
         rc = *OFF;
       Endmon;

       // bad
       if rc = *OFF;
         retLen = 0;
       endif;

       // good
       return rc;
      /end-free
     P                 E

      *****************************************************
      * job log
      * return (NA)
      *****************************************************
     P xmlJobLog       B
     D xmlJobLog       PI             1N
     D   jobName                     10A   value
     D   jobUserID                   10A   value
     D   jobNbr                       6A   value
     D   cntCPF                      10i 0
     D   myCPF                        7A   dim(CPFSMAX)
     D   myTime                      25A   dim(CPFSMAX)
     D   myHint                     128A   dim(CPFSMAX)
     D   myData1                  32000A
      * vars
     D myData          S          32000A   inz(*BLANKS)
     D rc              S              1N   inz(*OFF)
     D rc1             S              1N   inz(*OFF)
     D myCmd           S           4096A   inz(*BLANKS)
     d strCmd          s               *   inz(%addr(myCmd))
     d i               s             10i 0 inz(0)
     d retLen          s             10i 0 inz(0)
     d pos             s             10i 0 inz(0)
     d pos1            s             10i 0 inz(0)
     d lenCmd          s             10i 0 inz(0)
     D isRows          s              1N   inz(*OFF)
     D isCDATA         s              1N   inz(*OFF)
     D keepBottom      s              1N   inz(*OFF)
     D myLook1         S              3A   inz('CPF')
     D myLook2         S              3A   inz('MCH')
     D myLook3         S              2A   inz('RN')
     D myLook4         S              3A   inz('*NO')
     D myLook5         S              3A   inz('CEE')
     D myLook6         S              3A   inz('GUI')
     D myLook7         S              3A   inz('SQL')
     D myStop          S              3A   inz('.  ')
     D myText          S              5A   inz('. :  ')
     D pFix            s               *   inz(*NULL)
     D pTop            s               *   inz(*NULL)
     D pEnd            s               *   inz(*NULL)
     D pHint           s               *   inz(*NULL)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D savCPF          s              7A   inz(*BLANKS)
     D savHint         s            128A   inz(*BLANKS)
     D ooLen           s             10i 0 inz(0)
     D pTmpFile        s           1024A   inz(*BLANKS)
     D flen            s             10i 0 inz(0)
      /free
       cntCPF = 0;

       // tmp file: /tmp/xmlservice-joblog-name-user-nbr.log
       pTmpFile = ipcPthXMLf(jobName:jobUserID:jobNbr);

       // QSH CMD('system -i "DSPJOBLOG JOB(464737/QTMHHTTP/XTOOLKIT)" > /tmp/xxxxx')
       myCmd = 'QSH CMD(''system -i "DSPJOBLOG JOB('
             + %trim(jobNbr)
             + '/' + %trim(jobUserID)
             + '/' + %trim(jobName)
             + ')"'
             + ' > ' + %trim(pTmpFile)
             + ''')';
       lenCmd = %len(%trim(myCmd));
       rc = ileCmdExc(strCmd:lenCmd);

       // read /tmp/xxx data into myData
       myData1 = *BLANKS;
       myData = *BLANKS;
       flen = ipcBotXMLf(%addr(myData):%size(myData):pTmpFile);
       rc1 = ipcRmvXMLf();

       // have a joblog entries ???
       // xxx<---myLook CPF, MCH, etc. appears 1st position
       // MCH3601    Uscita   40   09/05/12  10:49:58,812952
       //                          xxxxxxxxxxxxxxxxxxxxxxxxx<--myTime
       //   Dal modulo  . . . . . . . . :   MNSER05   <-concat myHint
       //   Dalla procedura . . . . . . :   RTVAZIPRE <-concat myHint
       //   Istruzione. . . . . . . . . :   142       <-concat myHint
       //   Al modulo . . . . . . . . . :   MNSER05   <-concat myHint
       //   Alla procedura  . . . . . . :   RTVAZIPRE <-concat myHint
       //   Istruzione. . . . . . . . . :   142       <-concat myHint
       //   Messaggio . . . . . . . . . :   Puntatore <-concat myHint
       //                             xxxxx<---myText search '. :  '
       if rc = *ON;
         myData = %trim(myData);      // trim spaces
         ooLen = %len(%trim(myData)); // len after trim spaces
         if ooLen > 1;
           bigJunkOut(%addr(myData):%addr(myData) + ooLen:*ON);
         endif;
         // walk line feeds joblog
         ooLen = %len(%trim(myData)); // len after trim spaces
         // NULL terminated for strchr
         pCopy = %addr(myData) + %size(myData);
         myCopy.bytex = x'00';
         // point to start job log
         pCopy = %addr(myData);
         // new file read extra space
         if myCopy.char1 = *BLANKS;
           pCopy += 1;
         endif;
         pTop = pCopy;
         pEnd = pCopy + ooLen;
         dou pCopy = *NULL or pCopy >= pEnd;
           pCopy = strchr(pCopy:x'25');
           if pCopy <> *NULL;
             // xxx<---myLook CPF, MCH, etc. appears 1st position
             // MCH3601    Uscita   40   09/05/12  10:49:58,812952
             pCopy += 1;
             // new file read extra space
             if myCopy.char1 = *BLANKS;
               pCopy += 1;
             endif;
             // copy out -- fix extra lead space problem cw.php layer
             if pTop < pCopy;
               myData1 = %trim(myData1)
                       + %str(pTop:pCopy - pTop);
             endif;
             pTop = pCopy;
             if myCopy.char3 = myLook1
             or myCopy.char3 = myLook2
             or myCopy.char2 = myLook3
             or myCopy.char3 = myLook4
             or myCopy.char3 = myLook5
             or myCopy.char3 = myLook6
             or myCopy.char3 = myLook7;
               // room for next
               if cntCPF < CPFSMAX;
                 cntCPF += 1;
                 myCPF(cntCPF) = myCopy.char7;
               // shift top entry off
               // make room for entry
               else;
                 for i = 1 to CPFSMAX;
                   if i = CPFSMAX;
                     myCPF(i)  = myCopy.char7;
                     myHint(i) = *BLANKS;
                   else;
                     myCPF(i)  = myCPF(i+1);
                     myHint(i) = myHint(i+1);
                   endif;
                 endfor;
               endif;
               // cut out time date of log entry 
               // 09/05/12  10:49:58,812952
               // xxxxxxxxxxxxxxxxxxxxxxxxx<--myTime
               pHint = pCopy + 40;
               myTime(cntCPF) = %trim(%str(pHint:25));
             // pull out additional info myHint
             elseif cntCPF > 0 and myCopy.char10 = *BLANKS;
               // assuming already collect myHint
               // stop at 1st sentence ending '.'
               // 'Puntatore ... di riferimento.  '
               //                              xxx - end
               pos = %scan(myStop:myHint(cntCPF));
               if pos < 1;
                 // . :   MNSER05   <-concat myHint
                 // . :   RTVAZIPRE <-concat myHint
                 // . :   142       <-concat myHint
                 // . :   MNSER05   <-concat myHint
                 // . :   RTVAZIPRE <-concat myHint
                 // . :   142       <-concat myHint
                 // . :   Puntatore <-concat myHint
                 // xxxxx<---myText search '. :  '
                 pHint   = strstr(pCopy:myText);
                 if pHint <> *NULL
                 and pHint < pEnd;
                   // . :   Puntatore ... x'25'
                   //       x - start of text
                   pHint += 6;
                   // . :   Puntatore ... x'25'
                   //                     x - end LF
                   pCopy = strchr(pCopy:x'25');
                   if pCopy = *NULL;
                     pCopy = pEnd;
                   endif;
                   if pHint < pCopy;
                      myHint(cntCPF) = %trim(myHint(cntCPF))
                        + ' ' 
                        + %trim(%str(pHint:pCopy - pHint));
                   endif;
                 endif;
               endif;
             endif;
           endif;
         enddo;
         // fix NULL terminated for strchr
         pCopy = %addr(myData) + %size(myData);
         myCopy.bytex = *BLANKS;
       endif;

       // ----------
       // result
       return rc;
      /end-free
     P                 E

      *****************************************************
      * collect report errors
      * return (NA)
      *****************************************************
     P xmlError        B                   export
     D xmlError        PI             1N
     D   isfull                       1N   value
     D   isjoblog                     1N   value
     D   ijobName                    10A   value options(*nopass)
     D   ijobUserID                  10A   value options(*nopass)
     D   ijobNbr                      6A   value options(*nopass)
     D   ifast                        1N   value options(*nopass)
      * vars
     D rc              s              1N   inz(*OFF)
     D lillen          S             10i 0 inz(0)
     D biglen          S             10i 0 inz(0)
     D bighint         S           4000A   inz(*BLANKS)
     D report          S          32000A   inz(*BLANKS)
     D myData          S          32000A   inz(*BLANKS)
     D overme_t        DS                  qualified based(Template)
     D  mebufx                     1000a   dim(32)
     D pOver1          s               *   inz(%addr(report))
     D myOver1         ds                  likeds(overme_t) based(pOver1)
     D pOver2          s               *   inz(%addr(myData))
     D myOver2         ds                  likeds(overme_t) based(pOver2)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D pos             S             10i 0 inz(0)
     D left            S             10i 0 inz(0)
     D waszero         s              1A   inz(x'00')
     D toblk           s              1A   inz(x'40')
     D myTemp          S             60A   inz(*BLANKS)
     D retLen          s             10i 0 inz(0)
     D curLen          s             10i 0 inz(0)
     D maxLen          s             10i 0 inz(0)
     D erCache         DS                  likeds(erRec_t)
     D jobName         s             10A   inz(*BLANKS)
     D jobUserID       s             10A   inz(*BLANKS)
     D jobNbr          s              6A   inz(*BLANKS)
     D jobInfo         ds                  likeds(myJob_t)
     D paseCCSID       S             10i 0 inz(0)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
     D haveCPF         s              1N   inz(*OFF)
     D haveBusy        s              1N   inz(*OFF)
     D cntCPF          s             10i 0 inz(0)
     D lastCPF         s              7A   inz(*BLANKS)
     D lastHint        s            128A   inz(*BLANKS)
     D myCPF           s              7A   dim(CPFSMAX) inz(*BLANKS)
     D myTime          s             25A   dim(CPFSMAX) inz(*BLANKS)
     D myHint          s            128A   dim(CPFSMAX) inz(*BLANKS)
     D ooLen           s             10i 0 inz(0)
     D msgOut          S             64A   inz(*BLANKS)
     D isfast          s              1N   inz(*OFF)
      /free
       Monitor;

       cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
       cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)

       if %parms >= 3;
         jobName = ijobName;
       endif;
       if %parms >= 4;
         jobUserID = ijobUserID;
       endif;
       if %parms >= 5;
         jobNbr = ijobNbr;
       endif;
       if %parms >= 6;
         isfast = ifast;
       endif;

       sHint = 'xml errors';

       // -------------------
       // PART 1 -- header
       report = *BLANKS;

       // heavy handed penalty ???
       if isfull = *ON;
         // current xml output (1.8.1)
         biglen = xmlOutUsed();
         if biglen > 0;
           lillen = %size(bighint);
           if biglen <= lillen;
             bighint = %str(sOutOrgP:biglen);
           else;
             bighint = %str(sOutPtr-lillen:lillen);
           endif;
         endif;
         // reset output to start 
         xmlOutReset();
         // new header
         report = %trim(xmlGetHead());
         // start of report
         report = %trim(report) + '<report>'+x'25';
       endif;

       // space left for output
       maxLen = xmlOutRoom();
       if maxLen > %size(report);
         maxLen = %size(report);
       endif;

       // version
       report = %trim(report) 
              + '<version>' + PLUGVER + '</version>'+x'25';

       // -------------------
       // PART 2 -- list errors 
       // output accumulated errors
       if isfast = *OFF; // fast (1.9.2)
       for i=ERRSPRV to ERRSMAX;
        curLen = %len(%trim(report));
        if curLen + 256 < maxLen;
          rc = errsGet(i:erCache);
          if rc = *OFF;
           leave;
          endif;
          if erCache.erErrXml = IPC_ERROR_TIMEOUT_END_BUSY;
            haveBusy = *ON;
          endif;
          report = %trim(report) + '<error>'+x'25';
          if erCache.erErrNo <> 0;
           report = %trim(report) 
                  + '<errnoile>' 
                  + %trim(%char(erCache.erErrNo))
                  + '</errnoile>'+x'25';
           msgOut = errsIleTxt(erCache.erErrNo);
           bigJunkOut(%addr(msgOut):%addr(msgOut) + %size(msgOut):*OFF);
           if msgOut <> *BLANKS;
             report = %trim(report) 
                  + '<errnoilemsg>' 
                  + cCDATA1
                  + %trim(msgOut)
                  + cCDATA2
                  + '</errnoilemsg>'+x'25';
           endif;
          endif;
          if erCache.erErrNoPs <> 0;
           report = %trim(report) 
                  + '<errnopase>' 
                  + %trim(%char(erCache.erErrNoPs))
                  + '</errnopase>'+x'25';
          endif;
          if erCache.erErrCPF <> *BLANKS;
           report = %trim(report) 
                  + '<cpf>' 
                  + %trim(erCache.erErrCPF)
                  + '</cpf>'+x'25';
           haveCPF = *ON;
           lastCPF = erCache.erErrCPF;
           lastHint = XML_MSG_GENERIC_CPF_UNAVAILABLE;
          endif;
          if erCache.erErrSYS <> 0;
           report = %trim(report) 
                  + '<status>' 
                  + %trim(%char(erCache.erErrSYS))
                  + '</status>'+x'25';
          endif;
          if erCache.erErrCODE <> 0;
           report = %trim(report) 
                  + '<sqlcode>' 
                  + %trim(%char(erCache.erErrCODE))
                  + '</sqlcode>'+x'25';
           report = %trim(report) 
                  + '<sqlstate>' 
                  + %trim(erCache.erErrSTAT)
                  + '</sqlstate>'+x'25';
          endif;
          report = %trim(report) 
                  + '<errnoxml>' 
                  + %trim(%char(erCache.erErrXml))
                  + '</errnoxml>'+x'25';
          report = %trim(report) 
                  + '<xmlerrmsg>' 
                  + cCDATA1
                  + %trim(errsMsgTxt(erCache.erErrXml))
                  + cCDATA2
                  + '</xmlerrmsg>'+x'25';
          report = %trim(report) 
                  + '<xmlhint>'
                  + cCDATA1 
                  + %trim(erCache.erHelp);
          if erCache.erHelp = *BLANKS;
           report = %trim(report) + XML_MSG_GENERIC_ERROR;
          endif;
          report = %trim(report)
                  + cCDATA2 
                  + '</xmlhint>'+x'25';
          report = %trim(report) + '</error>'+x'25';
        endif;
       endfor; // PART 2 -- list errors
       endif; // fast (1.9.2)

       // -------------------
       // PART 2.5 -- big hint output (1.8.1)
       if isfast = *OFF; // fast (1.9.2)
       curLen = %len(%trim(report));
       lillen = %len(%trim(bighint));
       if lillen > 0 and curLen + lillen < maxLen;
          bigJunkOut(%addr(bighint):%addr(bighint) + %size(bighint):*ON);
          report = %trim(report) 
                  + '<xmloutput>' 
                  + cCDATA1
                  + %trim(bighint)
                  + cCDATA2
                  + '</xmloutput>'+x'25';
       endif;
       endif; // fast (1.9.2)

       // -------------------
       // PART 3 -- job information 
       rc = ileJob(jobName:jobUserID:jobNbr:jobInfo);
       curLen = %len(%trim(report));
       if curLen + 1024 < maxLen;
         report = %trim(report) + '<jobinfo>'+x'25';
         if ipcIPC() = *BLANKS;
           report = %trim(report) + '<jobipc/>'+x'25';
         else;
           report = %trim(report) + '<jobipc>' 
                               + %trim(ipcIPC())
                               +'</jobipc>'+x'25';
         endif;
         report = %trim(report) + '<jobipcskey>' 
                               + %trim(ipcFtok())
                               +'</jobipcskey>'+x'25';
         report = %trim(report) + '<jobname>' 
                               + %trim(jobInfo.Job0_JobName)
                               +'</jobname>'+x'25';
         report = %trim(report) + '<jobuser>' 
                               + %trim(jobInfo.Job0_UserID)
                               +'</jobuser>'+x'25';
         report = %trim(report) + '<jobnbr>' 
                               + %trim(jobInfo.Job0_JobNbr)
                               +'</jobnbr>'+x'25';
         report = %trim(report) + '<jobsts>' 
                               + %trim(jobInfo.Job0_Status)
                               +'</jobsts>'+x'25';
         report = %trim(report) + '<curuser>' 
                               + %trim(jobInfo.Job0_CurUser)
                               +'</curuser>'+x'25';
         report = %trim(report) + '<ccsid>' 
                               + %char(jobInfo.Job0_CCSID)
                               +'</ccsid>'+x'25';
         report = %trim(report) + '<dftccsid>' 
                               + %char(jobInfo.Job0_DfCCSID)
                               +'</dftccsid>'+x'25';
         paseCCSID = PaseLstCCSID();
         report = %trim(report) + '<paseccsid>' 
                               + %char(paseCCSID)
                               +'</paseccsid>'+x'25';
         report = %trim(report) + '<langid>' 
                               + %trim(jobInfo.Job0_LangId)
                               +'</langid>'+x'25';
         report = %trim(report) + '<cntryid>' 
                               + %trim(jobInfo.Job0_CntryId)
                               +'</cntryid>'+x'25';
         report = %trim(report) + '<sbsname>' 
                               + %trim(jobInfo.Job0_SbsName)
                               +'</sbsname>'+x'25';
         report = %trim(report) + '<sbslib>' 
                               + %trim(jobInfo.Job0_SbsLib)
                               +'</sbslib>'+x'25';
         report = %trim(report) + '<curlib>' 
                               + %trim(jobInfo.Job0_CurL)
                               +'</curlib>'+x'25';
         report = %trim(report) + '<syslibl>' 
                               + %trim(jobInfo.Job0_SysL)
                               +'</syslibl>'+x'25';
         report = %trim(report) + '<usrlibl>' 
                               + %trim(jobInfo.Job0_UsrL)
                               +'</usrlibl>'+x'25';
         if haveCPF = *ON;
           report = %trim(report)
                 + '<jobcpffind>'
                 + XML_MSG_GENERIC_CPF_IN_ERRORS
                 + '</jobcpffind>'+x'25';
         else;
           report = %trim(report)
                 + '<jobcpffind>'
                 + XML_MSG_GENERIC_CPF_IN_JOBLOG
                 + '</jobcpffind>'+x'25';
         endif;
         report = %trim(report) + '</jobinfo>'+x'25';
       endif; // PART 3 -- job information

       // -------------------
       // busy timeout ignore job log
       if haveBusy = *ON;
         isjoblog = *OFF;
       endif;

       // -------------------
       // PART x -- get job log
       if isjoblog = *ON;
          rc = xmlJobLog(jobName:jobUserID:jobNbr
                   :cntCPF:myCPF:myTime:myHint:myData);
          if rc = *OFF;
            myData = XML_MSG_GENERIC_ERROR;
          endif;
          retLen = %len(%trim(myData));

          // -------------------
          // PART 4 -- job log scan CPF list 
          // new job log scan cpf
          curLen = %len(%trim(report));
          if cntCPF > 0 and curLen + 256 < maxLen;
            report = %trim(report) 
                 + '<joblogscan>'+x'25';
            for i=1 to cntCPF;
              curLen = %len(%trim(report));
              if curLen + 256 < maxLen;
                 report = %trim(report) 
                  + '<joblogrec>'+x'25';
                 report = %trim(report) 
                  + '<jobcpf>' 
                  + %trim(myCPF(i))
                  +'</jobcpf>'
                  +x'25';
                 report = %trim(report) 
                  + '<jobtime>'
                  + cCDATA1
                  + %trim(myTime(cntCPF))
                  + cCDATA2
                  +'</jobtime>'
                  +x'25';
                 report = %trim(report) 
                  + '<jobtext>'
                  + cCDATA1
                  + %trim(myHint(i))
                  + cCDATA2
                  +'</jobtext>'
                  +x'25';
                 report = %trim(report) 
                  + '</joblogrec>'+x'25';
              endif;
            endfor;
            report = %trim(report) 
                 + '</joblogscan>'+x'25';
          endif; // PART 4 -- job log scan CPF list

          // -------------------
          // PART 6 -- job log details 
          curLen = %len(%trim(report));
          if isjoblog = *ON and curLen + 512 < maxLen;
            // size job log to display
            stringLen = maxLen - (curLen + 128);    // more critical
            if isfull = *OFF and stringLen > 3072; // less warning
              stringLen = 3072;
            endif;
            if stringLen > retLen;
              stringLen = retLen;
            endif;
            // bottom of job log
            if stringLen < retLen;
              pos = retLen - stringLen;
              myData = %subst(myData:pos:stringLen);
            endif;
            report = %trim(report)
                 + '<joblog'
                 + ' job='''+%trim(jobName)+''''
                 + ' user='''+%trim(jobUserID)+''''
                 + ' nbr='''+%trim(jobNbr)+''''
                 + '>'+x'25';
            report = %trim(report)
                 + cCDATA1 
                 + %trim(myData)
                 + cCDATA2+x'25';
            report = %trim(report)
                 + '</joblog>'+x'25';
          endif; // PART 6 -- job log details

          // -------------------
          // PART x -- errors start over
          cacStatic(CAC_LEVEL_ERROR);

       endif; // PART x -- get job log

       // -------------------
       // PART 7 -- complete report

       // heavy handed penalty ???
       if isfull = *ON;
         report = %trim(report) + '</report>'+x'25';
       endif;

       // remove junk
       ooLen = %len(%trim(report));
       if ooLen > 1;
         bigJunkOut(%addr(report):%addr(report) + %size(report):*OFF);
       endif;
       
       // -------------------
       // log error dump (1.7.1)
       perfDumpAdd(report);

       // heavy handed penalty ???
       if isfull = *ON;
         // null terminate
         report = %trim(report) + x'00' + '</hack>';
       endif;

       // -------------------
       // PART 8 -- copy out report
       string = %addr(report);
       stringLen = %len(%trim(report));
       xmlOutput(string:stringLen:*OFF);
       rc = *ON;

       // -------------------
       // PART x -- report not well
       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;

       perfAdd(PERF_XML_SERVER_ERROR_JOBLOG);

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlLic          B                   export
     D xmlLic          PI             1N
      * vars
     D rc              s              1N   inz(*OFF)
     D report          S          32000A   inz(*BLANKS)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
      /free
       Monitor;

       sHint = 'xml license';

       // collect report
       report = *BLANKS;
       licXML(report:*ON);
       string = %addr(report);
       stringLen = %len(%trim(report));
       xmlOutput(string:stringLen:*OFF);
       rc = *ON;

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;


       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlSess         B                   export
     D xmlSess         PI             1N
     D   addHead                      1N   value options(*nopass)
     D   addJobNbr                    1N   value options(*nopass)
      * vars
     D rc              s              1N   inz(*OFF)
     D report          S          32000A   inz(*BLANKS)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D jobName         s             10A   inz(*BLANKS)
     D jobUserID       s             10A   inz(*BLANKS)
     D jobNbr          s              6A   inz(*BLANKS)
     D jobInfo         ds                  likeds(myJob_t)
      /free
       Monitor;

       sHint = 'xml session';

       // collect report
       report = *BLANKS;
       if (%parms >= 1 and addHead = *ON) or (%parms < 1);
         report = %trim(report) + %trim(xmlGetHead())+x'25';
       endif;
       report = %trim(report) + '<session';
       report = %trim(report) + ' key=''' + %trim(ipcFtok()) + '''';
       if %parms >= 2 and addJobNbr = *ON;
         rc = ileJob(jobName:jobUserID:jobNbr:jobInfo);
         report = %trim(report) + ' jobname=''' + %trim(jobName)   + '''';
         report = %trim(report) + ' jobuser=''' + %trim(jobUserID) + '''';
         report = %trim(report) + ' jobnbr='''  + %trim(jobNbr)    + '''';
       endif;
       if ipcIPC() = *BLANKS;
         report = %trim(report) + '/>'+x'25';
       else;
         report = %trim(report) + '>';
         report = %trim(report) + %trim(ipcIPC());
         report = %trim(report) + '</session>'+x'25';
       endif;
       // <session ...>...</session>
       // oooooooooooooooooooooooooo
       string = %addr(report);
       stringLen = %len(%trim(report));
       xmlOutput(string:stringLen:*OFF);
       rc = *ON;

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;


       return rc;
      /end-free
     P                 E

      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlBatRpt       B
     D xmlBatRpt       PI
     D   op                           1A   value
     D   nbr                         10i 0 value
     D   full                         1N   value options(*nopass)
      * vars
     D report          S           2048A   inz(*BLANKS)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
      /free
       Monitor;

       sHint = 'xml batch report';

       // forget about all output 
       xmlOutReset();
       // collect errors
       // pass along
       // client caller
       report = *BLANKS;
       if %parms >= 3 and full = *ON;
         report = %trim(xmlGetHead())+x'25';
         report = %trim(report) + '<report>'+x'25';
       endif;
       report = %trim(report) + '<batch>'+x'25';
       select;
       when op = XML_BAT_SET;
         report = %trim(report) 
                + '<id status=''set''>'+%char(nbr)+'</id>'+x'25';
       when op = XML_BAT_SMALL;
         report = %trim(report) 
                + '<id status=''small''>'+%char(nbr)+'</id>'+x'25';
       when op = XML_BAT_DEAD;
         report = %trim(report) 
                + '<id status=''done''>'+%char(nbr)+'</id>'+x'25';
       when op = XML_BAT_FULL;
         report = %trim(report) 
                + '<id status=''full''>'+%char(nbr)+'</id>'+x'25';
       // other?
       other;
       endsl;
       report = %trim(report) + '</batch>'+x'25';
       if %parms >= 3 and full = *ON;
         report = %trim(report) + '</report>'+x'25';
       endif;

       string = %addr(report);
       stringLen = %len(%trim(report));
       xmlOutput(string:stringLen:*OFF);

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
       Endmon;
      /end-free
     P                 E


      *****************************************************
      * perfXMl - report
      * return (NA)
      *****************************************************
     P xmlPerfRpt      B                   export
     D xmlPerfRpt      PI
     D   pData                         *   value
     D   report                   32000A
      * vars
     D rc              S              1N   inz(*OFF)
     D i               S             10i 0 inz(0)
     D pIdx            S               *   inz(*NULL)
     D pfCache         ds                  likeds(pfRec_t) based(pIdx)
      /free
       pIdx = pData;
       report = %trim(report) + '<performance>'+x'25';
       for i = 1 to PERFMAX;
         if pfCache.pfTicks = 0;
           leave;
         endif;
         report = %trim(report) + '<record>'+x'25';
         report = %trim(report) 
                  + '<label>' 
                  + %trim(perfMsgTxt(pfCache.pfCode))
                  + '</label>'+x'25';
         report = %trim(report) 
                  + '<ticks>' 
                  + %trim(%char(pfCache.pfTicks))
                  + '</ticks>'+x'25';
         report = %trim(report) + '</record>'+x'25';
         // next
         pIdx += %size(pfRec_t);
       endfor;
       report = %trim(report) + '</performance>'+x'25';
      /end-free
     P                 E


     P xmlPerf         B                   export
     D xmlPerf         PI             1N
     D   ipcCtl                            likeds(ipcRec_t)
      * vars
     D rc              s              1N   inz(*OFF)
     D report          S          32000A   inz(*BLANKS)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
      /free
       Monitor;

       sHint = 'xml performance';

       // collect report
       report = *BLANKS;
       report = %trim(report) + %trim(xmlGetHead())+x'25';
       report = %trim(report) + '<report>'+x'25';
       rc = ipcIsOk();
       if rc = *ON;
         xmlPerfRpt(%addr(ipcCtl.ipcTmClt):report);
         xmlPerfRpt(%addr(ipcCtl.ipcTmSrv):report);
       endif;
       report = %trim(report) + '</report>' + x'00';
       string = %addr(report);
       stringLen = %len(%trim(report));
       xmlOutput(string:stringLen:*OFF);
       rc = *ON;

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlPreSbm       B                   export
     D xmlPreSbm       PI             1N
      * vars
     D rc              s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
      * search elements
     D i               s             10i 0 inz(-1)
     D label           s             20A   inz(*BLANKS)
     D do1st           s              1N   inz(*ON)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pBeg            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free
       Monitor;

       sHint = 'xml run';

       // all elements
       rc = *ON;
       pTop = sInOrgP;
       pNxt = sInOrgP;
       pLst = sInOrgP + sInSize - 1;
       // loop elements
       elem(1) = 'sbmjob';
       // anything interesting (change 'to n' below) ???
       pBeg = *NULL;
       for i = 1 to 1;
         label = '<' + %trim(elem(i)) + '>';
         if pBeg = *NULL;
           pBeg = bigScan(pTop:label:pLst);
         endif;
         if pBeg <> *NULL;
           leave;
         endif;
       endfor;
       if pBeg = *NULL;
         return *ON;
       endif;
       dou pNxt = *NULL or rc = *OFF;
         pTop = pNxt;
         findElem = bigElem(pTop:pLst:elem:doNest:
                    doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         if do1st = *ON and findElem < XMLMAXATTR;
           do1st = *OFF;
         endif;
         select;
         // <(/)junk> ... </junk>
         //           ... EOF
         // B             E
         when findElem = 0;
           // < ... > ... <
           // oooooooooooo
           string = pB1;
           stringLen = pNxt - pB1;
         // <sbmjob ...> ... </sbmjob>
         // B        1   2     E
         when findElem = 1;
           rc = ipcOwnSbm(%str(pD1:pE1 - pD1));
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
       enddo;

       // nothing in XML?
       if do1st = *ON;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       endif;

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;

       return rc;
      /end-free
     P                 E



      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlPreRun       B                   export
     D xmlPreRun       PI             1N
      * vars
     D rc              s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
      * search elements
     D i               s             10i 0 inz(-1)
     D label           s             20A   inz(*BLANKS)
     D do1st           s              1N   inz(*ON)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pBeg            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free
       Monitor;

       sHint = 'xml run';

       // all elements
       rc = *ON;
       pTop = sInOrgP;
       pNxt = sInOrgP;
       pLst = sInOrgP + sInSize - 1;
       // loop elements
       elem(1) = 'start';
       elem(2) = 'use';
       elem(3) = 'stop';
       // anything interesting ???
       pBeg = *NULL;
       for i = 1 to 3;
         label = '<' + %trim(elem(i)) + '>';
         if i <> 2 and pBeg = *NULL;
           pBeg = bigScan(pTop:label:pLst);
         endif;
         if pBeg <> *NULL;
           leave;
         endif;
       endfor;
       if pBeg = *NULL;
         return *ON;
       endif;
       dou pNxt = *NULL or rc = *OFF;
         pTop = pNxt;
         findElem = bigElem(pTop:pLst:elem:doNest:
                    doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         if do1st = *ON and findElem < XMLMAXATTR;
           do1st = *OFF;
         endif;
         select;
         // <(/)junk> ... </junk>
         //           ... EOF
         // B             E
         when findElem = 0;
           // < ... > ... <
           // oooooooooooo
           string = pB1;
           stringLen = pNxt - pB1;
         // <start ...> ... </start>
         // B        1   2     E
         when findElem = 1;
           rc = ipcOwnJob(%str(pD1:pE1 - pD1));
         // <use ...> ... </use>
         // B        1   2     E
         when findElem = 2;
           rc = ipcOwnUse(%str(pD1:pE1 - pD1):*OFF);
         // <end ...> ... </end>
         // B        1   2     E
         when findElem = 3;
           rc = ipcOwnEnd(%str(pD1:pE1 - pD1));
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
       enddo;

       // nothing in XML?
       if do1st = *ON;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       endif;

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * xml do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P xmlRun          B                   export
     D xmlRun          PI             1N
      * vars
     D rc              s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D aVeryTop        S               *   inz(*NULL)
     D myNode          ds                  likeds(xmlNode_t) 
      * search elements
     D do1st           s              1N   inz(*ON)
     D findElem        s             10i 0 inz(-1)
     D pTop            s               *   inz(*NULL)
     D pBeg            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D elem            s             18A   dim(XMLMAXATTR) inz(*BLANKS)
     D doNest          s              1N   dim(XMLMAXATTR) inz(*OFF)
     D doNada          s              1N   inz(*OFF)
     D doCDATA         s              1N   inz(*OFF)
     D pB1             s               *   inz(*NULL)
     D pB2             s               *   inz(*NULL)
     D pD1             s               *   inz(*NULL)
     D pD2             s               *   inz(*NULL)
     D pE1             s               *   inz(*NULL)
     D pE2             s               *   inz(*NULL)
     D pNxt            s               *   inz(*NULL)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free
       Monitor;

       sHint = 'xml run';

       // check on server side (maybe someday)
       // rc = xmlPreSbm();

       // all elements
       xmlCTOR(myNode);       
       rc = *ON;
       aVeryTop = sInOrgP;
       pTop = sInOrgP;
       pNxt = sInOrgP;
       pLst = sInOrgP + sInSize - 1;
       elem(1) = 'pgm';
       elem(2) = 'cmd';
       elem(3) = 'sh';
       elem(4) = 'sql';
       elem(5) = 'diag';
       elem(6) = 'qsh';
       dou pNxt = *NULL or rc = *OFF;
         pTop = pNxt;
         findElem = bigElem(pTop:pLst:elem:doNest:
                    doNada:doCDATA:pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         if do1st = *ON and findElem < XMLMAXATTR;
           do1st = *OFF;
         endif;
         select;
         // <(/)junk> ... </junk>
         //           ... EOF
         // B             E
         when findElem = 0;
           // < ... > ... <
           // oooooooooooo
           string = pB1;
           stringLen = pNxt - pB1;
           xmlOutput(string:stringLen:*OFF);
         // <pgm ...> ... </pgm>
         // B        1   2     E
         when findElem = 1;
           perfAdd(PERF_XML_SERVER_PGM_RUN1);
           rc = xmlDoPgm(doNada:doCDATA
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
           perfAdd(PERF_XML_SERVER_PGM_RUN2);
         // <cmd ...> ... </cmd>
         // B        1   2     E
         when findElem = 2;
           perfAdd(PERF_XML_SERVER_CMD_RUN1);
           rc = xmlDoCmd(doNada:doCDATA
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
           perfAdd(PERF_XML_SERVER_CMD_RUN2);
         // <sh ...> ... </sh>
         // B       1   2    E
         when findElem = 3;
           perfAdd(PERF_XML_SERVER_SH_RUN1);
           rc = xmlDoSh(doNada:doCDATA
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
           perfAdd(PERF_XML_SERVER_SH_RUN2);
         // <sql ...> ... </sql>
         // B        1   2     E
         when findElem = 4;
           rc = xmlDoSql(doNada:doCDATA
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
         // <diag ...> ... </diag>
         // B        1   2     E
         when findElem = 5;
           perfAdd(PERF_XML_SERVER_DIAG_RUN1);
           rc = xmlDoDiag(doNada:doCDATA
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
           perfAdd(PERF_XML_SERVER_DIAG_RUN2);
         // <qsh ...> ... </qsh>
         // B       1   2    E
         when findElem = 6;
           perfAdd(PERF_XML_SERVER_SH_RUN1);
           rc = xmlDoQsh(doNada:doCDATA
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt);
           perfAdd(PERF_XML_SERVER_SH_RUN2);
         when findElem = -1;
           rc = *OFF;
         other;
         endsl;
         if rc = *OFF;
           xmlCpyErr(rc:0:'Z':doNada:doCDATA:aVeryTop
                  :pB1:pB2:pD1:pD2:pE1:pE2:pNxt:myNode);
         endif;
       enddo;

       // nothing in XML?
       if do1st = *ON;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       endif;

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;

       return rc;
      /end-free
     P                 E


