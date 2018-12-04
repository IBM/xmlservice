     H NOMAIN
     H AlwNull(*UsrCtl)
     H BNDDIR('QC2LE')

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

      *****************************************************
      * includes
      *****************************************************
      /copy plugconf_h
      /copy plugmri_h
      /copy plugxml_h
      /copy plugile_h
      /copy plugpase_h
      /copy plugerr_h
      /copy plugsql_h
      /copy plugcach_h
      /copy plugperf_h
      /copy plugbug_h
      /copy plugconv_h

      *****************************************************
      * misc cache
      *****************************************************
     D sRandom         S             10i 0 inz(1)

     D cacRandom       PR            10i 0
     D   limit                       10i 0 value

      *****************************************************
      * cache error records
      *****************************************************
     D sErrCache       DS                  likeds(erRec_t) dim(ERRSMAX)

      *****************************************************
      * cache perfomance records
      *****************************************************
     Dperf_t           ds                  qualified based(Template)
     D prfLastC                            likeds(timeval_t)
     D prfCurrC                            likeds(timeval_t)
     D prfCurrW                            likeds(timeval_t)
     D prfLastW                            likeds(timeval_t) dim(PERFMAX)
     D prfCache                            likeds(pfRec_t) dim(PERFMAX)
     D prfWatch                            likeds(pfRec_t) dim(PERFMAX)

     D sPrfCache       ds                  likeds(perf_t)

      *****************************************************
      * big scan (avoid strstr)
      *****************************************************
     D sBigInit        S              1N   inz(*OFF)
     D SZBIGSCAN       c                   const(256)
     D SZBIGLAST       c                   const(252)
     D SBIGXMLIPC      c                   const(253)
     D SBIGXMLTMP      c                   const(254)
     D SBIGPGMOPM      c                   const(255)
     D SBIGPGMPASE     c                   const(256)

     Dbigscan_t        ds                  qualified based(Template)
     D bigaddr                         *
     D bigsize                       10i 0
     D biguse                        10i 0
     D bigcnt                        10i 0
     D bigtype                        1A
     D bigpad                         3A

     D sBigScan        ds                  likeds(bigscan_t)
     D                                     dim(SZBIGSCAN)

     D sBigCtlOPM      ds                  likeds(paseRec_t)
     D sBigCtlPASE     ds                  likeds(paseRec_t)

      *****************************************************
      * xml batch processing
      *****************************************************
     Dbat_t            ds                  qualified based(Template)
     D batbig                        10i 0
     D batIsz                        10i 0
     D batOsz                        10i 0
     D batType                        1A

     D sBat            ds                  likeds(bat_t)
     D                                     dim(IPCBATMAX)

      *****************************************************
      * xml scan positions
      *****************************************************
     DxmlRec_t         ds                  qualified based(Template)
     D  xElemCnt                     10i 0
     D  xFindElem                    10i 0
     D  xKeyElem                     10i 0
     D  xElemTop                     10i 0
     D  xElemTop1                    10i 0
     D  xElemTop2                    10i 0
     D  xDataVal1                    10i 0
     D  xDataVal2                    10i 0
     D  xElemEnd1                    10i 0
     D  xElemEnd2                    10i 0
     D  xElemNext                    10i 0
     D  xDoNada                       1N
     D  xDoCDATA                      1N
     
     D sXmlCache       DS                  likeds(xmlRec_t) dim(XMLMAXXML)
     D sXmlCachei      S             10i 0 inz(1)
     D sXmlCacheX      S             10i 0 inz(1)

     D XMLMAXBEG       c                   const(100)
     
     DxmlBeg_t         ds                  qualified based(Template)
     D  xElemIdx                     10i 0
     D  xElemTop                     10i 0
     
     D sXmlBeg         DS                  likeds(xmlBeg_t) dim(XMLMAXBEG)
     D sXmlBegX        S             10i 0 inz(1)

      *****************************************************
      * call pgm cache
      *****************************************************
     DpgmRec_t         ds                  qualified based(Template)
     D pgmIlePtr                       *
     D pgmIleProc                      *
     D pgmObjName                    10A
     D pgmLibName                    10A
     D pgmSymName                   128A
     D pgmLabel                      30A
     D pgmPad                        14A
     D pgmActMark                    10i 0
     D pgmUseCnt                     10i 0
     D pgmBigAtt                     10i 0
     D pgmBigDou                     10i 0
     D pgmBigOff                     10i 0
     D pgmBigNxt                     10i 0
     D pgmBigPush                    10i 0
     D pgmBigLab                     10i 0
     D pgmRecType                    10i 0

     D sPgmCache       DS                  likeds(pgmRec_t) dim(CACHEMAX)

      *****************************************************
      * pgm overlay markers
      *****************************************************
     DovrRec_t         ds                  qualified based(Template)
     D ovrtype                       10i 0
     D ovrcnt                        10i 0
     D ovrargvOff                    10i 0
     D ovrargvSz                     10i 0
     D ovrparmOff                    10i 0
     D ovrparmSz                     10i 0
     D ovrretOff                     10i 0
     D ovrretSz                      10i 0
     D ovrsigOff                     10i 0
     D ovrsigSz                      10i 0

     D sOvrCache       DS                  likeds(ovrRec_t) dim(ILEMAXOVR)

      *****************************************************
      * xml pgm do/enddo caching
      *****************************************************
      * ile <records> caching
     D sXmlARec        ds                  likeds(xmlNode_t) dim(XMLMAXATTE)
      * ile input cache values (avoid convert)
     D sXmlATT         ds                  likeds(xmlNode_t) dim(XMLMAXATTE)
      * track dou=label, enddo=label (live)
     D sXmlDOU         ds                  likeds(xmlNode_t) dim(XMLMAXDOU)
      * track offset=label (live)
     D sXmlOFFSET      ds                  likeds(xmlNode_t) dim(XMLMAXDOU)
      * track next=label (live)
     D sXmlNXTOFF      ds                  likeds(xmlNode_t) dim(XMLMAXDOU)
      * track push length
     D sXmlPUSH        ds                  likeds(xmlNode_t) dim(XMLMAXDOU)
      * label cache
     D sLabCache       s             30A   dim(XMLMAXATTE)

      *****************************************************
      * xml type cache
      *****************************************************
     DtypeIV_t         ds                  qualified based(Template)
     D typecnt                       10i 0
     D typedigits                    10i 0
     D typefrac                      10i 0
     D typestr                       16A
     D typeattr                       1A

     D sInTYP          ds                  likeds(typeIV_t)
     D                                     dim(XMLMAXTYPE)

      *****************************************************
      * ile values cache (avoid convert)
      *****************************************************
     D SZILEFDEC       c                   const(63)
     Dilef64_t         ds                  qualified based(Template)
     D ilefcnt                       10i 0
     D ilefstrz                      10i 0
     D ilefdigits                    10i 0
     D ilefrac                       10i 0
     D ilefdecz                      10i 0
     D ilef64                         8f
     D ilefstr                       64A
     D ilefdec                       63A
     D ilefattr                       1A

     D sInF64          ds                  likeds(ilef64_t)
     D                                     dim(ILEMAXF64)

     D sOutF64         ds                  likeds(ilef64_t)
     D                                     dim(ILEMAXF64)

      *****************************************************
      * sql cache
      *****************************************************
     DhOpt_t           ds                  qualified based(Template)
     D hauto                          1N

     D sSqlConn        DS                  likeds(hConn_t) 
     D                                     dim(SQLMAXCONN)

     D sSqlConnSet     DS                  likeds(sqOpt_t) 
     D                                     dim(SQLMAXOPTS)

     D sSqlStmt        DS                  likeds(hStmt_t) 
     D                                     dim(SQLMAXSTMT)


      *****************************************************
      * pase call lib cache                         (1.8.5)
      *****************************************************
     DlibRec_t         ds                  qualified based(Template)
     D libLibPtr                     20U 0
     D libLibName                    32A
     D libMbrName                    32A
     D libPthName                  4096A

     D sLibCache       DS                  likeds(libRec_t) dim(PASELIBMAX)

      *****************************************************
      * pase call sym cache                         (1.8.5)
      *****************************************************
     DsymRec_t         ds                  qualified based(Template)
     D symPthNbr                     10i 0
     D symSymPtr                     20U 0
     D symSymName                   256A

     D sSymCache       DS                  likeds(symRec_t) dim(PASESYMMAX)


      *****************************************************
      * iconv processing
      *****************************************************
     D CNVOPNOK        c                   const(12344321)
     D sCnvCache       ds                  likeds(ciconv_t)
     D                                     dim(CNVOPNMAX)

      *****************************************************
      * cache set global
      * return (NA)
      *****************************************************
     P cacStatic       B                   export
     D cacStatic       PI
     D  level                        10i 0 value
      /free
       // --------------
       // common statics
       // cacClrPrf(); see perfInit
       cacClrErr();
       perfAdd(PERF_ANY_WATCH_CACHE:*ON);

       // turn back now?
       if level < CAC_LEVEL_PGM;
         perfAdd(PERF_ANY_WATCH_CACHE:*OFF);
         return;
       endif;

       // --------------
       // per pgm cache
       cacClrXML();
       cacClrAtt();
       cacClrARec();
       cacClrDou();
       cacClrOff();
       cacClrNxt(); // overlay next offset (1.9.2)
       cacClrLen();
       cacClrOvr();
       cacClrLab();

       // turn back now?
       if level < CAC_LEVEL_HEAP;
         perfAdd(PERF_ANY_WATCH_CACHE:*OFF);
         return;
       endif;

       // --------------
       // any pgm cache
       cacClrPgm();
       // cacClrLib();
       // cacClrSym();

       // --------------
       // batch cache
       cacClrBat();

       // --------------
       // heap allocations cache
       cacClrBig();

       // turn back now?
       if level < CAC_LEVEL_SQL;
         perfAdd(PERF_ANY_WATCH_CACHE:*OFF);
         return;
       endif;

       // --------------
       // sql cache
       cacClrDB2();
       cacClrOPT();
       cacClrStm();

       // turn back now?
       if level < CAC_LEVEL_ALL;
         perfAdd(PERF_ANY_WATCH_CACHE:*OFF);
         return;
       endif;

       // --------------
       // any type='xxx'
       cacClrTyp();

       // --------------
       // any packed, zone, real
       cacClrF64(*OFF);
       cacClrF64(*ON);

       // --------------
       // iconv
       cacClrCnv();

       // --------------
       // cache overcommit
       sRandom = 1;

       perfAdd(PERF_ANY_WATCH_CACHE:*OFF);

      /end-free
     P                 E



      *****************************************************
      * level X -- independent managed records
      *****************************************************


      *****************************************************
      * cache performance records
      *****************************************************
     P cacClrPrf       B                   export
     D cacClrPrf       PI
      * vars
     D rc              S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D ptrPrfP         s               *   inz(*NULL)
     D anyPrf          ds                  likeds(perf_t) based(ptrPrfP)
      /free
       ptrPrfP = %addr(sPrfCache);
       memset(ptrPrfP:0:%size(anyPrf));
      /end-free
     P                 E

     P cacScanPrf      B                   export
     D cacScanPrf      PI             1N
     D   rptBuff                       *   value
     D   rptLen                      10i 0 value
      * vars
     D len             S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D j               S             10i 0 inz(0)
     D ptrPrfP         s               *   inz(*NULL)
     D anyPrf          ds                  likeds(perf_t) based(ptrPrfP)
      /free
       ptrPrfP = %addr(sPrfCache);

       for i=1 to PERFMAX;
         if anyPrf.prfCache(i).pfTicks = 0;
           j += 1;
           anyPrf.prfCache(i).pfCode  = anyPrf.prfWatch(j).pfCode;
           anyPrf.prfCache(i).pfTicks = anyPrf.prfWatch(j).pfTicks;
         endif;
       endfor;
       len = %size(pfRec_t) * PERFMAX;
       memset(rptBuff:0:rptLen);
       if rptLen > len;
         cpybytes(rptBuff:%addr(anyPrf.prfCache):len);
       else;
         cpybytes(rptBuff:%addr(anyPrf.prfCache):rptLen);
       endif;
       return *ON;
      /end-free
     P                 E

     P cacAddPrf       B                   export
     D cacAddPrf       PI
     D   myCode                       5i 0 value
     D   myOnOff                      1N   value options(*nopass)
      * vars
     D rc              S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D sec             S             10i 0 inz(0)
     D usec            S             10i 0 inz(1)
     D ptrPrfP         s               *   inz(*NULL)
     D anyPrf          ds                  likeds(perf_t) based(ptrPrfP)
      /free
       ptrPrfP = %addr(sPrfCache);

       // start clock
       if anyPrf.prfLastW(1).tv_sec = 0
       and anyPrf.prfLastW(1).tv_usec = 0;
         rc = gettimeofday(%addr(anyPrf.prfLastC):*NULL);
         anyPrf.prfLastW(1).tv_sec = anyPrf.prfLastC.tv_sec;
         anyPrf.prfLastW(1).tv_usec = anyPrf.prfLastC.tv_usec;
       endif;
       if myCode = PERF_RUN_START;
         return;
       endif;

       // timer watch collections
       if %parms >= 2;
        for i=1 to PERFMAX;
         if myOnOff = *ON;
          if anyPrf.prfWatch(i).pfCode = 0
          or anyPrf.prfWatch(i).pfCode = myCode;
           anyPrf.prfWatch(i).pfCode = myCode;
           rc = gettimeofday(%addr(anyPrf.prfLastW(i)):*NULL);
           leave;
          endif;
         else;
          if anyPrf.prfWatch(i).pfCode = myCode;
           anyPrf.prfWatch(i).pfCode = myCode;
           rc = gettimeofday(%addr(anyPrf.prfCurrW):*NULL);
           if anyPrf.prfCurrW.tv_sec > anyPrf.prfLastW(i).tv_sec;
             sec = anyPrf.prfCurrW.tv_sec - anyPrf.prfLastW(i).tv_sec;
             sec = sec * 1000000; // usec
           endif;
           if anyPrf.prfCurrW.tv_usec > anyPrf.prfLastW(i).tv_usec;
             usec = anyPrf.prfCurrW.tv_usec - anyPrf.prfLastW(i).tv_usec;
           endif;
           anyPrf.prfWatch(i).pfTicks += sec + usec;
           anyPrf.prfLastW(i).tv_sec = anyPrf.prfCurrW.tv_sec;
           anyPrf.prfLastW(i).tv_usec = anyPrf.prfCurrW.tv_usec;
           leave;
          endif;
         endif;
        endfor;
        return;
       endif;
       // timer delta steps
       for i=1 to PERFMAX;
         if anyPrf.prfCache(i).pfTicks = 0;
           anyPrf.prfCache(i).pfCode = myCode;
           rc = gettimeofday(%addr(anyPrf.prfCurrC):*NULL);
           if anyPrf.prfCurrC.tv_sec > anyPrf.prfLastC.tv_sec;
             sec = anyPrf.prfCurrC.tv_sec - anyPrf.prfLastC.tv_sec;
             sec = sec * 1000000; // usec
           endif;
           if anyPrf.prfCurrC.tv_usec > anyPrf.prfLastC.tv_usec;
             usec = anyPrf.prfCurrC.tv_usec - anyPrf.prfLastC.tv_usec;
           endif;
           anyPrf.prfCache(i).pfTicks = sec + usec;
           anyPrf.prfLastC.tv_sec = anyPrf.prfCurrC.tv_sec;
           anyPrf.prfLastC.tv_usec = anyPrf.prfCurrC.tv_usec;
           leave;
         endif;
       endfor;
      /end-free
     P                 E



      *****************************************************
      * level 0 -- records
      *****************************************************


      *****************************************************
      * cache error records
      *****************************************************
     P cacClrErr       B                   export
     D cacClrErr       PI
      * vars
     D rcb             S              1N   inz(*OFF)
     D rc              S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D ptrErrP         s               *   inz(*NULL)
     D anyErr          ds                  likeds(erRec_t)
     D                                     dim(ERRSMAX) based(ptrErrP)
      /free
       ptrErrP = %addr(sErrCache);
       memset(ptrErrP:0:%size(anyErr:*ALL));

       ileEZero();
       rcb = PaseEZero();

      /end-free
     P                 E

     P cacScanErr      B                   export
     D cacScanErr      PI             1N
     D   idx                         10i 0 value
     D   rec                               likeds(erRec_t)
     D ptrErrP         s               *   inz(*NULL)
     D anyErr          ds                  likeds(erRec_t)
     D                                     dim(ERRSMAX) based(ptrErrP)
      /free
       ptrErrP = %addr(sErrCache);

       if idx < 0 or idx > ERRSMAX 
       or anyErr(idx).erErrXml = 0;
         return *OFF;
       endif;

       rec.erErrXml  =  anyErr(idx).erErrXml;
       rec.erErrNo   =  anyErr(idx).erErrNo;
       rec.erErrNoPs =  anyErr(idx).erErrNoPs;
       rec.erErrSYS  =  anyErr(idx).erErrSYS;
       rec.erErrCODE =  anyErr(idx).erErrCODE;
       rec.erErrCPF  =  anyErr(idx).erErrCPF;
       rec.erErrSTAT =  anyErr(idx).erErrSTAT;
       rec.erHelp    =  anyErr(idx).erHelp;

       return *ON;
      /end-free
     P                 E


     P cacAddErr       B                   export
     D cacAddErr       PI
     D   errXml                      10i 0 value
     D   errHelp                     60A   value
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)
      * vars
     D rc              S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D ptrErrP         s               *   inz(*NULL)
     D anyErr          ds                  likeds(erRec_t)
     D                                     dim(ERRSMAX) based(ptrErrP)
      /free
       ptrErrP = %addr(sErrCache);

       // store in empty slot
       for i=2 to ERRSMAX;
         if anyErr(i).erErrXml = 0;
           anyErr(i).erErrXml  = errXml;
           anyErr(i).erErrNo   = ileErrno();
           anyErr(i).erErrNoPs = PaseErrno();
           anyErr(i).erHelp    = errHelp;
           // any message info?
           anyErr(i).erErrCPF = ileMsgId();
           anyErr(i).erErrSYS = ileStatus();
           // any sql info
           if %parms >= 3;
             anyErr(i).erErrCODE = errSqlCode;
           endif;
           if %parms >= 4;
             anyErr(i).erErrSTAT = errSqlStat;
           endif;

           // save last error
           anyErr(1).erErrXml  = anyErr(i).erErrXml;
           anyErr(1).erErrNo   = anyErr(i).erErrNo;
           anyErr(1).erErrNoPs = anyErr(i).erErrNoPs;
           anyErr(1).erErrSYS  = anyErr(i).erErrSYS;
           anyErr(1).erErrCODE = anyErr(i).erErrCODE;
           anyErr(1).erErrCPF  = anyErr(i).erErrCPF;
           anyErr(1).erErrSTAT = anyErr(i).erErrSTAT;
           anyErr(1).erHelp    = anyErr(i).erHelp;

           leave;
         endif;
       endfor;
      /end-free
     P                 E



      *****************************************************
      * level 1 -- program cache
      *****************************************************


      *****************************************************
      * xml scan element
      *****************************************************
     P cacClrXML       B                   export
     D cacClrXML       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrXMLP         s               *   inz(*NULL)
     D anyXML          ds                  likeds(xmlRec_t)
     D                                     dim(XMLMAXXML) based(ptrXMLP)
      /free
       ptrXMLP = %addr(sXmlCache);
       memset(ptrXMLP:0:%size(anyXML:*ALL));
       sXmlCachei = 1;
       sXmlCacheX = 1;
       
       memset(%addr(sXmlBeg):0:%size(sXmlBeg:*ALL));
       sXmlBegX = 0;
      /end-free
     P                 E
     

     P cacFixXML       B                   export
     D cacFixXML       PI            10i 0
      * vars
     D where           s             10i 0 inz(0)
     D h               s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrOne          s               *   inz(*NULL)
     D ptrTwo          s               *   inz(*NULL)
     D ptrXMLP         s               *   inz(*NULL)
     D anyXML          ds                  likeds(xmlRec_t)
     D                                     dim(XMLMAXXML) based(ptrXMLP)
      /free
       ptrXMLP = %addr(sXmlCache);

       // scan the cache backward ...
       i = sXmlCacheX;
       dow i > 0;
         // found in cache?
         select;
         when anyXML(i).xKeyElem  > 0
         and  anyXML(i).xElemEnd1 = 0;
           where = i;
         // other?
         other;
         endsl;
         i = i - 1;
       enddo;
       
       // clear back to last full <item>...</item> boundary
       if where > 0;
         ptrOne = %addr(anyXML(where));
         ptrTwo = %addr(anyXML(sXmlCacheX)) + %size(xmlRec_t);
         sXmlCacheX = where - 1;
         if ptrTwo > ptrOne;
           memset(ptrOne:x'00':ptrTwo - ptrOne);
         endif;
       endif;

       return sXmlCacheX;
      /end-free
     P                 E


     P cacGetXML       B                   export
     D cacGetXML       PI            10i 0
     D  xKeyElem                     10i 0 value
      * vars
     D where           s             10i 0 inz(0)
     D h               s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrXMLP         s               *   inz(*NULL)
     D anyXML          ds                  likeds(xmlRec_t)
     D                                     dim(XMLMAXXML) based(ptrXMLP)
      /free
       ptrXMLP = %addr(sXmlCache);

       // scan the cache backward ...
       i = sXmlCacheX;
       dow i > 0;
         // found in cache?
         select;
         when anyXML(i).xKeyElem  = xKeyElem
         and  anyXML(i).xElemEnd1 = 0;
           where = i;
           leave;
         // other?
         other;
         endsl;
         i = i - 1;
       enddo;

       return where;
      /end-free
     P                 E
     

     P cacUpdXML       B                   export
     D cacUpdXML       PI            10i 0
     D  where                        10i 0 value
     D  aVeryTop                       *   value
     D  aDataVal2                      *   value
     D  aElemEnd1                      *   value
     D  aElemEnd2                      *   value
     D  aElemNext                      *   value
      * vars
     D h               s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrXMLP         s               *   inz(*NULL)
     D anyXML          ds                  likeds(xmlRec_t)
     D                                     dim(XMLMAXXML) based(ptrXMLP)
      /free
       ptrXMLP = %addr(sXmlCache);

       // where
       if where > 0;
         if aDataVal2 <> *NULL;
           anyXML(where).xDataVal2 = aDataVal2 - aVeryTop;
         else;
           anyXML(where).xDataVal2 = 0;
         endif;
         if aElemEnd1 <> *NULL;
           anyXML(where).xElemEnd1 = aElemEnd1 - aVeryTop;
         else;
           anyXML(where).xElemEnd1 = 0;
         endif;
         if aElemEnd1 <> *NULL;
           anyXML(where).xElemEnd2 = aElemEnd2 - aVeryTop;
         else;
           anyXML(where).xElemEnd2 = 0;
         endif;
         if aElemNext <> *NULL;
           anyXML(where).xElemNext = aElemNext - aVeryTop;
         else;
           anyXML(where).xElemNext = 0;
         endif;
       endif;

       return where;
      /end-free
     P                 E

     P cacScanXML      B                   export
     D cacScanXML      PI            10i 0
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
     D  xKeyElem                     10i 0
      * vars
     D where           s             10i 0 inz(0)
     D h               s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D k               s             10i 0 inz(0)
     D offset1         s             10i 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D ptrXMLP         s               *   inz(*NULL)
     D anyXML          ds                  likeds(xmlRec_t)
     D                                     dim(XMLMAXXML) based(ptrXMLP)
      /free
       if aElemTop = *NULL
       or aVeryTop = *NULL
       or aElemTop < aVeryTop;
         return where;
       endif;

       perfAdd(PERF_ANY_WATCH_CACXML:*ON);


       ptrXMLP = %addr(sXmlCache);

       // make sure on top of '<' (1.8.1)
       pCopy = aElemTop;
       for i = 1 to 128;
         if myCopy.bytex = '<';
           aElemTop = pCopy;
           leave;
         else;
           pCopy += 1;
         endif;
       endfor;

       // start index close to offset
       offset1 = aElemTop - aVeryTop;

       // assume next element (high probability guess)
       k = sXmlCachei + 1; 


       // scan the cache ...
       for h = 1 to 2;
        if h = 2;
         for i = 1 to sXmlBegX; // (1.8.1)
           if sXmlBeg(i).xElemTop > offset1;
             leave;
           endif;
           sXmlCachei = sXmlBeg(i).xElemIdx;
         endfor;
         k = sXmlCachei;
        endif;
        for i = k to sXmlCacheX;
         // found in cache?
         select;
         when anyXML(i).xElemCnt = 0;
           leave;
         when anyXML(i).xElemTop > offset1; // (1.8.1)
           leave;
         when anyXML(i).xElemTop = offset1;
           where = i;
           sXmlCachei = i;
           leave;
         // other?
         other;
         endsl;
        endfor;
        if where > 0;
          leave;
        endif;
       endfor;

       // bump where used counter
       if where > 0;
         if anyXML(where).xElemCnt < XMLMAXCNT;
           anyXML(where).xElemCnt += 1;
         endif;
         if anyXML(where).xElemTop1 <> 0;
           xElemTop1 = aVeryTop + anyXML(where).xElemTop1;
         else;
           xElemTop1 = *NULL;
         endif;
         if anyXML(where).xElemTop2 <> 0;
           xElemTop2 = aVeryTop + anyXML(where).xElemTop2;
         else;
           xElemTop2 = *NULL;
         endif;
         if anyXML(where).xDataVal1 <> 0;
           xDataVal1 = aVeryTop + anyXML(where).xDataVal1;
         else;
           xDataVal1 = *NULL;
         endif;
         if anyXML(where).xDataVal2 <> 0;
           xDataVal2 = aVeryTop + anyXML(where).xDataVal2;
         else;
           xDataVal2 = *NULL;
         endif;
         if anyXML(where).xElemEnd1 <> 0;
           xElemEnd1 = aVeryTop + anyXML(where).xElemEnd1;
         else;
           xElemEnd1 = *NULL;
         endif;
         if anyXML(where).xElemEnd2 <> 0;
           xElemEnd2 = aVeryTop + anyXML(where).xElemEnd2;
         else;
           xElemEnd2 = *NULL;
         endif;
         if anyXML(where).xElemNext <> 0;
           xElemNext = aVeryTop + anyXML(where).xElemNext;
         else;
           xElemNext = *NULL;
         endif;
         xDoNada   = anyXML(where).xDoNada;
         xDoCDATA  = anyXML(where).xDoCDATA;
         xFindElem = anyXML(where).xFindElem;
         xKeyElem  = anyXML(where).xKeyElem;
       endif;

       perfAdd(PERF_ANY_WATCH_CACXML:*OFF);

       return where;
      /end-free
     P                 E

     P cacAddXML       B                   export
     D cacAddXML       PI            10i 0
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
      * vars
     D where           s             10i 0 inz(0)
     D h               s             10i 0 inz(0)
     D k               s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D offset1         s             10i 0 inz(0)
     D offset2         s             10i 0 inz(0)
     D ptrXMLP         s               *   inz(*NULL)
     D anyXML          ds                  likeds(xmlRec_t)
     D                                     dim(XMLMAXXML) based(ptrXMLP)
      /free
       if aElemTop = *NULL
       or aVeryTop = *NULL
       or aElemTop < aVeryTop
       or sXmlCacheX = XMLMAXXML;
         return where;
       endif;

       ptrXMLP = %addr(sXmlCache);

       // save for fast way ...
       offset1 = aElemTop - aVeryTop;
       offset2 = aElemTop2 - aVeryTop;
       for h = 1 to 2;
        if h < 2;
          if aDups = *ON;
            k = sXmlCachei; // assume update
          else;
            k = sXmlCacheX; // always back of bus
          endif;
        else;
          if aDups = *ON;
            k = 1;          // look from start
          else;
            k = sXmlCacheX; // always back of bus
          endif;
        endif;
        for i = k to XMLMAXXML;
         // found in cache?
         select;
         // empty cache slot
         when anyXML(i).xElemCnt = 0;
           where = i;
           sXmlCachei = i;
           sXmlCacheX = i;
           if sXmlCacheX = 1
           or sXmlCacheX = 10
           or sXmlCacheX = 20
           or sXmlCacheX = 30
           or sXmlCacheX = 40
           or sXmlCacheX = 50
           or sXmlCacheX = 60
           or sXmlCacheX = 70
           or sXmlCacheX = 80
           or sXmlCacheX = 90
           or sXmlCacheX = 100
           or sXmlCacheX = 200
           or sXmlCacheX = 300
           or sXmlCacheX = 400
           or sXmlCacheX = 500
           or sXmlCacheX = 600
           or sXmlCacheX = 700
           or sXmlCacheX = 800
           or sXmlCacheX = 900
           or sXmlCacheX = 1000
           or sXmlCacheX = 1500
           or sXmlCacheX = 2000
           or sXmlCacheX = 2500
           or sXmlCacheX = 3000
           or sXmlCacheX = 3500
           or sXmlCacheX = 4000
           or sXmlCacheX = 4500
           or sXmlCacheX = 5000
           or sXmlCacheX = 5500
           or sXmlCacheX = 6000
           or sXmlCacheX = 6500
           or sXmlCacheX = 7000
           or sXmlCacheX = 7500
           or sXmlCacheX = 8000
           or sXmlCacheX = 8500
           or sXmlCacheX = 9000
           or sXmlCacheX = 9500
           or sXmlCacheX = 10000
           or sXmlCacheX = 11500
           or sXmlCacheX = 12000
           or sXmlCacheX = 12500
           or sXmlCacheX = 13000
           or sXmlCacheX = 13500
           or sXmlCacheX = 14000
           or sXmlCacheX = 14500
           or sXmlCacheX = 15000
           or sXmlCacheX = 15500
           or sXmlCacheX = 16000
           or sXmlCacheX = 16500
           or sXmlCacheX = 17000
           or sXmlCacheX = 17500
           or sXmlCacheX = 18000
           or sXmlCacheX = 18500
           or sXmlCacheX = 19000
           or sXmlCacheX = 19500;
             if sXmlBegX < XMLMAXBEG;
               sXmlBegX += 1;
               sXmlBeg(sXmlBegX).xElemIdx = i;
               sXmlBeg(sXmlBegX).xElemTop = offset1;
             endif;
           endif;
           leave;
         // update based on <item ...>
         //                          x
         when aDups = *ON 
         and aElemTop2 <> *NULL 
         and anyXML(i).xElemTop2 = offset2;
           where = i;
           sXmlCachei = i;
           leave;
         // other?
         other;
         endsl;
        endfor;
        // found it ...
        if where > 0;
          leave;
        endif;
       endfor;

       // @ADC no longer (1.7.4)
       // not found ...
       // reuse random slot
       // if where = 0;
       //  where = cacRandom(XMLMAXXML);
       // endif;

       if where > 0;
         anyXML(where).xElemCnt  = 1;
         anyXML(where).xElemTop  = aElemTop  - aVeryTop;
         if aElemTop1 <> *NULL;
           anyXML(where).xElemTop1 = aElemTop1 - aVeryTop;
         else;
           anyXML(where).xElemTop1 = 0;
         endif;
         if aElemTop2 <> *NULL;
           anyXML(where).xElemTop2 = aElemTop2 - aVeryTop;
         else;
           anyXML(where).xElemTop2 = 0;
         endif;
         if aDataVal1 <> *NULL;
           anyXML(where).xDataVal1 = aDataVal1 - aVeryTop;
         else;
           anyXML(where).xDataVal1 = 0;
         endif;
         if aDataVal2 <> *NULL;
           anyXML(where).xDataVal2 = aDataVal2 - aVeryTop;
         else;
           anyXML(where).xDataVal2 = 0;
         endif;
         if aElemEnd1 <> *NULL;
           anyXML(where).xElemEnd1 = aElemEnd1 - aVeryTop;
         else;
           anyXML(where).xElemEnd1 = 0;
         endif;
         if aElemEnd1 <> *NULL;
           anyXML(where).xElemEnd2 = aElemEnd2 - aVeryTop;
         else;
           anyXML(where).xElemEnd2 = 0;
         endif;
         if aElemNext <> *NULL;
           anyXML(where).xElemNext = aElemNext - aVeryTop;
         else;
           anyXML(where).xElemNext = 0;
         endif;
         anyXML(where).xDoNada   = aDoNada;
         anyXML(where).xDoCDATA  = aDoCDATA;
         anyXML(where).xFindElem = aFindElem;
         anyXML(where).xKeyElem  = aKeyElem;
       endif;

       return where;
      /end-free
     P                 E

      *****************************************************
      * xml element attribute caching (XML node)
      *****************************************************
     P cacClrAtt       B                   export
     D cacClrAtt       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXATTE) based(ptrAttP)
      /free
       ptrAttP = %addr(sXmlATT);
       memset(ptrAttP:0:%size(anyATT:*ALL));
      /end-free
     P                 E

     P cacScanAtt      B                   export
     D cacScanAtt      PI            10i 0
     D  inATT                              likeds(xmlNode_t)
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXATTE) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if inATT.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(inATT.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigAtt);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlATT);
       endif;

       // scan the cache ...
       for i = 1 to XMLMAXATTE;
         // found in cache?
         select;
         when anyATT(i).cacElemCnt = 0;
           leave;
         when anyATT(i).cacElemTop1 = inATT.cacElemTop1;
           where = i;
           leave;
         // other?
         other;
         endsl;
       endfor;

       // bump where used counter
       if where > 0;
         if anyATT(where).cacElemCnt < XMLMAXCNT;
           anyATT(where).cacElemCnt += 1;
         endif;
         xmlCOPY(inATT:anyATT(where));
       endif;

       return where;
      /end-free
     P                 E

     P cacAddAtt       B                   export
     D cacAddAtt       PI
     D  inATT                              likeds(xmlNode_t)
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXATTE) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if inATT.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(inATT.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigAtt);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlATT);
       endif;

       // save for fast way ...
       where = 0;
       for i = 1 to XMLMAXATTE;
         // empty cache slot
         if anyATT(i).cacElemCnt = 0;
           where = i;
           leave;
         endif;
       endfor;

       // not found ...
       // reuse random slot
       if where = 0;
         where = cacRandom(XMLMAXATTE);
       endif;

       xmlCOPY(anyATT(where):inATT);
       anyATT(where).cacElemCnt = 1;

      /end-free
     P                 E


      *****************************************************
      * xml <record> element attribute caching (XML node)
      *****************************************************
     P cacClrARec      B                   export
     D cacClrARec      PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXATTE) based(ptrAttP)
      /free
       ptrAttP = %addr(sXmlARec);
       memset(ptrAttP:0:%size(anyATT:*ALL));
      /end-free
     P                 E

     P cacScanARec     B                   export
     D cacScanARec     PI            10i 0
     D  index                        10i 0 value
     D  inATT                              likeds(xmlNode_t)
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXATTE) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       if index < 1 or index > XMLMAXATTE;
         return where;
       endif;
      
       // cache attributes
       ptrAttP = %addr(sXmlARec);

       // scan the cache ...
       i = index;
       // found in cache?
       select;
       when anyATT(i).cacElemCnt > 0;
         where = i;
       // other?
       other;
       endsl;

       // bump where used counter
       if where > 0;
         if anyATT(where).cacElemCnt < XMLMAXCNT;
           anyATT(where).cacElemCnt += 1;
         endif;
         xmlCOPY(inATT:anyATT(where));
       endif;

       return where;
      /end-free
     P                 E

     P cacAddARec      B                   export
     D cacAddARec      PI
     D  inATT                              likeds(xmlNode_t)
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXATTE) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       ptrAttP = %addr(sXmlARec);

       // save for fast way ...
       where = 0;
       for i = 1 to XMLMAXATTE;
         // empty cache slot
         if anyATT(i).cacElemCnt = 0;
           where = i;
           leave;
         endif;
       endfor;

       if where > 0;
         xmlCOPY(anyATT(where):inATT);
         anyATT(where).cacElemCnt = 1;
       endif;

      /end-free
     P                 E

      *****************************************************
      * pgm labels
      *****************************************************
     P cacClrLab       B                   export
     D cacClrLab       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrLabP         s               *   inz(*NULL)
     D anyLab          s             30A   dim(XMLMAXATTE) based(ptrLabP)
      /free
       ptrLabP = %addr(sLabCache);
       memset(ptrLabP:x'40':%size(anyLab:*ALL));
      /end-free
     P                 E

     P cacScanLab      B                   export
     D cacScanLab      PI            10i 0
     D  myLab                        30A   value
     D  inATT                              likeds(xmlNode_t)
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrLabP         s               *   inz(*NULL)
     D anyLab          s             30A   dim(XMLMAXATTE) based(ptrLabP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if inATT.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(inATT.pgmIndex));
         ptrLabP = cacScanBig(anyDC.pgmBigLab);
       endif;
       if ptrLabP = *NULL;
         ptrLabP = %addr(sLabCache);
       endif;

       for i = 1 to XMLMAXATTE;
         if anyLab(i) = *BLANKS;
           leave;
         elseif anyLab(i) = myLab;
           where = i;
           leave;
         endif;
       endfor;
       return where;
      /end-free
     P                 E

     P cacAddLab       B                   export
     D cacAddLab       PI            10i 0
     D  myLab                        30A   value
     D  inATT                              likeds(xmlNode_t)
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrLabP         s               *   inz(*NULL)
     D anyLab          s             30A   dim(XMLMAXATTE) based(ptrLabP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if inATT.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(inATT.pgmIndex));
         ptrLabP = cacScanBig(anyDC.pgmBigLab);
       endif;
       if ptrLabP = *NULL;
         ptrLabP = %addr(sLabCache);
       endif;

       for i = 1 to XMLMAXATTE;
         if anyLab(i) = *BLANKS;
           where = i;
           leave;
         elseif anyLab(i) = myLab;
           where = i;
           leave;
         endif;
       endfor;
       // cache label
       if where > 0;
         anyLab(where) = myLab;
       endif;
       return where;
      /end-free
     P                 E

      *****************************************************
      * xml cache clear dou/enddo  (XML node)
      *****************************************************
     P cacClrDou       B                   export
     D cacClrDou       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      /free
       ptrAttP = %addr(sXmlDOU);
       memset(ptrAttP:0:%size(anyATT:*ALL));
      /end-free
     P                 E

     P cacAddDou       B                   export
     D cacAddDou       PI             1N
     D   node                              likeds(xmlNode_t) 
      * vars
     D rcb             s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if node.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(node.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigDou);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlDOU);
       endif;

       for i = 1 to XMLMAXDOU;
         if anyATT(i).cacElemCnt = 0; 
           xmlCOPY(anyATT(i):node);
           anyATT(i).cacElemCnt = 1;
           rcb = *ON;
         elseif anyATT(i).cacDouEnd  = node.cacDouEnd;
           xmlCOPY(anyATT(i):node);
           anyATT(i).cacElemCnt = 1; // update mark also (1.9.2)
           rcb = *ON;
         endif;
         if rcb = *ON;
           leave;
         endif;
       endfor;
       return rcb;
      /end-free
     P                 E

     P cacPopDou       B                   export
     D cacPopDou       PI            10i 0
     D   node                              likeds(xmlNode_t) 
      * vars
     D i               s             10i 0 inz(0)
     D myOccurs        s             10i 0 inz(-1)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if node.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(node.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigDou);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlDOU);
       endif;

       for i = 1 to XMLMAXDOU;
         if anyATT(i).cacElemCnt = 0; 
           leave;
         elseif anyATT(i).cacDouEnd = node.cacDouDim;
           myOccurs = ilePopVal(anyATT(i));
           leave;
         endif;
       endfor;
       return myOccurs;
      /end-free
     P                 E


      *****************************************************
      * xml cache clear offset  (XML node)
      *****************************************************
     P cacClrOff       B                   export
     D cacClrOff       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      /free
       ptrAttP = %addr(sXmlOFFSET);
       memset(ptrAttP:0:%size(anyATT:*ALL));
      /end-free
     P                 E

     P cacAddOff       B                   export
     D cacAddOff       PI             1N
     D   node                              likeds(xmlNode_t) 
      * vars
     D rcb             s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if node.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(node.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigOff);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlOFFSET);
       endif;

       for i = 1 to XMLMAXDOU;
         if anyATT(i).cacElemCnt = 0; 
           xmlCOPY(anyATT(i):node);
           anyATT(i).cacElemCnt = 1;
           rcb = *ON;
         elseif anyATT(i).cacOffEnd = node.cacOffEnd;
           xmlCOPY(anyATT(i):node);
           anyATT(i).cacElemCnt = 1; // update mark also (1.9.2)
           rcb = *ON;
         endif;
         if rcb = *ON;
           leave;
         endif;
       endfor;
       return rcb;
      /end-free
     P                 E

     P cacPopOff       B                   export
     D cacPopOff       PI            10i 0
     D   node                              likeds(xmlNode_t) 
      * vars
     D i               s             10i 0 inz(0)
     D myOff           s             10i 0 inz(-1)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if node.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(node.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigOff);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlOFFSET);
       endif;

       for i = 1 to XMLMAXDOU;
         if anyATT(i).cacElemCnt = 0; 
           leave;
         elseif anyATT(i).cacOffEnd = node.cacOffOvr;
           myOff = ilePopVal(anyATT(i));
           leave;
         endif;
       endfor;
       return myOff;
      /end-free
     P                 E

      *****************************************************
      * xml cache clear offset  (XML node)
      *****************************************************
     P cacClrNxt       B                   export
     D cacClrNxt       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      /free
       ptrAttP = %addr(sXmlNXTOFF);
       memset(ptrAttP:0:%size(anyATT:*ALL));
      /end-free
     P                 E

     P cacAddNxt       B                   export
     D cacAddNxt       PI             1N
     D   node                              likeds(xmlNode_t) 
      * vars
     D rcb             s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if node.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(node.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigNxt);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlNXTOFF);
       endif;

       for i = 1 to XMLMAXDOU;
         if anyATT(i).cacElemCnt = 0; 
           xmlCOPY(anyATT(i):node);
           anyATT(i).cacElemCnt = 1;
           rcb = *ON;
         elseif anyATT(i).cacNxtOff = node.cacNxtOff;
           xmlCOPY(anyATT(i):node);
           anyATT(i).cacElemCnt = 1; // update mark also (1.9.2)
           rcb = *ON;
         endif;
         if rcb = *ON;
           leave;
         endif;
       endfor;
       return rcb;
      /end-free
     P                 E

     P cacPopNxt       B                   export
     D cacPopNxt       PI            10i 0
     D   node                              likeds(xmlNode_t) 
      * vars
     D i               s             10i 0 inz(0)
     D myOff           s             10i 0 inz(-1)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if node.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(node.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigNxt);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlNXTOFF);
       endif;

       for i = 1 to XMLMAXDOU;
         if anyATT(i).cacElemCnt = 0; 
           leave;
         elseif anyATT(i).cacNxtOff = node.cacNxtOvr;
           myOff = ilePopVal(anyATT(i));
           leave;
         endif;
       endfor;
       return myOff;
      /end-free
     P                 E

      *****************************************************
      * xml cache length DS  (XML node)
      *****************************************************
     P cacClrLen       B                   export
     D cacClrLen       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrAttP         s               *   inz(*NULL)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      /free
       ptrAttP = %addr(sXmlPUSH);
       memset(ptrAttP:0:%size(anyATT:*ALL));
      /end-free
     P                 E

     P cacAddLen       B                   export
     D cacAddLen       PI             1N
     D   type                        10I 0 value
     D   node                              likeds(xmlNode_t) 
      * vars
     D rcb             s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D ibeg            s             10i 0 inz(0)
     D iend            s             10i 0 inz(0)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if node.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(node.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigPush);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlPUSH);
       endif;

       for i = 1 to XMLMAXDOU;
         // found in cache?
         select;
         // len(*) setlen
         // occurs in first data element
         // cacLenBeg inherited from parent len=DS
         when type = CAC_LEN_BEG; // (beg offest)
           if anyATT(i).cacLenOne  = node.cacLenBeg
           or anyATT(i).cacElemCnt = 0;
             anyATT(i).cacLenOne   = node.cacLenBeg;
             anyATT(i).cacLenOff1  = node.cacTruLen;
             anyATT(i).cacElemCnt  = 1;
             rcb = *ON;
           endif;
         // len setlen(*)
         // occurs only in data element
         // but may appear in front of len=DS
         when type = CAC_LEN_SET;
           if anyATT(i).cacLenOne  = node.cacLenSet
           or anyATT(i).cacElemCnt = 0;
             ibeg = anyATT(i).cacLenOff1;
             iend = anyATT(i).cacLenOff2;
             xmlCOPY(anyATT(i):node);
             anyATT(i).cacLenOne  = node.cacLenSet;
             anyATT(i).cacLenOff1 = ibeg;
             anyATT(i).cacLenOff2 = iend;
             anyATT(i).cacElemCnt = 1;
             rcb = *ON;
           endif;
         // last offset
         // occurs only end of DS structure
         when type = CAC_LEN_END; // (end offset)
           if anyATT(i).cacLenOne = node.cacLenBeg;
             anyATT(i).cacLenOff2 = node.cacTruLen;
             rcb = *ON;
           endif;
         // other?
         other;
         endsl;
         if rcb = *ON;
           leave;
         endif;
       endfor;
       return rcb;
      /end-free
     P                 E

     P cacPushLen      B                   export
     D cacPushLen      PI             1N
     D   node                              likeds(xmlNode_t) 
      * vars
     D rc              s              1N   inz(*ON)
     D i               s             10i 0 inz(0)
     D ibeg            s             10i 0 inz(0)
     D iend            s             10i 0 inz(0)
     D myLen           s             10i 0 inz(-1)
     D anyATT          ds                  likeds(xmlNode_t)
     D                                     dim(XMLMAXDOU) based(ptrAttP)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     based(ptrDcP)
      /free
       // cache attributes
       if node.pgmIndex > 0;
         ptrDcP = %addr(sPgmCache(node.pgmIndex));
         ptrAttP = cacScanBig(anyDC.pgmBigPush);
       endif;
       if ptrAttP = *NULL;
         ptrAttP = %addr(sXmlPUSH);
       endif;

       for i = 1 to XMLMAXDOU;
         if anyATT(i).cacElemCnt <> 0;
           ibeg = anyATT(i).cacLenOff1;
           iend = anyATT(i).cacLenOff2;
           myLen = iend - ibeg;
           if myLen > 0;
             anyATT(i).xmlStrSz = myLen;
           else;
             anyATT(i).xmlStrSz = 0;
           endif;
           rc = ilePushLen(anyATT(i));
         else;
           leave;
         endif;
       endfor;
       return rc;
      /end-free
     P                 E

      *****************************************************
      * pgm overlay markers
      *****************************************************
     P cacClrOvr       B                   export
     D cacClrOvr       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrOvrP         s               *   inz(*NULL)
     D anyOvr          ds                  likeds(ovrRec_t)
     D                                     dim(ILEMAXOVR) based(ptrOvrP)
      /free
       ptrOvrP = %addr(sOvrCache);
       memset(ptrOvrP:0:%size(anyOvr:*ALL));
      /end-free
     P                 E

     P cacScanOvr      B                   export
     D cacScanOvr      PI
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
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrOvrP         s               *   inz(*NULL)
     D anyOvr          ds                  likeds(ovrRec_t)
     D                                     dim(ILEMAXOVR) based(ptrOvrP)
      /free
       ptrOvrP = %addr(sOvrCache);

       // special locations
       select;
         when type = CAC_OVR_TOP;
           where = ILEMAXOVR - 1;
         when type = CAC_OVR_START;
           where = ILEMAXOVR - 2;
         when type = CAC_OVR_END;
           where = ILEMAXOVR - 3;
       other;
         where = type;
       endsl;

       // bump where used counter
       anyOvr(where).ovrtype = type;
       if anyOvr(where).ovrcnt < XMLMAXCNT;
         anyOvr(where).ovrcnt += 1;
       endif;
       mArgvP    = mOrigP + anyOvr(where).ovrargvOff + offset;
       mArgvSz   = anyOvr(where).ovrargvSz + offset;
       mParmP    = mOrigP + anyOvr(where).ovrparmOff + offset;
       mParmSz   = anyOvr(where).ovrparmSz + offset;
       if anyOvr(where).ovrretOff > 0;
         mRetP     = mOrigP + anyOvr(where).ovrretOff;
         mRetSz    = anyOvr(where).ovrretSz + offset;
       endif;
       mSigP     = mOrigP + anyOvr(where).ovrsigOff;
       mSigSz    = anyOvr(where).ovrsigSz;

      /end-free
     P                 E

     P cacAddOvr       B                   export
     D cacAddOvr       PI
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
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrOvrP         s               *   inz(*NULL)
     D anyOvr          ds                  likeds(ovrRec_t)
     D                                     dim(ILEMAXOVR) based(ptrOvrP)
      /free
       ptrOvrP = %addr(sOvrCache);

       // special locations
       select;
         when type = CAC_OVR_TOP;
           where = ILEMAXOVR - 1;
         when type = CAC_OVR_START;
           where = ILEMAXOVR - 2;
         when type = CAC_OVR_END;
           where = ILEMAXOVR - 3;
       other;
         where = type;
       endsl;

       // cache attributes
       anyOvr(where).ovrargvOff  = mArgvP - mOrigP;
       anyOvr(where).ovrargvSz   = mArgvSz;
       anyOvr(where).ovrparmOff  = mParmP - mOrigP;
       anyOvr(where).ovrparmSz   = mParmSz;
       if mRetP <> *NULL;
         anyOvr(where).ovrretOff   = mRetP - mOrigP;
         anyOvr(where).ovrretSz    = mRetSz;
       else;
         anyOvr(where).ovrretOff   = 0;
         anyOvr(where).ovrretSz    = 0;
       endif;
       anyOvr(where).ovrsigOff   = mSigP - mOrigP;
       anyOvr(where).ovrsigSz    = mSigSz;

      /end-free
     P                 E


      *****************************************************
      * level 2 -- load, heap cache
      *****************************************************


      *****************************************************
      * big memory tracker
      *****************************************************
     P cacClrBig       B                   export
     D cacClrBig       PI
     D  index                        10i 0 value options(*nopass)
     D  ctype                         1A   value options(*nopass)
      * vars
     D i               S             10I 0 inz(0)
     D doClr           S              1N   inz(*OFF)
     D btype           S              1A   inz(*BLANKS)
     D ptrAnyP         s               *   inz(*NULL)
     D ptrBigP         s               *   inz(*NULL)
     D anyBIG          ds                  likeds(bigscan_t)
     D                                     dim(SZBIGSCAN) based(ptrBigP)
     D oneBIG          ds                  likeds(bigscan_t)
      /free

       ptrBigP = %addr(sBigScan);

       // @ADC 1.7.1 -- hazards templates (no auto-init)
       // 1077952576 == x'40404040' -- never initialized
       if anyBIG(1).biguse = 1077952576
       and anyBIG(1).bigcnt = 1077952576
       and anyBIG(1).bigsize = 1077952576;
         memset(ptrBigP:0:%size(anyBIG:*ALL));
         return;
       endif;
      
       // index passed
       if %parms >= 1;
         i = index;
         // index passed
         if i < 1 or i > SZBIGSCAN;
           return;
         endif;
         // special type
         if %parms >=2;
           // do not remove heap
           if ctype = CAC_HEAP_ILE_REUSE;
             anyBIG(i).biguse = 0;
             return;
           endif;
         endif;
         // PASE heap on its own management
         // all other heap subject to dealloc
         btype = anyBIG(i).bigtype;
         if btype <> CAC_HEAP_PGM_PASE;
           ptrAnyP = anyBIG(i).bigaddr;
         endif;
         if ptrAnyP <> *NULL;
           Monitor;
             dealloc(en) ptrAnyP;
           On-error;
           Endmon;
         endif;
         ptrAnyP = *NULL;
         // clear one
         memset(%addr(anyBIG(i)):0:%size(oneBIG));
       // no index passed
       else;
         // delete all alloc memory
         if sBigInit = *ON;
          for i = 1 to SZBIGSCAN;
           btype = anyBIG(i).bigtype;
           if anyBIG(i).bigcnt > 0;
             // PASE heap on its own management
             // all other heap subject to dealloc
             if btype <> CAC_HEAP_PGM_PASE;
               ptrAnyP = anyBIG(i).bigaddr;
             endif;
             if ptrAnyP <> *NULL;
               Monitor;
                 dealloc(en) ptrAnyP;
               On-error;
               Endmon;
             endif;
             ptrAnyP = *NULL;
           endif;
          endfor;
         else;
           sBigInit = *ON;
         endif;
         // clear all
         memset(ptrBigP:0:%size(anyBIG:*ALL));
         doClr = *ON;
       endif;
       // special redirects
       if doClr = *ON or btype = CAC_HEAP_PGM_OPM;
         sBigCtlOPM.paseOrig   = 0;
         sBigCtlOPM.paseResv   = *BLANKS;
         sBigCtlOPM.paseOrigP  = *NULL;
         sBigCtlOPM.paseCallP  = *NULL;
         sBigCtlOPM.paseSigP   = *NULL;
         sBigCtlOPM.paseArgvP  = *NULL;
       endif;
       // normal remove PASE heap
       if doClr = *ON or btype = CAC_HEAP_PGM_PASE;
         sBigCtlPASE.paseOrig  = 0;
         sBigCtlPASE.paseResv  = *BLANKS;
         sBigCtlPASE.paseOrigP = *NULL;
         sBigCtlPASE.paseCallP = *NULL;
         sBigCtlPASE.paseSigP  = *NULL;
         sBigCtlPASE.paseArgvP = *NULL;
       endif;
      /end-free
     P                 E

     P cacScanBig      B                   export
     D cacScanBig      PI              *
     D  index                        10i 0 value
     D  size                         10i 0 options(*nopass)
     D  useSz                        10i 0 options(*nopass)
      * vars
     D where           s               *   inz(*NULL)
     D i               s             10i 0 inz(0)
     D ptrBigP         s               *   inz(*NULL)
     D anyBIG          ds                  likeds(bigscan_t)
     D                                     dim(SZBIGSCAN) based(ptrBigP)
      /free
       if %parms >= 2;
         size = 0;
       endif;
       // not exist
       if index < 1 or index > SZBIGSCAN;
         return where;
       endif;
       // valid index 
       ptrBigP = %addr(sBigScan);
       // valid count
       if anyBIG(index).bigcnt < 1;
         return where;
       endif;
       // valid address
       where = anyBIG(index).bigaddr;
       if where <> *NULL;
         if %parms >= 2;
           size = anyBIG(index).bigsize;
         endif;
         if anyBIG(index).bigcnt < XMLMAXCNT;
           anyBIG(index).bigcnt += 1;
         endif;
         // special redirects
         if anyBIG(index).bigtype = CAC_HEAP_PGM_OPM;
           return %addr(sBigCtlOPM); // heap redirect here
         elseif anyBIG(index).bigtype = CAC_HEAP_PGM_PASE;
           return %addr(sBigCtlPASE); // heap redirect here
         endif;
       endif;
       // normal heap find
       return where;
      /end-free
     P                 E

     P cacAddBig       B                   export
     D cacAddBig       PI            10i 0
     D  bsize                        10i 0 value
     D  btype                         1A   value
      * vars
     D rc              s              1N   inz(*OFF)
     D where           s             10i 0 inz(0)
     D fit             s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D maxSz           s             10i 0 inz(0)
     D ptrAnyP         s               *   inz(*NULL)
     D ptrBigP         s               *   inz(*NULL)
     D anyBIG          ds                  likeds(bigscan_t)
     D                                     dim(SZBIGSCAN) based(ptrBigP)
      /free
       ptrBigP = %addr(sBigScan);

       // heap selection
       select;
         when btype = CAC_HEAP_ILE_TMP;
           where = SBIGXMLTMP;
         when btype = CAC_HEAP_ILE_IPC;
           where = SBIGXMLIPC;
         when btype = CAC_HEAP_PGM_OPM;
           where = SBIGPGMOPM;
         when btype = CAC_HEAP_PGM_PASE;
           where = SBIGPGMPASE;
           rc = PaseStart32(bsize:sBigCtlPASE);
           ptrAnyP = sBigCtlPASE.paseOrigP;
           if ptrAnyP <> *NULL;
             anyBIG(where).bigcnt  = 1;
             anyBIG(where).bigsize = bsize;
             anyBIG(where).biguse  = bsize;
             anyBIG(where).bigtype = btype;
             anyBIG(where).bigaddr = ptrAnyP;
           endif;
         when btype = CAC_HEAP_ILE_REUSE;
           // try find close fit
           for i = 1 to SZBIGLAST;
             if anyBIG(i).bigtype = CAC_HEAP_ILE_REUSE
             and anyBIG(i).biguse = 0
             and anyBIG(i).bigsize >= bsize;
               // found one spot
               if where = 0;
                 where = i;
                 fit = where;
                 maxSz = anyBIG(i).bigsize;
               // found a smaller spot
               elseif anyBIG(i).bigsize < maxSz;
                 where = i;
                 fit = where;
                 maxSz = anyBIG(i).bigsize;
               endif;
             endif;
           endfor;
           // find one, but just way too big???
           if where > 0 and maxSz > 256 and maxSz > bsize * 2;
              where = 0;
           endif;
           // try find any
           if where = 0;
             for i = 1 to SZBIGLAST;
               if anyBIG(i).bigcnt = 0;
                 where = i;
                 leave;
               endif;
             endfor;
           endif;
           // last resort, maybe too big ok???
           if where = 0 and fit > 0;
             where = fit;
           endif;
       // ???? 
       other;
       endsl;

       // nowhere to go
       if where < 1;
         return 0;
       endif;

       // PASE heap on its own management
       // all other heap subject to alloc
       if btype <> CAC_HEAP_PGM_PASE;
         // memory reused
         if anyBIG(where).bigcnt > 0;
           ptrAnyP = anyBIG(where).bigaddr;
         endif;
         // memory too small dealloc
         if anyBIG(where).bigsize > 0 
         and anyBIG(where).bigsize < bsize;
           cacClrBig(where);
           ptrAnyP = *NULL;
         endif;
         // no memory yet
         if ptrAnyP = *NULL;
           Monitor;
             ptrAnyP = %alloc(bsize);
           On-error;
             ptrAnyP = *NULL;
           Endmon;
         endif;
         // alloc good
         if ptrAnyP <> *NULL;
           anyBIG(where).biguse  = bsize;
           anyBIG(where).bigtype = btype;
           anyBIG(where).bigaddr = ptrAnyP;
           if anyBIG(where).bigsize < bsize;
             anyBIG(where).bigcnt  = 0;
             anyBIG(where).bigsize = bsize;
           endif;
           if anyBIG(where).bigcnt < XMLMAXCNT;
             anyBIG(where).bigcnt += 1;
           endif;
           // ipcCtl DS record
           if btype = CAC_HEAP_PGM_OPM;
             // first time allocation OPM
             if sBigCtlOPM.paseOrigP = *NULL
             or sBigCtlOPM.paseOrigP <> ptrAnyP;
               sBigCtlOPM.paseOrig   = 536870912; // 0x20000000 - quad aligned
               sBigCtlOPM.paseResv   = *BLANKS;
               sBigCtlOPM.paseOrigP  = ptrAnyP;   // actual heap here
               sBigCtlOPM.paseCallP  = ptrAnyP;
               sBigCtlOPM.paseSigP   = ptrAnyP;   // sigs (if OPM that smart)
               sBigCtlOPM.paseArgvP  = ptrAnyP + SZSIG;
               memset(ptrAnyP:0:anyBIG(where).bigsize);
             endif;
           // clear memory each time
           else;
             memset(ptrAnyP:0:anyBIG(where).bigsize);
           endif;
         endif;
       endif;

       // failed
       if ptrAnyP = *NULL;
         where = 0;
       endif;

       return where;
      /end-free
     P                 E

      *****************************************************
      * xml batch buffers
      *****************************************************
     P cacClrBat       B                   export
     D cacClrBat       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrBatP         s               *   inz(*NULL)
     D anyBat          ds                  likeds(bat_t)
     D                                     dim(IPCBATMAX) based(ptrBatP)
      /free
       ptrBatP = %addr(sBat);
       memset(ptrBatP:0:%size(anyBat:*ALL));
      /end-free
     P                 E

     P cacScanBat      B                   export
     D cacScanBat      PI            10i 0
     D   batType                      1A   value
     D   batIPtr                       *
     D   batIsz                      10i 0
     D   batOPtr                       *
     D   batOsz                      10i 0
     D   index                       10i 0 value options(*nopass)
      * vars
     D where           S             10I 0 inz(0)
     D i               S             10I 0 inz(0)
     D j               S             10I 0 inz(1)
     D k               S             10I 0 inz(IPCBATMAX)
     D maxBytes        S             10I 0 inz(0)
     D tmpSz           S             10I 0 inz(0)
     D useSz           S             10i 0 inz(0)
     D ptrTmpP         s               *   inz(*NULL)
     D ptrBatP         s               *   inz(*NULL)
     D anyBat          ds                  likeds(bat_t)
     D                                     dim(IPCBATMAX) based(ptrBatP)
      /free
       ptrBatP = %addr(sBat);

       if %parms >= 6;
         j = index;
         k = index;
       endif;
       if j < 1 or k < 1 
       or j > IPCBATMAX or k > IPCBATMAX;
         return where;
       endif;

       for i = j to k;
         select;
         when batType = CAC_BAT_ADD_INPUT;
           if anyBat(i).batType = CAC_BAT_ADD_INPUT;
             maxBytes = bigTrim(batIPtr:batIsz);
             tmpSz = maxBytes + 16 + batOsz;
             anyBat(i).batbig = cacAddBig(tmpSz:CAC_HEAP_ILE_REUSE);
             ptrTmpP = cacScanBig(anyBat(i).batbig);
             if ptrTmpP <> *NULL;
               cpybytes(ptrTmpP:batIPtr:maxBytes);
               anyBat(i).batType = CAC_BAT_XML_GO;
               anyBat(i).batIsz = maxBytes;
               anyBat(i).batOsz = batOsz;
               where = i;
             endif;
          endif;
         when batType = CAC_BAT_XML_GO;
           if anyBat(i).batType = CAC_BAT_XML_GO;
             ptrTmpP = cacScanBig(anyBat(i).batbig);
             if ptrTmpP <> *NULL;
               anyBat(i).batType = CAC_BAT_XML_RUN;
               where = i;
             endif;
          endif;
         when batType = CAC_BAT_XML_RUN;
           if anyBat(i).batType = CAC_BAT_XML_RUN;
             ptrTmpP = cacScanBig(anyBat(i).batbig);
             if ptrTmpP <> *NULL;
               anyBat(i).batType = CAC_BAT_XML_RUN;
               where = i;
             endif;
          endif;
         when batType = CAC_BAT_XML_SIZE;
           if anyBat(i).batType = CAC_BAT_XML_RUN
           or anyBat(i).batType = CAC_BAT_GET_WRITE;
             ptrTmpP = cacScanBig(anyBat(i).batbig);
             if ptrTmpP <> *NULL;
               anyBat(i).batType = CAC_BAT_XML_SIZE;
               anyBat(i).batOsz = batOsz;
               where = i;
             endif;
          endif;
         when batType = CAC_BAT_GET_OUTPUT;
           if anyBat(i).batType = CAC_BAT_XML_SIZE;
             ptrTmpP = cacScanBig(anyBat(i).batbig:tmpSz:useSz);
             if ptrTmpP <> *NULL;
               anyBat(i).batType = CAC_BAT_GET_WRITE;
               where = i;
             endif;
           endif;
         when batType = CAC_BAT_GET_AGAIN;
           if anyBat(i).batType = CAC_BAT_GET_WRITE;
             ptrTmpP = cacScanBig(anyBat(i).batbig);
             if ptrTmpP <> *NULL;
               anyBat(i).batType = CAC_BAT_XML_SIZE;
               where = i;
             endif;
          endif;
         when batType = CAC_BAT_GET_WRITE;
           if anyBat(i).batType = CAC_BAT_GET_WRITE;
             ptrTmpP = cacScanBig(anyBat(i).batbig:tmpSz:useSz);
             if ptrTmpP <> *NULL;
               ptrTmpP += anyBat(i).batIsz + 16;
               cpybytes(batOPtr:ptrTmpP:anyBat(i).batOsz);
               anyBat(i).batType = CAC_BAT_ADD_INPUT;
               cacClrBig(anyBat(i).batbig:CAC_HEAP_ILE_REUSE);
               where = i;
             endif;
           endif;
         // ???? 
         other;
         endsl;
         // action taken
         if where > 0;
           leave;
         endif;
       endfor;

       if where > 0;
         batIPtr = ptrTmpP;
         batIsz  = anyBat(where).batIsz;
         batOPtr = batIPtr + anyBat(where).batIsz + 16;
         batOsz  = anyBat(where).batOsz;
       endif;

       return where;
      /end-free
     P                 E

      *****************************************************
      * ILE parms attribute string-2-nbr type caching (ILE pgm)
      *****************************************************
     P cacClrTyp       B                   export
     D cacClrTyp       PI
      * vars
     D i               s             10i 0 inz(0)
     D ptrTypP         s               *   inz(*NULL)
     D anyTYP          ds                  likeds(typeIV_t)
     D                                     dim(XMLMAXTYPE) based(ptrTypP)
      /free
       ptrTypP = %addr(sInTYP);
       memset(ptrTypP:0:%size(anyTYP:*ALL));
      /end-free
     P                 E

     P cacScanTyp      B                   export
     D cacScanTyp      PI             1N
     D   type                        16A   value
     D   myAttr                       1A
     D   myDigits                    10i 0
     D   myFrac                      10i 0
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrTypP         s               *   inz(*NULL)
     D anyTYP          ds                  likeds(typeIV_t)
     D                                     dim(XMLMAXTYPE) based(ptrTypP)
      /free
       ptrTypP = %addr(sInTYP);

       // scan the cache ...
       for i = 1 to XMLMAXTYPE;
         // found in cache?
         select;
         when anyTYP(i).typecnt = 0;
           leave;
         when anyTYP(i).typestr = type;
           where = i;
           leave;
         // other?
         other;
         endsl;
       endfor;

       // bump where used counter
       if where > 0;
         if anyTYP(where).typecnt < XMLMAXCNT;
           anyTYP(where).typecnt += 1;
         endif;
         myDigits = anyTYP(where).typedigits;
         myFrac   = anyTYP(where).typefrac;
         myAttr   = anyTYP(where).typeattr;
         return *ON;
       endif;

       return *OFF;
      /end-free
     P                 E

     P cacAddTyp       B                   export
     D cacAddTyp       PI
     D   type                        16A   value
     D   myAttr                       1A
     D   myDigits                    10i 0
     D   myFrac                      10i 0
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D ptrTypP         s               *   inz(*NULL)
     D anyTYP          ds                  likeds(typeIV_t)
     D                                     dim(XMLMAXTYPE) based(ptrTypP)
      /free
       ptrTypP = %addr(sInTYP);

       // save for fast way ...
       where = 0;
       for i = 1 to XMLMAXTYPE;
         // empty cache slot
         if anyTYP(i).typecnt = 0;
           where = i;
           leave;
         endif;
       endfor;
       // restart counts
       // reuse slot
       if where = 0;
         where = cacRandom(XMLMAXTYPE);
       endif;

       // cache attributes
       anyTYP(where).typecnt    = 1;
       anyTYP(where).typedigits = myDigits;
       anyTYP(where).typefrac   = myFrac;
       anyTYP(where).typeattr   = myAttr;
       anyTYP(where).typestr    = type;

      /end-free
     P                 E


      *****************************************************
      * ILE parms cache F64 converts (ILE pgm)
      *****************************************************
     P cacClrF64       B                   export
     D cacClrF64       PI
     D   isOut                        1N   value
      * vars
     D i               s             10i 0 inz(0)
     D ptrF64P         s               *   inz(*NULL)
     D anyF64          ds                  likeds(ilef64_t)
     D                                     dim(ILEMAXF64) based(ptrF64P)
      /free
       if isOut = *OFF;
         ptrF64P = %addr(sInF64);
         memset(ptrF64P:0:%size(anyF64:*ALL));
       else;
         ptrF64P = %addr(sOutF64);
         memset(ptrF64P:0:%size(anyF64:*ALL));
       endif;
      /end-free
     P                 E

     P cacScanF64      B                   export
     D cacScanF64      PI             1N
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
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D tmpSz           s             10i 0 inz(0)
     D tmpP            s               *   inz(*NULL)
     D ptrF64P         s               *   inz(*NULL)
     D anyF64          ds                  likeds(ilef64_t)
     D                                     dim(ILEMAXF64) based(ptrF64P)
      /free
       if isOut = *OFF;
         ptrF64P = %addr(sInF64);
       else;
         ptrF64P = %addr(sOutF64);
       endif;
       // scan the cache ...
       for i = 1 to ILEMAXF64;
         // found in cache?
         select;
         when anyF64(i).ilefcnt = 0;
           leave;
         when type = CAC_F64_SCAN_STR_SAME;
           if  anyF64(i).ilefattr   = xmlAttr
           and anyF64(i).ilefdecz   = pgmValSz
           and anyF64(i).ilefdigits = xmlDigits
           and anyF64(i).ilefrac    = xmlFrac
           and anyF64(i).ilefstrz   = xmlStrSz;
             tmpP = %addr(anyF64(i).ilefstr);
             tmpSz = memcmp(tmpP:xmlStrP:xmlStrSz);
             if tmpSz = 0;
               where = i;
               leave;
             endif;
           endif;
         when type = CAC_F64_SCAN_DOUBLE_SAME;
           if  anyF64(i).ilefrac    = xmlFrac
           and anyF64(i).ilef64     = f64;
             where = i;
             leave;
           endif;
         when type = CAC_F64_SCAN_DECIMAL_SAME;
           if  anyF64(i).ilefattr   = xmlAttr
           and anyF64(i).ilefdecz   = pgmValSz
           and anyF64(i).ilefdigits = xmlDigits
           and anyF64(i).ilefrac    = xmlFrac;
             tmpP = %addr(anyF64(i).ilefdec);
             tmpSz = memcmp(tmpP:valPtrP:anyF64(i).ilefdecz);
             if tmpSz = 0;
               where = i;
               leave;
             endif;
           endif;
         // other?
         other;
           leave;
         endsl;
       endfor;

       // bump where used counter
       if where > 0;
         if anyF64(where).ilefcnt < XMLMAXCNT;
           anyF64(where).ilefcnt += 1;
         endif;
         // return output
         f64   = sInF64(where).ilef64;
         ptrP  = %addr(sInF64(where).ilefdec);
         sz    = sInF64(where).ilefdecz;
         strP  = %addr(anyF64(where).ilefstr);
         strSz = anyF64(where).ilefstrz;
         return *ON;
       endif;

       return *OFF;
      /end-free
     P                 E

     P cacAddF64       B                   export
     D cacAddF64       PI
     D   isOut                        1N   value
     D   valPtrP                       *   value
     D   f64                          8f   value
     D   xmlStrP                       *   value
     D   xmlStrSz                    10i 0 value
     D   xmlAttr                      1A   value
     D   xmlDigits                   10i 0 value
     D   xmlFrac                     10i 0 value
     D   pgmValSz                    10i 0 value
      * vars
     D where           s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D tmpP            s               *   inz(*NULL)
     D ptrF64P         s               *   inz(*NULL)
     D anyF64          ds                  likeds(ilef64_t)
     D                                     dim(ILEMAXF64) based(ptrF64P)
      /free
       if isOut = *OFF;
         ptrF64P = %addr(sInF64);
       else;
         ptrF64P = %addr(sOutF64);
       endif;
       // save for fast way ...
       where = 0;
       for i = 1 to ILEMAXF64;
         // empty cache slot
         if anyF64(i).ilefcnt = 0;
           where = i;
           leave;
         endif;
       endfor;
       // restart counts
       // reuse slot
       if where = 0;
         where = cacRandom(ILEMAXF64);
       endif;

       // cache attributes
       anyF64(where).ilefcnt    = 1;
       anyF64(where).ilefstrz   = xmlStrSz;
       anyF64(where).ilefdigits = xmlDigits;
       anyF64(where).ilefrac    = xmlFrac;
       anyF64(where).ilef64     = f64;
       anyF64(where).ilefdecz   = pgmValSz;
       anyF64(where).ilefattr   = xmlAttr;

       // cache string representation
       anyF64(where).ilefstr = %str(xmlStrP:xmlStrSz);

       // cache actual value
       tmpP = %addr(anyF64(where).ilefdec);
       cpybytes(tmpP:valPtrP:pgmValSz);

      /end-free
     P                 E


      *****************************************************
      * pase call pgm cache (ILE pgm)
      *****************************************************
     P cacClrPgm       B                   export
     D cacClrPgm       PI
     D  index                        10i 0 options(*nopass)
      * vars
     D i               S             10I 0 inz(0)
     D j               S             10I 0 inz(1)
     D k               S             10I 0 inz(CACHEMAX)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     dim(CACHEMAX) based(ptrDcP)
      /free
       ptrDcP = %addr(sPgmCache);

       // @ADC 1.7.1 -- hazards templates (no auto-init)
       // 1077952576 == x'40404040' -- never initialized
       if anyDC(1).pgmUseCnt = 1077952576
       and anyDC(1).pgmBigAtt = 1077952576
       and anyDC(1).pgmActMark = 1077952576;
         memset(ptrDcP:0:%size(anyDC:*ALL));
       endif;

       if %parms >= 1;
         j = index;
         k = index;
       else;
         memset(ptrDcP:0:%size(anyDC:*ALL));
         return;
       endif;
       if j < 1 or k < 1 
       or j > CACHEMAX or k > CACHEMAX;
         return;
       endif; 

       for i=j to k;

         if anyDC(i).pgmBigAtt > 0;
           cacClrBig(anyDC(i).pgmBigAtt);
         endif;
         anyDC(i).pgmBigAtt   = 0;

         if anyDC(i).pgmBigDou > 0;
           cacClrBig(anyDC(i).pgmBigDou);
         endif;
         anyDC(i).pgmBigDou   = 0;

         if anyDC(i).pgmBigOff > 0;
           cacClrBig(anyDC(i).pgmBigOff);
         endif;
         anyDC(i).pgmBigOff   = 0;

         if anyDC(i).pgmBigPush > 0;
           cacClrBig(anyDC(i).pgmBigPush);
         endif;
         anyDC(i).pgmBigPush   = 0;

         if anyDC(i).pgmBigLab > 0;
           cacClrBig(anyDC(i).pgmBigLab);
         endif;
         anyDC(i).pgmBigLab   = 0;

         anyDC(i).pgmIlePtr   = *NULL;
         anyDC(i).pgmIleProc  = *NULL;

         anyDC(i).pgmObjName  = *BLANKS;
         anyDC(i).pgmLibName  = *BLANKS;
         anyDC(i).pgmSymName  = *BLANKS;
         anyDC(i).pgmLabel    = *BLANKS;

         anyDC(i).pgmActMark  = 0;
         anyDC(i).pgmUseCnt   = 0;

         anyDC(i).pgmRecType  = 0;

       endfor;
      /end-free
     P                 E

     P cacScanPgm      B                   export
     D cacScanPgm      PI             1N
     D  type                         10i 0 value
     D  pgm1                         10A   value
     D  lib1                         10A   value
     D  sym1                        128A   value
     D  pILESym                        *
     D  actmark                      10I 0
     D  inATT                              likeds(xmlNode_t) options(*nopass)
      * vars
     D i               S             10I 0 inz(0)
     D where           S             10I 0 inz(0)
     D pos1            S             10I 0 inz(0)
     D pos2            S             10I 0 inz(0)
     D search          S             20A   inz(*BLANKS)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     dim(CACHEMAX) based(ptrDcP)
      * fast pgm
     D pgmPRE          S               *   inz(*NULL)
     D deadPtr         S               *   Procptr inz(*NULL)
     D AnyDS           ds                  qualified based(Template)
     D   AnyPtr                        *   Procptr
     D myPtr           s               *   inz(*NULL)
     D myDS            ds                  likeds(AnyDS) based(myPtr)
      /free
       ptrDcP = %addr(sPgmCache);
       myPtr  = %addr(pILESym);

       // found in cache?
       for i=1 to CACHEMAX;
         select;
         when type = CAC_QP2_RSLOBJ2;
           if anyDC(i).pgmObjName = pgm1
           and anyDC(i).pgmLibName = lib1;
             where = i;
             leave;
           endif;
         when type = CAC_QP2_ILESYM
           or type = CAC_QP2_ILELOAD;
           if anyDC(i).pgmObjName = pgm1
           and anyDC(i).pgmLibName = lib1
           and anyDC(i).pgmSymName = sym1;
             where = i;
             leave;
           endif;
         other;
         endsl;
         // empty cache slot
         if anyDC(i).pgmUseCnt = 0;
           leave;
         endif;
       endfor;
       // found
       if where > 0;
         if anyDC(where).pgmUseCnt < XMLMAXCNT;
           anyDC(where).pgmUseCnt += 1;
         endif;
         // data
         actmark = anyDC(where).pgmActMark;
         if type = CAC_QP2_ILESYM;
           pILESym = anyDC(where).pgmIleProc;
         else;
           pILESym = anyDC(where).pgmIlePtr;
         endif;
         select;
         when type = CAC_QP2_RSLOBJ2
         or   type = CAC_QP2_ILELOAD
         or   type = CAC_QP2_ILESYM;
           if myDS.AnyPtr <> deadPtr;
             return *ON;
           endif;
         other;
           return *ON;
         endsl;
       endif;
       return *OFF;
      /end-free
     P                 E

     P cacAddPgm       B                   export
     D cacAddPgm       PI
     D  type                         10I 0 value
     D  pgm1                         10A   value
     D  lib1                         10A   value
     D  sym1                        128A   value
     D  pILESym                        *
     D  act                          10I 0 value
     D  label                        30A   value options(*nopass)
     D  inATT                              likeds(xmlNode_t) options(*nopass)
      * vars
     D rc              s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D where           s             10i 0 inz(0)
     D pos1            S             10I 0 inz(0)
     D pos2            S             10I 0 inz(0)
     D search          S             20A   inz(*BLANKS)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(pgmRec_t)
     D                                     dim(CACHEMAX) based(ptrDcP)
      * fast pgm
     D pgmPRE          S               *   inz(*NULL)
     D pgmSz           S             10i 0 inz(0)
     D attSz           S             10i 0 inz(0)
      /free
       ptrDcP = %addr(sPgmCache);

       // save for fast way ...
       where = 0;
       for i = 1 to CACHEMAX;
         select;
         when type = CAC_QP2_RSLOBJ2
         and anyDC(i).pgmRecType <> CAC_QP2_PREPARE;
           if anyDC(i).pgmObjName = pgm1
           and anyDC(i).pgmLibName = lib1;
             where = i;
             leave;
           endif;
         when type = CAC_QP2_ILESYM
           or type = CAC_QP2_ILELOAD;
           if anyDC(i).pgmObjName = pgm1
           and anyDC(i).pgmLibName = lib1
           and anyDC(i).pgmSymName = sym1;
             where = i;
             leave;
           endif;
          when type = CAC_QP2_PREPARE;
           if anyDC(i).pgmObjName = pgm1
           and anyDC(i).pgmLibName = lib1
           and anyDC(i).pgmSymName = sym1
           and anyDC(i).pgmLabel = label;
             where = i;
             leave;
           endif;
         other;
         endsl;
         // empty cache slot
         if anyDC(i).pgmUseCnt = 0;
           where = i;
           leave;
         endif;
       endfor;
       // restart counts
       // reuse slot
       if where = 0;
         where = cacRandom(CACHEMAX);
         cacClrPgm(where);
       endif;
       // cache attributes
       anyDC(where).pgmObjName = pgm1;
       anyDC(where).pgmLibName = lib1;
       anyDC(where).pgmSymName = sym1;
       if anyDC(where).pgmUseCnt < XMLMAXCNT;
         anyDC(where).pgmUseCnt += 1;
       endif;
       if type = CAC_QP2_ILESYM;
         anyDC(where).pgmIleProc  = pILESym;
       else;
         anyDC(where).pgmIlePtr  = pILESym;
       endif;
       anyDC(where).pgmActMark = act;
       // new attribute hole
       if type = CAC_QP2_PREPARE;
         if anyDC(where).pgmBigAtt <= 0;
           attSz = %size(sXmlATT:*ALL);
           anyDC(where).pgmBigAtt = cacAddBig(attSz:CAC_HEAP_ILE_REUSE);
         endif;
         if anyDC(where).pgmBigDou <= 0;
           attSz = %size(sXmlDOU:*ALL);
           anyDC(where).pgmBigDou = cacAddBig(attSz:CAC_HEAP_ILE_REUSE);
         endif;
         if anyDC(where).pgmBigOff <= 0;
           attSz = %size(sXmlOFFSET:*ALL);
           anyDC(where).pgmBigOff = cacAddBig(attSz:CAC_HEAP_ILE_REUSE);
         endif;
         if anyDC(where).pgmBigNxt <= 0;
           attSz = %size(sXmlNXTOFF:*ALL);
           anyDC(where).pgmBigNxt = cacAddBig(attSz:CAC_HEAP_ILE_REUSE);
         endif;
         if anyDC(where).pgmBigPush <= 0;
           attSz = %size(sXmlPUSH:*ALL);
           anyDC(where).pgmBigPush = cacAddBig(attSz:CAC_HEAP_ILE_REUSE);
         endif;
         if anyDC(where).pgmBigLab <= 0;
           attSz = %size(sLabCache:*ALL);
           anyDC(where).pgmBigLab = cacAddBig(attSz:CAC_HEAP_ILE_REUSE);
         endif;
         anyDC(where).pgmRecType = type;
         anyDC(where).pgmLabel = label;
         inATT.pgmIndex = where;
       endif;
      /end-free
     P                 E

      *****************************************************
      * level 3 -- database cache
      *****************************************************


      *****************************************************
      * db2 connection options cache (sql)
      *****************************************************
     P cacClrOPT       B                   export
     D cacClrOPT       PI
      * vars
     D ptrDbP          s               *   inz(*NULL)
     D anyDB           ds                  likeds(sqOpt_t)
     D                                     dim(SQLMAXOPTS) based(ptrDbP)
      /free

       ptrDbP = %addr(sSqlConnSet);

       // @ADC 1.7.1 -- hazards templates (no auto-init)
       // 1077952576 == x'40404040' -- never initialized
       if anyDB(1).sqUsed = 1077952576
       and anyDB(1).sqLabel = *BLANKS;
         memset(ptrDbP:0:%size(anyDB:*ALL));
         return;
       endif;

       sql_options_free_all();  // @ADC error 1.7.1

       memset(ptrDbP:0:%size(anyDB:*ALL));
      /end-free
     P                 E

     P cacScanOPT      B                   export
     D cacScanOPT      PI             1N
     D  type                         10I 0 value
     D  here                         10I 0 value
     D  label                        10A
     D  pOpt                           *
      * vars
     D i               S             10I 0 inz(0)
     D where           S             10I 0 inz(0)
     D ptrDbP          s               *   inz(*NULL)
     D anyDB           ds                  likeds(sqOpt_t)
     D                                     dim(SQLMAXOPTS) based(ptrDbP)
     D pOpt2           s               *   inz(*NULL)
      /free
       ptrDbP = %addr(sSqlConnSet);
       where  = here;
       // found in cache?
       if where = 0;
       for i=1 to SQLMAXOPTS;
         select;
         when type = CAC_OPT_NEW;
           if anyDB(i).sqUsed = 0;
             where = i;
             leave;
           endif;
         when type = CAC_OPT_ANY;
           if anyDB(i).sqUsed > 1;
             where = i;
             leave;
           endif;
         // ???? 
         // CAC_OPT_UPDATE...
         // CAC_OPT_ACTIVE...
         // CAC_OPT_DELETE...
         other;
           // user supplied label
           if label <> *BLANKS;
             // find exact label
             if anyDB(i).sqLabel = label;
               where = i;
               leave;
             endif;
           endif;
         endsl;
       endfor;
       endif;
       // *** take action
       // not found
       if where = 0;
         pOpt = *NULL;
         return *OFF;
       endif;
       pOpt2 = %addr(anyDB(where));
       // update used count
       if type = CAC_OPT_NEW
       or type = CAC_OPT_ACTIVE;
         if anyDB(where).sqUsed < XMLMAXCNT;
           anyDB(where).sqUsed += 1;
         endif;
       endif;
       // new attributes
       if type = CAC_OPT_NEW
       or type = CAC_OPT_UPDATE;
         cpybytes(pOpt2:pOpt:%size(sqOpt_t)); 
         if label = *BLANKS;
           label              = 'opt'+%char(where);
         endif;
         anyDB(where).sqLabel = label;
         pOpt                 = pOpt2;
       // find attributes
       else;
         label                = anyDB(where).sqLabel;
         pOpt                 = pOpt2;
       endif;
       // destroy attributes (free slot)
       if type = CAC_OPT_DELETE;
         anyDB(where).sqUsed  = 0;
         anyDB(where).sqLabel = *BLANKS;
       endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * db2 connection cache (sql)
      *****************************************************
     P cacClrDB2       B                   export
     D cacClrDB2       PI
      * vars
     D ptrDbP          s               *   inz(*NULL)
     D anyDB           ds                  likeds(hConn_t)
     D                                     dim(SQLMAXCONN) based(ptrDbP)
      /free
       ptrDbP = %addr(sSqlConn);

       // @ADC 1.7.1 -- hazards templates (no auto-init)
       // 1077952576 == x'40404040' -- never initialized
       if anyDB(1).hused = 1077952576
       and anyDB(1).henv = 1077952576
       and anyDB(1).hdbc = 1077952576;
         memset(ptrDbP:0:%size(anyDB:*ALL));
         return;
       endif;

       sql_connect_free_all(); // @ADC error 1.7.1

       memset(ptrDbP:0:%size(anyDB:*ALL));
      /end-free
     P                 E

     P cacScanDB2      B                   export
     D cacScanDB2      PI             1N
     D  type                         10I 0 value
     D  here                         10I 0
     D  henv                         10I 0
     D  hdbc                         10I 0
     D  label                        10A
     D  options                      10A
     D  db                           10A
     D  uid                          10A
     D  pwd                          10A
      * vars
     D i               S             10I 0 inz(0)
     D where           S             10I 0 inz(0)
     D ptrDbP          s               *   inz(*NULL)
     D anyDB           ds                  likeds(hConn_t)
     D                                     dim(SQLMAXCONN) based(ptrDbP)
      /free
       // *** scanning
       ptrDbP = %addr(sSqlConn);
       where  = here;
       // found in cache?
       if where = 0;
       for i=1 to SQLMAXCONN;
         select;
         when type = CAC_CONN_NEW;
           if anyDB(i).hused = 0;
             where = i;
             leave;
           endif;
         when type = CAC_CONN_ANY;
           if anyDB(i).hused > 0;
             where = i;
             leave;
           endif;
         // ???? 
         // CAC_CONN_UPDATE...
         // CAC_CONN_ACTIVE...
         // CAC_CONN_DELETE...
         other;
           // user supplied label
           if label <> *BLANKS;
             // find exact label
             if anyDB(i).label = label;
               where = i;
               leave;
             endif;
           // user label = *BLANKS
           else;
             // find match connect
             if anyDB(i).hDB   = db
             and anyDB(i).hUID = uid
             and anyDB(i).hPWD = pwd
             and anyDB(i).hdbc > 0; // @ADC log (1.7.1)
               where = i;
               leave;
             endif;
           endif;
         endsl;
       endfor;
       endif;
       // *** take action
       // not found
       if where = 0;
         return *OFF;
       endif;
       // update used count
       if type = CAC_CONN_NEW
       or type = CAC_CONN_ACTIVE;
         if anyDB(where).hused < XMLMAXCNT;
           anyDB(where).hused += 1;
         endif;
       endif;
       // new attributes
       if type = CAC_CONN_NEW
       or type = CAC_CONN_UPDATE;
         // cache attributes
         anyDB(where).henv  = henv;
         anyDB(where).hdbc  = hdbc;
         anyDB(where).hDB   = db;
         anyDB(where).hUID  = uid;
         anyDB(where).hPWD  = pwd;
         if label = *BLANKS;
           label            = 'conn'+%char(where);
         endif;
         anyDB(where).label = label;
         anyDB(where).options = options;
       // find attributes
       else;
         henv               = anyDB(where).henv;
         hdbc               = anyDB(where).hdbc;
         db                 = anyDB(where).hDB;
         uid                = anyDB(where).hUID;
         pwd                = anyDB(where).hPWD;
         label              = anyDB(where).label;
         options            = anyDB(where).options;
       endif;
       // destroy attributes (free slot)
       if type = CAC_CONN_DELETE;
         anyDB(where).hused = 0;
         anyDB(where).henv  = 0;
         anyDB(where).hdbc  = 0;
         anyDB(where).label = *BLANKS;
         anyDB(where).options = *BLANKS;
         anyDB(where).hDB   = *BLANKS;
         anyDB(where).hUID  = *BLANKS;
         anyDB(where).hPWD  = *BLANKS;
       endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * Stm statement cache (sql)
      *****************************************************
     P cacClrStm       B                   export
     D cacClrStm       PI
      * vars
     D ptrDbP          s               *   inz(*NULL)
     D anyDB           ds                  likeds(hStmt_t)
     D                                     dim(SQLMAXSTMT) based(ptrDbP)
      /free
       ptrDbP = %addr(sSqlStmt);

       // @ADC 1.7.1 -- hazards templates (no auto-init)
       // 1077952576 == x'40404040' -- never initialized
       if anyDB(1).hused = 1077952576
       and anyDB(1).hstmt = 1077952576;
         memset(ptrDbP:0:%size(anyDB:*ALL));
         return;
       endif;

       sql_stmt_free_all();  // @ADC error 1.7.1

       memset(ptrDbP:0:%size(anyDB:*ALL));
      /end-free
     P                 E

     P cacScanStm      B                   export
     D cacScanStm      PI             1N
     D  type                         10I 0 value
     D  here                         10I 0 value
     D  hstmt                        10I 0
     D  conn                         10A
     D  label                        10A
     D  ncolT                         5i 0
     D  colT                           *
     D  nparmT                        5I 0
     D  parmT                          *
      * vars
     D sz              S             10I 0 inz(0)
     D i               S             10I 0 inz(0)
     D where           S             10I 0 inz(0)
     D ptrDbP          s               *   inz(*NULL)
     D anyDB           ds                  likeds(hStmt_t)
     D                                     dim(SQLMAXSTMT) based(ptrDbP)
      /free
       ptrDbP = %addr(sSqlStmt);
       where  = here;
       // found in cache?
       if where = 0;
       for i=1 to SQLMAXSTMT;
         select;
         when type = CAC_STMT_NEW;
           if anyDB(i).hused = 0;
             where = i;
             leave;
           endif;
         when type = CAC_STMT_ANY;
           if anyDB(i).hused > 0;
             where = i;
             leave;
           endif;
          when type = CAC_STMT_ANY_CONN;
            if anyDB(i).hused > 0 and anyDB(i).conn = conn;
              where = i;
              leave;
            endif;
         // ???? 
         // CAC_STMT_UPDATE...
         // CAC_STMT_ACTIVE...
         // CAC_STMT_DELETE...
         // CAC_STMT_ALLOC_COLT...
         // CAC_STMT_ALLOC_PARMT...
         // CAC_STMT_DEALLOC_COLT...
         // CAC_STMT_DEALLOC_PARMT...
         other;
           // user supplied label
           if label <> *BLANKS;
             // find exact label
             if anyDB(i).label = label;
               where = i;
               leave;
             endif;
           // user label = *BLANKS
           else;
             // find any match
             if anyDB(i).hused > 0
             and anyDB(i).label <> PERF_LOG_STMT_NAME; // @ADC log (1.7.1)
               where = i;
               leave;
             endif;
           endif;
         endsl;
       endfor;
       endif;
       // *** take action
       // not found
       if where = 0;
         return *OFF;
       endif;
       // update used count
       if type = CAC_STMT_NEW
       or type = CAC_STMT_ACTIVE;
         if anyDB(where).hused < XMLMAXCNT;
           anyDB(where).hused += 1;
         endif;
       endif;
       // new attributes
       if type = CAC_STMT_NEW
       or type = CAC_STMT_UPDATE
       or type = CAC_STMT_ALLOC_COLT
       or type = CAC_STMT_ALLOC_PARMT;
         anyDB(where).hstmt  = hstmt;
         anyDB(where).conn   = conn;
         if type = CAC_STMT_ALLOC_COLT;
           sz = (ncolT+1)*%size(hCol_t);
           anyDB(where).ncolT = ncolT;
           anyDB(where).colT  = cacAddBig(sz:CAC_HEAP_ILE_REUSE);
         endif;
         if type = CAC_STMT_ALLOC_PARMT;
           sz = (nparmT+1)*%size(hParm_t);
           anyDB(where).nparmT = nparmT;
           anyDB(where).parmT  = cacAddBig(sz:CAC_HEAP_ILE_REUSE);
         endif;
         ncolT               = anyDB(where).ncolT;
         colT                = cacScanBig(anyDB(where).colT);
         nparmT              = anyDB(where).nparmT;
         parmT               = cacScanBig(anyDB(where).parmT);
         if label = *BLANKS;
           label             = 'stmt'+%char(where);
         endif;
         anyDB(where).label  = label;
       // find attributes
       else;
         hstmt               = anyDB(where).hstmt;
         conn                = anyDB(where).conn;
         label               = anyDB(where).label;
         ncolT               = anyDB(where).ncolT;
         colT                = cacScanBig(anyDB(where).colT);
         nparmT              = anyDB(where).nparmT;
         parmT               = cacScanBig(anyDB(where).parmT);
       endif;
       // destroy attributes (free slot)
       if type = CAC_STMT_DELETE
       or type = CAC_STMT_DEALLOC_COLT
       or type = CAC_STMT_DEALLOC_PARMT;
         if type = CAC_STMT_DELETE;
           anyDB(where).hused  = 0;
           anyDB(where).hstmt  = 0;
           anyDB(where).conn   = *BLANKS;
           anyDB(where).label  = *BLANKS;
         endif;
         if type = CAC_STMT_DELETE
         or type = CAC_STMT_DEALLOC_COLT;
           cacClrBig(anyDB(where).colT:CAC_HEAP_ILE_REUSE);
           anyDB(where).ncolT  = 0;
           anyDB(where).colT   = 0;
           ncolT               = 0;
           colT                = *NULL;
         endif;
         if type = CAC_STMT_DELETE
         or type = CAC_STMT_DEALLOC_PARMT;
           cacClrBig(anyDB(where).parmT:CAC_HEAP_ILE_REUSE);
           anyDB(where).nparmT = 0;
           anyDB(where).parmT  = 0;
           nparmT              = 0;
           parmT               = *NULL;
         endif;
       endif;
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * cache iconv records
      *****************************************************
     P cacClrCnv       B                   export
     D cacClrCnv       PI
      * vars
     D rc              S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D ptrCnvP         s               *   inz(*NULL)
     D anyCnv          ds                  likeds(ciconv_t)
     D                                     dim(CNVOPNMAX) based(ptrCnvP)
      /free
       ptrCnvP = %addr(sCnvCache);
       for i = 1 to CNVOPNMAX;
         if anyCnv(i).conviok = CNVOPNOK;
           rc = convClose(anyCnv(i));
           anyCnv(i).conviok = 0;
         endif;
       endfor;
       memset(ptrCnvP:0:%size(anyCnv:*ALL));
      /end-free
     P                 E

     P cacScanCnv      B                   export
     D cacScanCnv      PI             1N
     D  fromCCSID                    10i 0 Value
     D  toCCSID                      10i 0 Value
     D  conv                               likeds(ciconv_t)
      * vars
     D where           S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D ptrCnvP         s               *   inz(*NULL)
     D anyCnv          ds                  likeds(ciconv_t)
     D                                     dim(CNVOPNMAX) based(ptrCnvP)
     D ptrTo           s               *   inz(*NULL)
     D ptrFrom         s               *   inz(*NULL)
     D convTgt         ds                  likeds(ciconv_t)
     D                                     based(ptrTo)
     D convSrc         ds                  likeds(ciconv_t)
     D                                     based(ptrFrom)
      /free
       ptrCnvP = %addr(sCnvCache);

       // scan the cache ...
       for i = 1 to CNVOPNMAX;
         // found in cache?
         select;
         when anyCnv(i).conviok = 0;
           leave;
         when anyCnv(i).fromcode.qtqCCSID = fromCCSID
         and anyCnv(i).tocode.qtqCCSID = toCCSID
         and anyCnv(i).conviok = CNVOPNOK;
           where = i;
           leave;
         // other?
         other;
         endsl;
       endfor;

       // copyout
       if where > 0;
         anyCnv(where).conviok = CNVOPNOK;
         ptrTo = %addr(conv);
         ptrFrom = %addr(anyCnv(where));
         cacCpyCnv(ptrTo:ptrFrom);
         return *ON;
       endif;

       return *OFF;
      /end-free
     P                 E


     P cacAddCnv       B                   export
     D cacAddCnv       PI
     D  conv                               likeds(ciconv_t)
      * vars
     D where           S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D rc              S             10i 0 inz(0)
     D ptrCnvP         s               *   inz(*NULL)
     D anyCnv          ds                  likeds(ciconv_t)
     D                                     dim(CNVOPNMAX) based(ptrCnvP)
     D ptrTo           s               *   inz(*NULL)
     D ptrFrom         s               *   inz(*NULL)
     D convTgt         ds                  likeds(ciconv_t)
     D                                     based(ptrTo)
     D convSrc         ds                  likeds(ciconv_t)
     D                                     based(ptrFrom)
      /free
       ptrCnvP = %addr(sCnvCache);

       // scan the cache ...
       for i = 1 to CNVOPNMAX;
         // found in cache?
         select;
         when anyCnv(i).conviok = 0;
           where = i;
           leave;
         // other?
         other;
         endsl;
       endfor;
       
       // not found ...
       // reuse random slot
       if where = 0;
         where = cacRandom(CNVOPNMAX);
         rc = convClose(anyCnv(where));
         anyCnv(where).conviok = 0;
       endif;

       // copy in
       ptrTo = %addr(anyCnv(where));
       ptrFrom = %addr(conv);
       cacCpyCnv(ptrTo:ptrFrom);
       anyCnv(where).conviok = CNVOPNOK;

      /end-free
     P                 E


     P cacCpyCnv       B                   export
     D cacCpyCnv       PI
     D  ptrTgt                         *   value
     D  ptrSrc                         *   value
      * vars
     D i               S             10i 0 inz(0)
     D ptrTo           s               *   inz(*NULL)
     D ptrFrom         s               *   inz(*NULL)
     D convTgt         ds                  likeds(ciconv_t)
     D                                     based(ptrTo)
     D convSrc         ds                  likeds(ciconv_t)
     D                                     based(ptrFrom)
      /free
       ptrTo = ptrTgt;
       ptrFrom = ptrSrc;

       convTgt.conviok = convSrc.conviok;

       convTgt.conv.rtn = convSrc.conv.rtn;
       for i = 1 to 12;
         convTgt.conv.cd(i) = convSrc.conv.cd(i);
       endfor;

       convTgt.tocode.qtqCCSID = convSrc.tocode.qtqCCSID;
       convTgt.tocode.qtqAltCnv = convSrc.tocode.qtqAltCnv;
       convTgt.tocode.qtqAltSub = convSrc.tocode.qtqAltSub;
       convTgt.tocode.qtqAltSft = convSrc.tocode.qtqAltSft;
       convTgt.tocode.qtqOptLen = convSrc.tocode.qtqOptLen;
       convTgt.tocode.qtqMixErr = convSrc.tocode.qtqMixErr;
       convTgt.tocode.qtqRsv = convSrc.tocode.qtqRsv;

       convTgt.fromcode.qtqCCSID = convSrc.fromcode.qtqCCSID;
       convTgt.fromcode.qtqAltCnv = convSrc.fromcode.qtqAltCnv;
       convTgt.fromcode.qtqAltSub = convSrc.fromcode.qtqAltSub;
       convTgt.fromcode.qtqAltSft = convSrc.fromcode.qtqAltSft;
       convTgt.fromcode.qtqOptLen = convSrc.fromcode.qtqOptLen;
       convTgt.fromcode.qtqMixErr = convSrc.fromcode.qtqMixErr;
       convTgt.fromcode.qtqRsv = convSrc.fromcode.qtqRsv;
      /end-free
     P                 E


     P cacNulCnv       B                   export
     D cacNulCnv       PI
     D  convTgt                            likeds(ciconv_t)
      * vars
     D i               S             10i 0 inz(0)
      /free
       convTgt.conviok = 0;

       convTgt.conv.rtn = 0;
       for i = 1 to 12;
         convTgt.conv.cd(i) = 0;
       endfor;

       convTgt.tocode.qtqCCSID = 0;
       convTgt.tocode.qtqAltCnv = 0;
       convTgt.tocode.qtqAltSub = 0;
       convTgt.tocode.qtqAltSft = 0;
       convTgt.tocode.qtqOptLen = 0;
       convTgt.tocode.qtqMixErr = 0;
       convTgt.tocode.qtqRsv = 0;

       convTgt.fromcode.qtqCCSID = 0;
       convTgt.fromcode.qtqAltCnv = 0;
       convTgt.fromcode.qtqAltSub = 0;
       convTgt.fromcode.qtqAltSft = 0;
       convTgt.fromcode.qtqOptLen = 0;
       convTgt.fromcode.qtqMixErr = 0;
       convTgt.fromcode.qtqRsv = 0;
      /end-free
     P                 E

      *****************************************************
      * pase call lib cache                         (1.8.5)
      *****************************************************
     P cacClrLib       B                   export
     D cacClrLib       PI
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(libRec_t)
     D                                     dim(PASELIBMAX) based(ptrDcP)
      /free
       ptrDcP = %addr(sLibCache);
       memset(ptrDcP:0:%size(anyDC:*ALL));
      /end-free
     P                 E

     P cacScanLib      B                   export
     D cacScanLib      PI             1N
     D libLibName                    32A   value
     D libMbrName                    32A   value
     D libPthName                  4096A   value
     D pasePtr                       20U 0
      * vars
     D i               S             10I 0 inz(0)
     D where           S             10I 0 inz(0)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(libRec_t)
     D                                     dim(PASELIBMAX) based(ptrDcP)
      /free
       ptrDcP = %addr(sSymCache);
       // found in cache?
       for i=1 to PASELIBMAX;
         // find match in shared object
         if anyDC(i).libLibName = libLibName
         and anyDC(i).libMbrName = libMbrName
         and anyDC(i).libPthName = libPthName;
           where = i;
           leave;
         endif;
         // empty cache slot
         if anyDC(i).libLibPtr = 0;
           leave;
         endif;
       endfor;
       // found
       if where > 0;
         pasePtr = anyDC(where).libLibPtr;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E

     P cacAddLib       B                   export
     D cacAddLib       PI
     D libLibName                    32A   value
     D libMbrName                    32A   value
     D libPthName                  4096A   value
     D pasePtr                       20U 0 value
      * vars
     D rc              s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D where           s             10i 0 inz(0)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(libRec_t)
     D                                     dim(PASELIBMAX) based(ptrDcP)
      /free
       ptrDcP = %addr(sSymCache);
       // found in cache?
       for i=1 to PASELIBMAX;
         // find match in shared object
         if anyDC(i).libLibName = libLibName
         and anyDC(i).libMbrName = libMbrName
         and anyDC(i).libPthName = libPthName;
           where = i;
           leave;
         endif;
         // empty cache slot
         if anyDC(i).libLibPtr = 0;
           leave;
         endif;
       endfor;
       // found
       if where > 0;
         anyDC(where).libLibPtr   = pasePtr;
         anyDC(where).libMbrName  = libMbrName;
         anyDC(where).libLibName  = libLibName;
         anyDC(where).libPthName  = libPthName;
       endif;
      /end-free
     P                 E

      *****************************************************
      * pase call sym cache                         (1.8.5)
      *****************************************************
     P cacClrSym       B                   export
     D cacClrSym       PI
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(symRec_t)
     D                                     dim(PASESYMMAX) based(ptrDcP)
      /free
       ptrDcP = %addr(sSymCache);
       memset(ptrDcP:0:%size(anyDC:*ALL));
      /end-free
     P                 E

     P cacScanSym      B                   export
     D cacScanSym      PI             1N
     D symPthNbr                     10i 0 value
     D symSymName                   256A   value
     D pasePtr                       20U 0
      * vars
     D i               S             10I 0 inz(0)
     D where           S             10I 0 inz(0)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(symRec_t)
     D                                     dim(PASESYMMAX) based(ptrDcP)
      /free
       ptrDcP = %addr(sSymCache);
       // found in cache?
       for i=1 to PASESYMMAX;
         // find match in shared object
         if anyDC(i).symPthNbr = symPthNbr
         and anyDC(i).symSymName = symSymName;
           where = i;
           leave;
         endif;
         // empty cache slot
         if anyDC(i).symPthNbr = 0;
           leave;
         endif;
       endfor;
       // found
       if where > 0;
         pasePtr = anyDC(where).symSymPtr;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E

     P cacAddSym       B                   export
     D cacAddSym       PI
     D symPthNbr                     10i 0 value
     D symSymName                   256A   value
     D pasePtr                       20U 0 value
      * vars
     D rc              s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D where           s             10i 0 inz(0)
      * program cached
     D ptrDcP          s               *   inz(*NULL)
     D anyDC           ds                  likeds(symRec_t)
     D                                     dim(PASESYMMAX) based(ptrDcP)
      /free
       ptrDcP = %addr(sSymCache);
       // found in cache?
       for i=1 to PASESYMMAX;
         // find match in shared object
         if anyDC(i).symPthNbr = symPthNbr
         and anyDC(i).symSymName = symSymName;
           where = i;
           leave;
         endif;
         // empty cache slot
         if anyDC(i).symPthNbr = 0;
           where = i;
           leave;
         endif;
       endfor;
       // found
       if where > 0;
         anyDC(where).symPthNbr   = symPthNbr;
         anyDC(where).symSymPtr   = pasePtr;
         anyDC(where).symSymName  = symSymName;
       endif;
      /end-free
     P                 E


      *****************************************************
      * cache random
      * return (NA)
      *****************************************************
     P cacRandom       B
     D cacRandom       PI            10i 0
     D   limit                       10i 0 value
      /free
       sRandom += 1;
       if sRandom > limit;
         sRandom = 1;
       endif;
       return sRandom;
      /end-free
     P                 E


