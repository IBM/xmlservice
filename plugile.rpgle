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
      /copy plugcach_h
      /copy plugconv_h
      /copy plugipc_h
      /copy plugperf_h

      *****************************************************
      * global vars
      *****************************************************
     D sBDefault       s              2A   inz('00')
     D sADefault       s              1A   inz(' ')
     D sIDefault       s              1A   inz('0')
     D sUDefault       s              1A   inz('0')
     D sFDefault       s              1A   inz('0')
     D sDDefault       s              1A   inz('0')
     D sPDefault       s              1A   inz('0')
     D sSDefault       s              1A   inz('0')

     D sOPM            S              1A   inz(XML_PGM_OPM_FALSE)

     D sDoTest         s             10i 0 inz(-42)

     D sRexxOpen       S              1N   inz(*OFF)
     D sROutOpen       S              1N   inz(*OFF)
     D sRexxRdy        S              1N   inz(*OFF)

     D SYSSTATUS       S             10i 0 inz(0)
     D SYSMSGID        S              7a   inz(*BLANKS)
     D SYSSTATUS2      S             10i 0 inz(0)
     D SYSMSGID2       S              7a   inz(*BLANKS)

     D ileSetSts       PR
     D   mySTATUS                    10i 0 value options(*nopass)
     D   myMSGID                      7a   value options(*nopass)

     D sOrigP          S               *   inz(*NULL)
     D sOrig           S             10u 0 inz(0)

     D sArgvP          S               *   inz(*NULL)
     D sArgvBegP       S               *   inz(*NULL)
     D sArgvSz         S             10i 0 inz(0)

     D sParmP          S               *   inz(*NULL)
     D sParmBegP       S               *   inz(*NULL)
     D sParmSz         S             10i 0 inz(0)

     D sRetP           S               *   inz(*NULL)
     D sRetBegP        S               *   inz(*NULL)
     D sRetSz          S             10i 0 inz(0)
     D sRetAgg         S              1N   inz(*OFF)

     D sSigP           S               *   inz(*NULL)
     D sSigBegP        S               *   inz(*NULL)
     D sSigSz          S             10i 0 inz(0)

      * Mark start parm top='n'
     D zCount          S             10i 0 inz(0)

      * misc variable list
     D valist_t        ds                  qualified based(Template)
     D  vp1                            *
     D  vp2                            *

      * bigScan
     D search00        s             20A   inz(*BLANKS)
     D pLook00         s               *   inz(%addr(search00))
     D myLook00        ds                  likeds(over_t) based(pLook00)

      *****************************************************
      * ile converts
      *****************************************************
     D cpyInF64        PR             1N
     D   valPtrP                       *
     D   node                              likeds(xmlNode_t)

     D cpyInDec        PR             1N
     D   valPtrP                       *
     D   node                              likeds(xmlNode_t)

     D cpyOutFmt       PR             1N
     D   outPtrP                       *
     D   valPtrP                       *
     D   f64                          8f
     D   node                              likeds(xmlNode_t)

     D cpyOutF64       PR             1N
     D   outPtrP                       *
     D   valPtrP                       *
     D   node                              likeds(xmlNode_t)

     D cpyOutDec       PR             1N
     D   outPtrP                       *
     D   valPtrP                       *
     D   node                              likeds(xmlNode_t)

      *****************************************************
      * misc
      *****************************************************
     D ileCalcRet      PR

     D ileCurrent      PR             1N
     D   node                              likeds(xmlNode_t)

     D ileNext         PR             1N
     D   node                              likeds(xmlNode_t)

     D ileDecSize      PR            10i 0
     D   nbr                         10i 0 value
     D   zone                         1N   value

     D ileWrtf         PR             1N
     D   pData                         *   value
     D   pSize                       10i 0 value
     D   pTmpFile                  1024A   value

      *****************************************************
      * ile current position
      * return (addr)
      *****************************************************
     P ileAddr         B                   export
     D ileAddr         PI              *
     D  isReturn                      1N   value
      /free
       if isReturn = *ON;
         ileCalcRet();
         return sRetP;
       endif;
       return sParmP;
      /end-free
     P                 E


     P ileDup          B                   export
     D ileDup          PI
     D  isReturn                      1N   value
     D  pdupbeg                        *   value
     D  pdupend                        *   value
      * vars
     D sz              s             10i 0 inz(0)
      /free
       sz = pdupend - pdupbeg;
       if isReturn = *ON;
         cpybytes(sRetP:pdupbeg:sz);
         sRetP += sz;
         sRetSz += sz;
       else;
         cpybytes(sParmP:pdupbeg:sz);
         sParmP += sz;
         sParmSz += sz;
       endif;
      /end-free
     P                 E


      *****************************************************
      * ile set global
      * return (NA)
      *****************************************************
     P ileDoTest       B                   export
     D ileDoTest       PI
     D  endTest                       1A   value
      /free
       if endTest = *ON;
         sDoTest = -42;
       else;
         sDoTest = ipcDoTest();
       endif;
      /end-free
     P                 E

      *****************************************************
      * ile set global
      * return (NA)
      *****************************************************
     P ileStatic       B                   export
     D ileStatic       PI             1N
     D  allOPM                        1A   value
      * vars
     D rc              s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D memI            s             10i 0 inz(0)
     D ptrMemP         s               *   inz(*NULL)
     D memCtl          ds                  likeds(paseRec_t) based(ptrMemP)
      /free
       sOPM = allOPM;

       // --------------
       // get ILE memory (not wake up PASE)
       if sOPM = XML_PGM_OPM_TRUE;
         memI = cacAddBig(SZOPM:CAC_HEAP_PGM_OPM);
       // --------------
       // get pase memory (may wake up PASE)
       else;
         memI = cacAddBig(SZALL:CAC_HEAP_PGM_PASE);
       endif;
       if memI = 0;
         return *OFF;
       endif;
       ptrMemP = cacScanBig(memI);

       // original pase allocation
       sOrig     = memCtl.paseOrig;
       sOrigP    = memCtl.paseOrigP;

       // signatures for _ILECALL
       sSigBegP  = memCtl.paseSigP;
       sSigP     = sSigBegP;
       sSigSz    = 0;
       memset(sSigP:0:SZSIG);

       // argv[] for _PGMCALL
       sArgvP    = memCtl.paseArgvP;
       sArgvBegP = ileQuad(sOrigP:sArgvP);
       sArgvP    = sArgvBegP;
       sArgvSz   = 0;

       // parms copy in 
       sParmP    = sArgvBegP + SZARGC;
       sParmBegP = ileQuad(sOrigP:sParmP);
       sParmP    = sParmBegP;
       sParmSz   = 0;

       // return copy in (occurs after parms)
       sRetP     = *NULL;
       sRetBegP  = *NULL;
       sRetSz    = 0;
       sRetAgg   = *OFF;

       // Mark start parm top='n'
       zCount = 0;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * return area
      * return size
      *****************************************************
     P ileCalcRet      B
     D ileCalcRet      PI
      /free
       if sRetBegP = *NULL;
         sRetBegP = ileQuad(sOrigP:sParmP);
         sRetP    = sRetBegP;
       endif;
      /end-free
     P                 E

      *****************************************************
      * mark ILE push/pop conditions
      * return na
      *****************************************************
     P ileMark         B                   export
     D ileMark         PI
     D   op                           1A   value
     D   wrkWth                       1A   value
     D   offset                      10i 0 value options(*nopass)
     D   parmno                      10i 0 value options(*nopass)
      * vars
     D sz              s             10i 0 inz(0)
     D pi              s             10i 0 inz(0)
      /free
       if %parms > 2;
         sz = offset;
       endif;
       if %parms > 3;
         pi = parmno;
       endif;

       select;
       when op = ILE_SAVE_START;
         // where is return placed?
         if wrkWth = XML_IS_RETURN;
           ileCalcRet();
         endif;
         // cache save top locations
         cacAddOvr(CAC_OVR_TOP:sOrigP
              :sArgvBegP:0:sParmBegP:0
              :sRetBegP:0:sSigBegP:0);
         // cache save start locations
         cacAddOvr(CAC_OVR_START:sOrigP
              :sArgvP:sArgvSz:sParmP:sParmSz
              :sRetP:sRetSz:sSigP:sSigSz);
         // cache save parm/return locations
         if wrkWth = XML_IS_PARM;
           zCount += 1;
           cacAddOvr(zCount:sOrigP
              :sArgvP:sArgvSz:sParmP:sParmSz
              :sRetP:sRetSz:sSigP:sSigSz);
         endif;
       when op = ILE_RESTORE_PARM;
         // cache restore parm/return locations
         cacScanOvr(pi:sz:sOrigP
              :sArgvP:sArgvSz:sParmP:sParmSz
              :sRetP:sRetSz:sSigP:sSigSz);
       when op = ILE_RESTORE_TOP;
         // cache restore top locations + offset
         cacScanOvr(CAC_OVR_TOP:sz:sOrigP
              :sArgvP:sArgvSz:sParmP:sParmSz
              :sRetP:sRetSz:sSigP:sSigSz);
       when op = ILE_RESTORE_START;
         // cache restore start locations + offset
         cacScanOvr(CAC_OVR_START:sz:sOrigP
              :sArgvP:sArgvSz:sParmP:sParmSz
              :sRetP:sRetSz:sSigP:sSigSz);
       when op = ILE_SAVE_END;
         // cache end locations
         cacAddOvr(CAC_OVR_END:sOrigP
              :sArgvP:sArgvSz:sParmP:sParmSz
              :sRetP:sRetSz:sSigP:sSigSz);
       when op = ILE_RESTORE_END;
         // cache restore end locations + offset
         cacScanOvr(CAC_OVR_END:sz:sOrigP
              :sArgvP:sArgvSz:sParmP:sParmSz
              :sRetP:sRetSz:sSigP:sSigSz);
       // ???? 
       other;
       endsl;

      /end-free
     P                 E

      *****************************************************
      * ILE input format double
      * return (*ON=good, *OFF=error)
      *****************************************************
     P cpyInF64        B
     D cpyInF64        PI             1N
     D   valPtrP                       *
     D   node                              likeds(xmlNode_t)
      * vars
     D rc              s              1N   inz(*OFF)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D f64             s              8f   inz(0.0)
     D ptrP            s               *   inz(*NULL)
     D sz              s             10i 0 inz(0)
     D strP            s               *   inz(*NULL)
     D strSz           s             10i 0 inz(0)
      /free
       // copy in faster way ...
       rc = cacScanF64(*OFF:CAC_F64_SCAN_STR_SAME:valPtrP
                   :f64:ptrP:sz:strP:strSz
                   :node.xmlStrP
                   :node.xmlStrSz
                   :node.xmlAttr
                   :node.xmlDigits
                   :node.xmlFrac
                   :node.pgmValSz);
       // copy in slower way ...
       if rc = *OFF;
         f64 = %float(%str(node.xmlStrP:node.xmlStrSz));
         cacAddF64(*OFF:valPtrP:f64
                   :node.xmlStrP
                   :node.xmlStrSz
                   :node.xmlAttr
                   :node.xmlDigits
                   :node.xmlFrac
                   :node.pgmValSz);
       endif;
       // copy in ...
       pCopy = valPtrP;
       select;
       // float
       when node.xmlAttr = XML_ATTR_VAL_F;
         myCopy.floatx = f64;
       // double
       when node.xmlAttr = XML_ATTR_VAL_D;
         myCopy.doublex = f64;
       // other?
       other;
       endsl;
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * ILE input format decimal
      * return (*ON=good, *OFF=error)
      *****************************************************
     P cpyInDec        B
     D cpyInDec        PI             1N
     D   valPtrP                       *
     D   node                              likeds(xmlNode_t)
      * vars
     D rc              s              1N   inz(*OFF)
     D f64             s              8f   inz(0.0)
     D ptrP            s               *   inz(*NULL)
     D sz              s             10i 0 inz(0)
     D strP            s               *   inz(*NULL)
     D strSz           s             10i 0 inz(0)
      /free
       // copy in faster way ...
       rc = cacScanF64(*OFF:CAC_F64_SCAN_STR_SAME:valPtrP
                   :f64:ptrP:sz:strP:strSz
                   :node.xmlStrP
                   :node.xmlStrSz
                   :node.xmlAttr
                   :node.xmlDigits
                   :node.xmlFrac
                   :node.pgmValSz);
       if rc = *ON;
         cpybytes(valPtrP:ptrP:sz);
         return *ON;
       endif;

       // copy in slower way ...
       f64 = %float(%str(node.xmlStrP:node.xmlStrSz));

       // call ILE converter ...
       select;
       // packed decimal
       when node.xmlAttr = XML_ATTR_VAL_P;
         QXXDTOP(valPtrP:node.xmlDigits:node.xmlFrac:f64);
       // zoned decimal
       when node.xmlAttr = XML_ATTR_VAL_S;
         QXXDTOZ(valPtrP:node.xmlDigits:node.xmlFrac:f64);
       // other?
       other;
       endsl;

       // save for faster way ...
       cacAddF64(*OFF:valPtrP:f64
                   :node.xmlStrP
                   :node.xmlStrSz
                   :node.xmlAttr
                   :node.xmlDigits
                   :node.xmlFrac
                   :node.pgmValSz);

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * ILE output format double
      * return (*ON=good, *OFF=error)
      *****************************************************
     P cpyOutFmt       B
     D cpyOutFmt       PI             1N
     D   outPtrP                       *
     D   valPtrP                       *
     D   f64                          8f
     D   node                              likeds(xmlNode_t)
      * vars
     D valist          ds                  likeds(valist_t)
     D str             s             64A   inz(*BLANKS)
     D strP            s               *   inz(%addr(str))
     D strSz           s             10i 0 inz(0)
     D fmt             s             64A   inz(*BLANKS)
     D fmtP            s               *   inz(%addr(fmt))
      /free
       // copy out slow way sprintf ...
       fmt = '%1.' + %char(node.xmlFrac) + 'f' + x'00';
       valist.vp1 = fmtP;
       valist.vp2 = %addr(f64);
       strSz = sprintf(strP:fmtP:%addr(valist));
       str = %trim(str);
       strSz = %len(%trim(str)) - 1;
       if strSz < 1;
         return *ON;
       endif;
       cpybytes(outPtrP:strP:strSz);
       outPtrP += strSz;

       // save for fast way ...
       node.xmlStrP = strP;
       node.xmlStrSz = strSz;
       cacAddF64(*ON:valPtrP:f64
                   :node.xmlStrP
                   :node.xmlStrSz
                   :node.xmlAttr
                   :node.xmlDigits
                   :node.xmlFrac
                   :node.pgmValSz);

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * ILE output format double
      * return (*ON=good, *OFF=error)
      *****************************************************
     P cpyOutF64       B
     D cpyOutF64       PI             1N
     D   outPtrP                       *
     D   valPtrP                       *
     D   node                              likeds(xmlNode_t)
      * vars
     D rc              s              1N   inz(*OFF)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D f64             s              8f   inz(0.0)
     D ptrP            s               *   inz(*NULL)
     D sz              s             10i 0 inz(0)
     D strP            s               *   inz(*NULL)
     D strSz           s             10i 0 inz(0)
      /free
       // float value
       pCopy = valPtrP;
       select;
       // float
       when node.xmlAttr = XML_ATTR_VAL_F;
         // as single return value only f8 allowed
         if node.xmlPrmRet = XML_IS_RETURN and sRetSz = RESULT_FLOAT64;
           f64 = myCopy.doublex;
         else;
           f64 = myCopy.floatx;
         endif;
       // double
       when node.xmlAttr = XML_ATTR_VAL_D;
         f64 = myCopy.doublex;
       // other?
       other;
       endsl;
       // copy out fast way ...
       rc = cacScanF64(*ON:CAC_F64_SCAN_DOUBLE_SAME:valPtrP
                   :f64:ptrP:sz:strP:strSz
                   :node.xmlStrP
                   :node.xmlStrSz
                   :node.xmlAttr
                   :node.xmlDigits
                   :node.xmlFrac
                   :node.pgmValSz);
       if rc = *ON;
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         return *ON;
       endif;
       // copy out slow way sprintf ...
       return cpyOutFmt(outPtrP:valPtrP:f64:node);
      /end-free
     P                 E


      *****************************************************
      * ILE output format double
      * return (*ON=good, *OFF=error)
      *****************************************************
     P cpyOutDec       B
     D cpyOutDec       PI             1N
     D   outPtrP                       *
     D   valPtrP                       *
     D   node                              likeds(xmlNode_t)
      * vars
     D rc              s              1N   inz(*OFF)
     D f64             s              8f   inz(0.0)
     D ptrP            s               *   inz(*NULL)
     D sz              s             10i 0 inz(0)
     D strP            s               *   inz(*NULL)
     D strSz           s             10i 0 inz(0)
      /free
       // copy out fast way ...
       rc = cacScanF64(*ON:CAC_F64_SCAN_DECIMAL_SAME:valPtrP
                   :f64:ptrP:sz:strP:strSz
                   :node.xmlStrP
                   :node.xmlStrSz
                   :node.xmlAttr
                   :node.xmlDigits
                   :node.xmlFrac
                   :node.pgmValSz);
       if rc = *ON;
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         return *ON;
       endif;

       // call the ILE converter ...
       select;
       // packed decimal
       when node.xmlAttr = XML_ATTR_VAL_P;
         f64 = QXXPTOD(valPtrP:node.xmlDigits:node.xmlFrac);
       // zoned decimal
       when node.xmlAttr = XML_ATTR_VAL_S;
         f64 = QXXZTOD(valPtrP:node.xmlDigits:node.xmlFrac);
       // other?
       other;
       endsl;

       // copy out slow way sprintf ...
       return cpyOutFmt(outPtrP:valPtrP:f64:node);
      /end-free
     P                 E

      *****************************************************
      * ILE errno
      * return (NA)
      *****************************************************
     P ileEZero        B                   export
     D ileEZero        PI
      * vars
     D pErrorNo        S               *   inz(*NULL)
     D ErrorNo         S             10I 0 Based(pErrorNo)
      /free
       pErrorNo = GetErrNo();
       if pErrorNo <> *NULL;
         ErrorNo = 0;
       endif;
       SYSEXPID = *BLANKS;
       SYSMSGID = *BLANKS;
       SYSSTATUS = 0;
      /end-free
     P                 E

     P ileErrno        B                   export
     D ileErrno        PI            10I 0
      * vars
     D pErrorNo        S               *   inz(*NULL)
     D ErrorNo         S             10I 0 Based(pErrorNo)
      /free
       pErrorNo = GetErrNo();
       if pErrorNo <> *NULL;
         return ErrorNo;
       endif;
       return 0;
      /end-free
     P                 E

     P ileSetSts       B
     D ileSetSts       PI
     D   mySTATUS                    10i 0 value options(*nopass)
     D   myMSGID                      7a   value options(*nopass)
      /free
       if %parms >=1 and mySTATUS <> 0;
         SYSSTATUS = mySTATUS;   // user status
       else;
         SYSSTATUS = %status;    // system status
       endif;
       if %parms >=2 and myMSGID <> *BLANKS;
         SYSMSGID = myMSGID;     // user msgid
       else;
         SYSMSGID = SYSEXPID;    // system msgid
       endif;
       // compatibility (1.6.7)
       SYSMSGID2  = SYSMSGID;    // saved
       SYSSTATUS2 = SYSSTATUS;   // saved
      /end-free
     P                 E

     P ileStatus       B                   export
     D ileStatus       PI            10I 0
      * vars
     D mySTATUS        S             10i 0 inz(0)
      /free
       mySTATUS = SYSSTATUS;   // extracted
       SYSSTATUS = 0;          // nothing
       return mySTATUS;
      /end-free
     P                 E

     P ileStatus2      B                   export
     D ileStatus2      PI            10I 0
      * vars
     D mySTATUS        S             10i 0 inz(0)
      /free
       mySTATUS = SYSSTATUS2;   // extracted
       SYSSTATUS2 = 0;          // nothing
       return mySTATUS;
      /end-free
     P                 E

     P ileMsgId        B                   export
     D ileMsgId        PI             7A
      * vars
     D myMSGID         S              7a   inz(*BLANKS)
      /free
       myMSGID = SYSMSGID;    // extracted
       SYSEXPID = *BLANKS;    // nothing
       SYSMSGID = *BLANKS;    // nothing
       return myMSGID;
      /end-free
     P                 E

     P ileMsgId2       B                   export
     D ileMsgId2       PI             7A
      * vars
     D myMSGID         S              7a   inz(*BLANKS)
      /free
       myMSGID = SYSMSGID2;    // extracted
       SYSMSGID2 = *BLANKS;    // nothing
       return myMSGID;
      /end-free
     P                 E


      *****************************************************
      * ILE Call Cmd
      * return (NA)
      *****************************************************
     P ileCmdCap       B                   export
     D ileCmdCap       PI             1N
     D   cmd                           *   value
     D   len                         10i 0 value
      * vars
     D cmdstr          s           1024A   inz(*BLANKS)
     D rcb             s              1N   inz(*ON)

     D Cc_loscs        S              9b 0
     D Cc_ocbl         S              9b 0
     D Cc_ocbf         S              8    inz('CPOP0100')
     D Cc_lafccs       S              9b 0 inz(0)
     D Cc_loccsatr     S              9b 0                                  

     D Cpop0100        Ds                  inz
     D  cpop_tocp                     9b 0 inz(0)
     D  cpop_dbcs                     1    inz('0')
     D  cpop_pa                       1    inz('0')
     D  cpop_css                      1    inz('0')
     D  cpop_mk                       4
     D                                9    inz(x'000000000000000000')

     D dsEC            DS
     D  dsECBytesP             1      4I 0 INZ(256)
     D  dsECBytesA             5      8I 0 INZ(0)
     D  dsECMsgID              9     15
     D  dsECReserv            16     16
     D  dsECMsgDta            17    256
      /free
       Monitor;

       ileEZero();

       // -------------
       // execute command
       cmdstr = %str(cmd:len);
       cmdcap(%trim(cmdstr):
        %len(%trim(cmdstr)):
        cpop0100:
        %len(cpop0100):
        cc_ocbf:
        cmdstr:
        %len(cmdstr):
        cc_loccsatr:
        dsEC);
       if dsECBytesA > 0;
         ileSetSts(0:dsECMsgID);
         return *OFF;
       endif;

       // -------------
       // error
       On-error;
         ileSetSts();
         rcb = *OFF;
       Endmon;

       return rcb;
      /end-free
     P                 E

      *****************************************************
      * ILE Call Cmd
      * return (NA)
      *****************************************************
     P ileCmdExc       B                   export
     D ileCmdExc       PI             1N
     D   cmd                           *   value
     D   len                         10i 0 value
      * vars
     D cmdstr          s           3000A   inz(*BLANKS)
     D rcb             s              1N   inz(*ON)
      /free
       Monitor;

       ileEZero();

       // -------------
       // execute command
       cmdstr = %str(cmd:len);
       cmdexec(cmdstr:len);

       // -------------
       // error
       On-error;
         ileSetSts();
         rcb = *OFF;
       Endmon;

       return rcb;
      /end-free
     P                 E

      *****************************************************
      * ILE Call Cmd with system
      * return (NA)
      *****************************************************
     P ileSystem       B                   export
     D ileSystem       PI             1N
     D   cmd                           *
     D   len                         10i 0
      * vars
     D cmdstr          s           3000A   inz(*BLANKS)
     D rcb             s              1N   inz(*ON)
     D rc              s             10i 0 inz(0)
      /free
       Monitor;

       ileEZero();

       // -------------
       // execute command
       cmdstr = %str(cmd:len);
       rc = system(cmdstr);
       if rc <> 0;
         ileSetSts();
         rcb = *OFF;
       endif;

       // -------------
       // error
       On-error;
         ileSetSts();
         rcb = *OFF;
       Endmon;

       return rcb;
      /end-free
     P                 E


      *****************************************************
      * ILE write in source member
      * return (*ON-ok; *OFF-bad)
      *****************************************************
     P ileWrtf         B
     D ileWrtf         PI             1N
     D   pData                         *   value
     D   pSize                       10i 0 value
     D   pTmpFile                  1024A   value
      * vars
     d fd              s             10i 0 inz(0)
     d rc              s             10i 0 inz(0)
     d rc1             s             10i 0 inz(0)
     d pPath           s               *   inz(*NULL)
     D myFile          s           1024A   inz(*BLANKS)
      /free
       myFile = %trim(pTmpFile)+x'00';
       fd = openIFS(myFile
              :O_WRONLY + O_CREAT + O_TRUNC + O_TEXTDATA + O_CODEPAGE
              :S_IRUSR + S_IWUSR
              :37);
       if fd > -1;
         rc = writeIFS(fd:pData:pSize);
         rc1 = closeIFS(fd);
       else;
         rc = -1;
       endif;
       if rc > -1;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * ILE Call Cmd with REXX
      * return (NA)
      *****************************************************
     P ileRexx         B                   export
     D ileRexx         PI             1N
     D   setCDATA                     1N   value
     D   cmd                           *
     D   len                         10i 0
     D   datastr                  65000A
      * vars
     D search          s              8A   inz('</error>')
     D chop            s              7A   inz('</chop>')
     D addlf           s              5A   inz('</lf>')
     D pChop           s               *   inz(*NULL)
     D PAddLF          s               *   inz(*NULL)
     D rlen            s             10i 0 inz(0)
     D pos             s             10i 0 inz(0)
     D cmdstr          s           3000A   inz(*BLANKS)
     D cmdp            s               *   inz(%addr(cmdstr))
     D cmdlen          s             10i 0 inz(0)
     D rcb             s              1N   inz(*ON)
     D rc              s             10i 0 inz(0)
      * vars
     d result          s               *   inz(*NULL)
     d fd              s               *   inz(*NULL)
     d i               s             10i 0 inz(0)
     d rc1             s             10i 0 inz(0)
     D myCmd           S          65000A   inz(*BLANKS)
     D myData          S          65000A   inz(*BLANKS)
     D pData           S               *   inz(%addr(myData))
     D pSize           S             10i 0 inz(0)
     D pData2          S               *   inz(*NULL)
     D pSize2          S             10i 0 inz(0)
     D myCData         S             40A   inz(*BLANKS)
     D myCDataOFF      c                   const(':CDD0:*OFF')
     D myCDataON       c                   const(':CDD0:*ON')
     D myCDATABEG      c                   const(':CDD1:') 
     D myCDATAEND      c                   const(':CDD2:') 
     D myCDATAFIN      c                   const(':CFIN:') 
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
      /free
       Monitor;

       cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
       cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)

       ileEZero();

       datastr = *BLANKS;

       // -------------
       // write rexx program (once)
       if sRexxRdy = *OFF;
         // create src files
         cmdstr = 'CRTSRCPF FILE(QTEMP/XMLREXX)'
                +  '  RCDLEN(92) CCSID(37) MBR(HOW)';
         cmdlen = %len(%trim(cmdstr));
         rcb = ileCmdExc(cmdp:cmdlen);

         // authorize PUBLIC (1.6.2)
         cmdstr = 'GRTOBJAUT OBJ(QTEMP/XMLREXX)'
                + ' OBJTYPE(*FILE) USER(*PUBLIC) AUT(*ALL)';
         cmdlen = %len(%trim(cmdstr));
         rcb = ileCmdExc(cmdp:cmdlen);

         sRexxOpen = *ON;
         myData =
             '/* STRREXPRC SRCMBR(HOW)                       */'+x'25'
           + '/* SRCFILE(QTEMP/XMLREXX)                      */'+x'25'
           + '/* PARM(''RTVJOBA USRLIBL(?)                   */'+x'25'
           + '/* :CDD0:*ON|*OFF                              */'+x'25'
           + '/* :CDD1:CDATAbeg                              */'+x'25'
           + '/* :CDD2:CDATAend                              */'+x'25'
           + '/* :CFIN:junk'')                               */'+x'25'
           + 'parse arg linein'
           + ' ":CDD0:" cdata'
           + ' ":CDD1:" cdata1'
           + ' ":CDD2:" cdata2'
           + ' ":CFIN:" jk'
           + x'25'
           + '/* create output */'+x'25'
           + '''DLTF FILE(QTEMP/OUTREXX)'''+x'25'
           + '''CRTSRCPF FILE(QTEMP/OUTREXX) MBR(OUTREXX)'''+x'25'
           + '/* authorize PUBLIC (1.6.2) */'+x'25'
           + '''GRTOBJAUT OBJ(QTEMP/OUTREXX) OBJTYPE(*FILE)'
           + ' USER(*PUBLIC) AUT(*ALL)'''+x'25'
           + '''CLRPFM FILE(QTEMP/OUTREXX) MBR(OUTREXX)'''+x'25'
           + '''OVRDBF FILE(STDOUT) TOFILE(QTEMP/OUTREXX)'
           + ' MBR(OUTREXX)'''+x'25'
           + '/* substitution chars */'+x'25'
           + 'V = ""'+x'25'
           + 'V = keysub(linein)'+x'25'
           + 'line = V.dat'+x'25'
           + '/* run the command */'+x'25'
           + 'RC="CPF????"'+x'25'
           + 'line'+x'25'
           + 'if RC <> 0'+x'25'
           + 'then do'+x'25'
           + '  say "             </chop><error>"||RC||"</error>"'+x'25'
           + '  exit'+x'25'
           + 'end'+x'25'
           + '/* output to QTEMP/OUTREXX */'+x'25'
           + 'if V.cnt > 0'+x'25'
           + 'then do'+x'25'
           + '  do i = 1 to V.cnt'+x'25'
           + '    ret = keyparm(line,i,V.i)'+x'25'
           + '  end'+x'25'
           + 'end'+x'25'
           + 'else do'+x'25'
           + '  say "             </chop>"'+x'25'
           + 'end'+x'25'
           + 'exit'+x'25'
           + 'keyparm:'+x'25'
           + '  parse arg line,idx,data'+x'25'
           + '  /* "&V" */'+x'25'
           + '  vname = "(&V."||idx'+x'25'
           + '  name = "nada"'+x'25'
           + '  /* icmd parm1(&V.1) parm2(&V.2) */'+x'25'
           + '  /*                        x     */'+x'25'
           + '  pe = pos(vname,line)'+x'25'
           + '  if pe > 0'+x'25'
           + '  then do'+x'25'
           + '    /* icmd parm1(&V.1) parm2 */'+x'25'
           + '    /*                      x */'+x'25'
           + '    all = strip(left(line,pe-1))'+x'25'
           + '    /* icmd parm1(&V.1) parm2 */'+x'25'
           + '    /*                 x      */'+x'25'
           + '    pe = LastPos(" ",all)'+x'25'
           + '    if pe > 0'+x'25'
           + '    then do'+x'25'
           + '      /* parm2 */'+x'25'
           + '      name = strip(substr(all,pe))'+x'25'
           + '    end'+x'25'
           + '  end'+x'25'
           + '  if name <> "nada"'+x'25'
           + '  then do'+x'25'
           + '    pe = 40'+x'25'
           + '    goop = "            </chop>"'+x'25'
           + '    say goop||"<row></lf>"'+x'25'
           + '    say goop||"<data desc=''"||name||"''>"'+x'25'
           + '    if cdata <> "*OFF"'+x'25'
           + '    then do'+x'25'
           + '      say goop||cdata1'+x'25'
           + '    end'+x'25'
           + '    mydata = strip(data)'+x'25'
           + '    len = length(mydata)'+x'25'
           + '    do while (len > 0)'+x'25'
           + '      out = goop||left(mydata,pe)'+x'25'
           + '      say out'+x'25'
           + '      mydata = substr(mydata,pe+1)'+x'25'
           + '      len = length(mydata)'+x'25'
           + '    end'+x'25'
           + '    if cdata <> "*OFF"'+x'25'
           + '    then do'+x'25'
           + '      say goop||cdata2'+x'25'
           + '    end'+x'25'
           + '    say goop||"</data></lf>"'+x'25'
           + '    say goop||"</row></lf>"'+x'25'
           + '  end'+x'25'
           + 'return 0'+x'25'
           + 'keysub:'+x'25'
           + '  parse arg string'+x'25'
           + '  V.cnt = 0'+x'25'
           + '  V.dat = ""'+x'25'
           + '  old = "?"'+x'25'
           + '  out= ""'+x'25'
           + '  new = "&V."'+x'25'
           + '  i = 0'+x'25'
           + '  DO WHILE POS(old,string) > 0'+x'25'
           + '    PARSE VAR string prepart (old) string'+x'25'
           + '    i = i + 1'+x'25'
           + '    V.cnt = i'+x'25'
           + '    aleft = left(string,1)'+x'25'
           + '    V.i = " "'+x'25'
           + '    if aleft <> ")"'+x'25'
           + '    then do'+x'25'
           + '      V.i = 0'+x'25'
           + '      string = substr(string,2)'+x'25'
           + '    end'+x'25'
           + '    else do'+x'25'
           + '      do h = 1 to 4096'+x'25'
           + '        V.i = V.i||" "'+x'25'
           + '      end'+x'25'
           + '    end'+x'25'
           + '    out=out||prepart||new||i'+x'25'
           + '  END'+x'25'
           + '  V.dat = out||string'+x'25'
           + 'return V'+x'25';
         pData = %addr(myData);
         pSize = %len(%trim(myData));
         // ADC fix ccsid (1.6.6)
         rcb = ileWrtf(pData:pSize:
           '/qsys.lib/QTEMP.lib/xmlrexx.file/how.mbr');
         rc = fputSRC(pData:fd);
         rc1 = closeSRC(fd);
         sRexxOpen = *OFF;
         sRexxRdy = *ON;
       endif;

       // -------------
       // execute command
       if setCDATA = *ON;  // ADC (1.6.2)
         myCData = myCDataON 
                 + myCDATABEG + cCDATA1 
                 + myCDATAEND + cCDATA2
                 + myCDATAFIN;
       else;
         myCData = myCDataOFF 
                 + myCDATABEG + cCDATA1
                 + myCDATAEND + cCDATA2
                 + myCDATAFIN;
       endif;
       myCmd = %str(cmd:len);
       // rcb = toUpperSafe(%addr(myCmd):len);
       cmdstr = 'STRREXPRC SRCMBR(HOW) SRCFILE(QTEMP/XMLREXX)' 
              + ' PARM('
              + ''''
              + %trim(myCmd)
              + %trim(myCData)
              + ''''
              + ')';
       cmdlen = %len(%trim(cmdstr));
       rcb = ileSystem(cmdp:cmdlen);
       if rcb = *OFF;
         return *OFF;
       endif;

       // -------------
       // read output
       fd = openSRC('QTEMP/OUTREXX(OUTREXX)':'r');
       if fd = *NULL;
         ileSetSts(ileErrno():*BLANKS);
         return *OFF;
       endif;
       sROutOpen = *ON;
       pData = %addr(myData);
       pSize = 65000;
       result = %addr(datastr);
       dow result <> *NULL;                    
         result = fgetSRC(pData:pSize:fd);
         if result <> *NULL;
           // </chop> ... [</lf>]x'00'
           //        x   x
           rlen = strlen(pData);
           pChop = bigScan(pData:chop:pData+rlen);
           pAddLF = bigScan(pData:addlf:pData+rlen);
           pData2 = pChop + 7;
           if pAddLF <> *NULL;
             pSize2 = strlen(pData2) - 6;
           else;
             pSize2 = strlen(pData2) - 1;
           endif;
           if pSize2 > 0;
             if pAddLF <> *NULL;
               // </chop> ... </lf>x'00'
               //        ooooo
               datastr = %trim(datastr) 
                       + %str(pData2:pSize2)+x'25';
              else;
                // </chop> ... x'00' (no </lf>)
                //        ooooo
                datastr = %trim(datastr) 
                        + %str(pData2:pSize2);
              endif;
           endif;
         endif;
       enddo;
       rc1 = closeSRC(fd);
       sROutOpen = *OFF;


       // -------------
       // <error>CPFxxxx</error>
       //               x
       pos = %scan(search:datastr);
       if pos > 0;
         // <error>CPFxxxx</error>
         //        x      x
         pData = %addr(datastr)+7;
         ileSetSts(0:%str(pData:pos-7));
         datastr = *BLANKS;
         rcb = *OFF;
       endif;

       // -------------
       // error
       On-error;
         ileSetSts();
         rcb = *OFF;
       Endmon;

       if sROutOpen = *ON or sRexxOpen = *ON;
         rc1 = closeSRC(fd);
         sROutOpen = *OFF;
         sRexxOpen = *OFF;
       endif;

       return rcb;
      /end-free
     P                 E

      *****************************************************
      * big trim
      * return addr
      *****************************************************
     P bigTrim         B                   export
     D bigTrim         PI            20U 0
     D   start                         *   value
     D   len                         20U 0 value
      * vars
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D meover_t        DS                  qualified based(Template)
     D  mepage                     4096a
     D  me01                          1a   dim(4096) overlay(mepage)
     D xml             ds                  likeds(meover_t) based(pCopy)
     D i               s             20U 0 inz(0)
      /free
       if len < 4097;
         pCopy = start;
         dow len > 0;
           if xml.me01(len) <> *BLANKS 
           and xml.me01(len) <> x'00';
             leave;
           endif;
           len -= 1;
         enddo;
       else;
         dow len > 0;
           pCopy = start + (len-1);
           if myCopy.bytex <> *BLANKS 
           and myCopy.bytex <> x'00';
             leave;
           endif;
           len -= 1;
         enddo;
       endif;
       return len;
      /end-free
     P                 E

      *****************************************************
      * where = bigScan
      * return (!*NULL=good; *NULL=bad)
      *****************************************************
     P bigScan         B                   export
     D bigScan         PI              *
     D  pTop                           *   value
     D  search                       20A   value
     D  pBottom                        *   value
     D  oneChar                       1N   value options(*nopass)
      * vars
     D pLook           s               *   inz(*NULL)
     D myLook          ds                  likeds(over_t) based(pLook)
     D pTop1           s               *   inz(*NULL)
     D myTop1          ds                  likeds(over_t) based(pTop1)
     D pBot1           s               *   inz(*NULL)
     D myBot1          ds                  likeds(over_t) based(pBot1)
     D where           s               *   inz(*NULL)
     D saveLast        s              1a   inz(*BLANKS)
      /free
       if pTop = *NULL 
       or pBottom = *NULL
       or pBottom < pTop;
         return *NULL;
       endif;

       if %parms >= 4 and oneChar = *ON;
         pLook = %addr(search);
         pTop1 = pTop;
         if myLook.bytex = myTop1.bytex;
           return pTop;
         endif;
         search00 = myLook.bytex + x'00';
       else;
         search00 = %trim(search) + x'00';
       endif;

       // null bottom
       pBot1 = pBottom;
       saveLast = myBot1.bytex;
       myBot1.bytex = x'00';

       // find string to NULL
       where = strstr(pTop:pLook00);

       // restore bottom
       myBot1.bytex = saveLast;

       return where;
      /end-free
     P                 E

      *****************************************************
      * where = bigJunkOut
      * return 
      *****************************************************
     P bigJunkOut      B                   export
     D bigJunkOut      PI
     D  pTop                           *   value
     D  pBottom                        *   value
     D  rmCDATA                       1N   value
     D  rmLF                          1N   value options(*nopass)
     D  rmQuote                       1N   value options(*nopass)
      * vars
     d totLen          s             10i 0 inz(0)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
     D pTop1           s               *   inz(*NULL)
     D myTop1          ds                  likeds(over_t) based(pTop1)
     D pBot1           s               *   inz(*NULL)
     D myBot1          ds                  likeds(over_t) based(pBot1)
     d doRmLF          s              1N   inz(*OFF)
     d doRmQuote       s              1N   inz(*OFF)
      /free
       if %parms >= 4;
         doRmLF = rmLF;
       endif;
       if %parms >= 5;
         doRmQuote = rmQuote;
       endif;

       // nothing to do 
       if pTop = *NULL 
       or pBottom = *NULL
       or pBottom < pTop;
         return;
       endif;

       perfAdd(PERF_ANY_WATCH_BIGJUNK:*ON);

       // null last byte bottom
       pBot1 = pBottom;
       myBot1.bytex = x'00';

       // null term - x'00' to x'40'
       pTop1 = pTop;
       totLen = 1;
       dow pTop1 < pBottom and totLen > 0;
         if pTop1 > pTop;
           myTop1.bytex = x'40';
         endif;
         totLen = strlen(pTop);
         pTop1 = pTop + totLen;
       enddo;
       
       // single quote to double
       if doRmQuote = *ON;
         pTop1 = strchr(pTop:x'7D');
         dow pTop1 <> *NULL;
           myTop1.bytex = x'7F';
           pTop1 = strchr(pTop:x'7D');
         enddo;
       endif;
       
       // LF - x'25' to x'40'
       if doRmLF = *ON;
         pTop1 = strchr(pTop:x'25');
         dow pTop1 <> *NULL;
           myTop1.bytex = x'40';
           pTop1 = strchr(pTop:x'25');
         enddo;
       endif;


       // remove search values
       if rmCDATA = *ON;
         cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
         cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)
         // <![CDATA[...]]>
         // xxxxxxxxx
         pTop1 = pTop;
         dow pTop1 <> *NULL and pTop1 < pBottom;
           pTop1 = bigScan(pTop1:cCDATA1:pBottom);
           if pTop1 <> *NULL;
             myTop1.char9 = *BLANKS;
             pTop1 += 1;
           endif;
         enddo;
         // <![CDATA[...]]>
         //             xxx
         pTop1 = pTop;
         dow pTop1 <> *NULL and pTop1 < pBottom;
           pTop1 = bigScan(pTop1:cCDATA2:pBottom);
           if pTop1 <> *NULL;
             myTop1.char3 = *BLANKS;
             pTop1 += 1;
           endif;
         enddo;
       endif;

       // destroy last byte bottom
       pBot1 = pBottom;
       myBot1.bytex = x'40';

       perfAdd(PERF_ANY_WATCH_BIGJUNK:*OFF);

      /end-free
     P                 E

      *****************************************************
      * get all occur
      * return (nbr pvalues returned)
      *****************************************************
     P bigOptAll       B                   export
     D bigOptAll       PI            10i 0
     D  pTop                           *   value
     D  pBottom                        *   value
     D  search                       20A   value
     D  pValue                         *   dim(XMLMAXATTR)
      * vars
     D i               s             10i 0 inz(0)
     D p               s               *   inz(*NULL)
      /free
       if pTop = *NULL 
       or pBottom = *NULL 
       or search = *BLANKS
       or pBottom < pTop;
         return 0;
       endif;

       //  find all instances
       p = pTop;
       // *key(zz/z/zzz/z/ ...)
       //     x
       pValue(1) = p;
       for i = 2 to XMLMAXATTR;
         // *key(zz/z/zzz/z/ ...)
         //        x x   x x
         p = bigScan(p:search:pBottom);
         if p = *NULL;
           i -= 1;
           leave;
         endif;
         pValue(i) = p;
         p+=1;
         if p >= pBottom;
           leave;
         endif;
       endfor;
       // *key(zz/z/zzz/z/ ...)
       //                     x
       if i < XMLMAXATTR;
         i += 1;
         pValue(i) = pBottom;
       endif;

       // *key(zz/z/zzz/z/ ...)
       //     x  x x   x x    x
       return i;
      /end-free
     P                 E

      *****************************************************
      * get attributes
      * return (*ON=yes, *OFF=no)
      *****************************************************
     P bigDimAttr      B                   export
     D bigDimAttr      PI             1N
     D  pTop                           *   value
     D  pBottom                        *   value
     D  search                       20A   dim(XMLMAXATTR)
     D  pName                          *   dim(XMLMAXATTR)
     D  pValue                         *   dim(XMLMAXATTR)
     D  valueLen                     10i 0 dim(XMLMAXATTR)
      * vars
     D rc              s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
     D j               s             10i 0 inz(0)
     D c               s             10i 0 inz(0)
     D p               s               *   inz(*NULL)
     D q1              s               *   inz(*NULL)
     D q2              s               *   inz(*NULL)
     D label           s             20A   inz(*BLANKS)
      /free
       if pTop = *NULL or pBottom = *NULL;
         return *OFF;
       endif;

       perfAdd(PERF_ANY_WATCH_BIGDIM:*ON);

       // <xxx name_1='value_1' ... name_n='value_n'>
       //      x                    x
       for i = 1 to XMLMAXATTR;
         if search(i) = *BLANKS;
           leave;
         endif;
         for j = 1 to 2;
           // <xxx name_1='value_1' ... name_n='value_n'>
           //      x
           select;
           when j=1;
             label = %trim(search(i)) + '='''; // name='value'
           when j=2;
             label = %trim(search(i)) + '="';  // name="value"
           // other?
           other;
           endsl;
           p = bigScan(pTop:label:pBottom:*OFF);    // find name='
           q1 = *NULL;
           q2 = *NULL;
           if p <> *NULL;
             q1 = p + %len(%trim(label));
             select;
             when j=1;                         // 'value'
               q2 = bigScan(q1:'''':pBottom);  // ADC was q1+1 (1.6.8)
               leave;
             when j=2;                         // "value"
               q2 = bigScan(q1:'"':pBottom);   // ADC was q1+1 (1.6.8)
               leave;
             // other?
             other;
             endsl;
           endif;
         endfor;
         // full attribute ... name='value'
         if p <> *NULL and q1 <> *NULL and q2 <> *NULL;
           pName(i) = p;
           pValue(i) = q1;
           valueLen(i) = q2 - q1;
           rc = *ON;
         endif;
       endfor;

       perfAdd(PERF_ANY_WATCH_BIGDIM:*OFF);

       return rc;
      /end-free
     P                 E


      *****************************************************
      * rc = bigDimOpt()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P bigDimOpt       B                   export
     D bigDimOpt       PI             1N
     D   pSearch                   1024A   value
     D   doCtl                     1024A
     D   doChar                      64A   dim(XMLMAXATTR)
     D   doNbr                       10i 0 dim(XMLMAXATTR)
      * vars
     D pPtr            S               *   inz(*NULL)
     D pTop            S               *   inz(*NULL)
     D pLst            S               *   inz(*NULL)
     D pBeg            S               *   inz(*NULL)
     D pEnd            S               *   inz(*NULL)
     D pValue          S               *   dim(XMLMAXATTR) inz(*NULL)
     D search          S             20A   inz(*BLANKS)
     D rc              S              1N   inz(*OFF)
     D i               S             10i 0 inz(0)
     D nbr             S             10i 0 inz(0)
     D len             S             10i 0 inz(0)
      /free
       perfAdd(PERF_ANY_WATCH_BIGDIMOPT:*ON);
       // all unset
       for i = 1 to XMLMAXATTR;
         doChar(i) = *BLANKS;
         doNbr(i)  = -42;
       endfor;

       // *goop *key(zz/z/zzz/z/ ...) *next(zz/z/zzz/z/ ...)
       // x     x                                          x
       pTop = %addr(doCtl);
       pLst = pTop + 1023;
       pBeg = bigScan(pTop:%trim(pSearch):pLst);
       if pBeg = *NULL;
         perfAdd(PERF_ANY_WATCH_BIGDIMOPT:*OFF);
         return *OFF;
       endif;

       // *key(zz/z/zzz/z/ ...) *next(zz/z/zzz/z/ ...)
       // x                     x
       pTop = pBeg;
       pEnd = bigScan(pBeg+1:'*':pLst:*ON);
       if pEnd <> *NULL;
         pLst = pEnd;
       endif;

       // *key(zz/z/zzz/z/ ...)  *next(zz/z/zzz/z/ ...)
       //     x               x
       pBeg = bigScan(pTop:'(':pLst:*ON);
       pEnd = bigScan(pTop:')':pLst:*ON);
       if pBeg = *NULL
       or pEnd = *NULL
       or pEnd < pBeg 
       or pBeg > pLst;
         perfAdd(PERF_ANY_WATCH_BIGDIMOPT:*OFF);
         return *ON;
       endif;

       // *key(zz/z/zzz/z/ ...)
       //     x  x x   x x    x
       search = '/';
       nbr = bigOptAll(pBeg:pEnd:search:pValue);
       for i = 1 to nbr - 1;
         Monitor;
           pPtr = pValue(i) + 1;
           len  = pValue(i+1) - pPtr;
           if len > 0;
             doChar(i) = %str(pPtr:len);
             rc = isDigit(pPtr:len);
             if rc = *ON;
               doNbr(i)  = %INT(%str(pPtr:len));
             endif;
           endif;
         On-error;
             doNbr(i)  = -42;
         Endmon;
       endfor;

       perfAdd(PERF_ANY_WATCH_BIGDIMOPT:*OFF);
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * xml DATA or CDATA or Goop
      * return (*ON=yes, *OFF=no)
      * Notes:
      * Variant EBCDIC characters !#$@\[]^`{}|~
      * <![CDATA[...]]>
      *  vv     v   vv
      *   37  1047 838 870 1025 1141 1142 1143 1144 1145 1146 1147 1148
      * < 4c
      * ! 5a       4f                           bb
      * [ ba  ad   49  4a       63   9e   b5    90  4a   b1
      * ] bb  bd   59  5a       fc   9f         51            b5
      * > 6e
      *****************************************************
     P bigCDATA        B                   export
     D bigCDATA        PI             1N
     D   pTop                          *   value
     D   pLst                          *   value
     D   pC1                           *
     D   pC2                           *
      * vars
     D rc              s              1N   inz(*OFF)
     D pCbeg           s               *   inz(*NULL)
     D pCend           s               *   inz(*NULL)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D cCDATA2         S              3A   inz(*BLANKS) 
      /free
       // <![CDATA[...]]>
       // x  x
       pCopy = pTop + 3;
       if myCopy.char5 = 'CDATA';
         // <![CDATA[...]]>
         // x        y
         pCbeg = pTop + 9;
         // <![CDATA[...]]></data>
         //             x

         // new design (ADC 1.6.7)
         cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)
         if pCend = *NULL;
           pCend = bigScan(pCbeg:cCDATA2:pLst+1);
         endif;

         // *** take out original design (ADC 1.6.7)
         if pCend = *NULL;
           if pCend = *NULL;
             pCend = bigScan(pCbeg:x'bbbb6e':pLst+1);
           endif;
           if pCend = *NULL;
             pCend = bigScan(pCbeg:x'bdbd6e':pLst+1);
           endif;
           if pCend = *NULL;
             pCend = bigScan(pCbeg:x'59596e':pLst+1);
           endif;
           if pCend = *NULL;
             pCend = bigScan(pCbeg:x'5a5a6e':pLst+1);
           endif;
           if pCend = *NULL;
             pCend = bigScan(pCbeg:x'fcfc6e':pLst+1);
           endif;
           if pCend = *NULL;
             pCend = bigScan(pCbeg:x'9f9f6e':pLst+1);
           endif;
           if pCend = *NULL;
             pCend = bigScan(pCbeg:x'51516e':pLst+1);
           endif;
           if pCend = *NULL;
             pCend = bigScan(pCbeg:x'b5b56e':pLst+1);
           endif;
         endif;
         // *** take out original design (ADC 1.6.7)

         if pCend <> *NULL;
           // <![CDATA[...]]></data>
           //            yx
           pCend -= 1;
         endif;
       endif;
       // *** not CDATA
       if pCbeg = *NULL and pCend = *NULL;
         pC1 = pTop;
         pC2 = pLst;
         rc  = *OFF;
       // *** is CDATA
       else;
         pC1 = pCbeg;
         pC2 = pCend;
         rc  = *ON;
       endif;
       xmlSetCDATA(rc); // XML CDATA
       return rc;
      /end-free
     P                 E

      *****************************************************
      * where = lilAssist
      * return (0=good; !0=bad)
      *****************************************************
     P lilAssist       B                   export
     D lilAssist       PI             1A
     D  pCopy                          *
     D  find                          1N
     D  j                            10i 0
     D  len                          10i 0 value
     D  search                       18A   value
      * vars
     D k               s             10i 0 inz(0)
     D l               s             10i 0 inz(0)
     D meover_t        DS                  qualified based(Template)
     D  mepage                     4096a
     D  me01                          1a   dim(4096) overlay(mepage)
     D  me02                          2a   overlay(mepage)
     D  me03                          3a   overlay(mepage)
     D  me04                          4a   overlay(mepage)
     D  me05                          5a   overlay(mepage)
     D  me06                          6a   overlay(mepage)
     D  me07                          7a   overlay(mepage)
     D  me08                          8a   overlay(mepage)
     D  me09                          9a   overlay(mepage)
     D  me10                         10a   overlay(mepage)
     D  me11                         11a   overlay(mepage)
     D  me12                         12a   overlay(mepage)
     D  me13                         13a   overlay(mepage)
     D  me14                         14a   overlay(mepage)
     D  me15                         15a   overlay(mepage)
     D  me16                         16a   overlay(mepage)
     D  me17                         17a   overlay(mepage)
     D  me18                         18a   overlay(mepage)
     D xml             ds                  likeds(meover_t) based(pCopy)
     D pCopy2          s               *   inz(*NULL)
     D xml2            ds                  likeds(meover_t) based(pCopy2)
      /free
      
       if len > 0;
         //
         //         44     4  4
         //         00     0  0
         //         89     9  9
         // 1234567890123456123
         //          mydatamabo
         //          j     x  l
         if j + len > %size(xml);
           pCopy += (j-1);
           j = 1;
         endif;
         //
         //          0
         //          0
         //          0
         // xxxxxxxxx123456123
         //          mydatamabo
         //          jxxxxxxxxx
         find = *ON;
         pCopy2 = %addr(search);
         for k = 1 to len;
           l = j + k - 1;
           if xml.me01(l) <> xml2.me01(k);
             find = *OFF;
             leave;
           endif;
         endfor;
       else;
         //
         //                40
         //                00
         //                90
         // 1234567890123456123
         //          mydatamabo
         //                 j
         j += 1;
         if j > %size(xml);
           pCopy += %size(xml);
           j = 1;
         endif;
       endif;
       
       // return character
       return xml.me01(j);
      /end-free
     P                 E
     
     
      *****************************************************
      * where = bigAssist
      * return (0=good; !0=bad)
      *****************************************************
     P bigAssist       B                   export
     D bigAssist       PI            10i 0
     D  pTop                           *   value
     D  pBottom                        *   value
     D  search                       18A   dim(XMLMAXATTR)
     D  doFind                       10i 0 dim(XMLMAXATTR)
      * vars
     D pCopy           s               *   inz(*NULL)
     D pCopyBug        s               *   inz(*NULL)
     D c               s              1A   inz(' ')
     D d               s              1A   inz(' ')
     D i               s             10i 0 inz(0)
     D j               s             10i 0 inz(0)
     D k               s             10i 0 inz(0)
     D kcount          s             10i 0 inz(0)
     D where           s             10i 0 inz(0)
     D find            s              1N   inz(*OFF)
     D len             s             10i 0 inz(0) dim(XMLMAXATTR)
     D xmllen          s             10i 0 inz(0)
     D count           s             10i 0 inz(-1)
     D isknow          s             10i 0 inz(0)
     D deadzone        s             10i 0 inz(0)
     D dat1            s             10i 0 inz(0)
     D dat2            s             10i 0 inz(0)
     D beg1            s             10i 0 inz(0)
     D beg2            s             10i 0 inz(0)
     D beg3            s             10i 0 inz(0)
     D begs            s             10i 0 inz(0)
     D begok           s             10i 0 inz(1)
     D beg             s             10i 0 inz(0)
     D beglen          s             10i 0 inz(-1)
     D end1            s             10i 0 inz(0)
     D end2            s             10i 0 inz(0)
     D end3            s             10i 0 inz(0)
     D ends            s             10i 0 inz(0)
     D endok           s             10i 0 inz(1)
     D end             s             10i 0 inz(0)
     D endlen          s             10i 0 inz(-1)
     D nextbeg         s             10i 0 inz(0)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
     D aDoNada         S              1N   inz(*OFF)
     D aDoCDATA        S              1N   inz(*OFF)
     D aKeyElem        S             10i 0 inz(1)
     D aFindElem       S             10i 0 inz(1)
     D pCDATA          s               *   inz(*NULL)
     D myCDATA         ds                  likeds(over_t) based(pCDATA)
      /free
       cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
       cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)
       
       // movable pointer structure
       pCopy = pTop;
       xmllen = pBottom - pTop;
       for k = 1 to XMLMAXATTR;
         if search(k) <> *BLANKS;
           len(k) = %len(%trim(search(k)));
           kcount += 1;
         else;
           leave;
         endif;
       endfor;
       
       for i = 0 to xmllen;
       
        // get next single character
        c = lilAssist(pCopy:find:j:0:search(1));
        pCopyBug = pTop + i;

        // save a record
        nextbeg = 0;
        if beg3 > 0 or end3 > 0;
          // start beg <node ...  >
          //           xx
          if beg3 > 0;
            if begs > 0;
              aDoNada = *ON;
              dat2 = beg2 - 1;
              end1 = beg2;
              end2 = beg2;
            else;
              aDoNada = *OFF;
            endif;
            aDoCDATA = xmlGetCDATA();
            // <data><![CDATA[data]]></data> (1.8.1)
            //       ---------
            if dat1 > 0;
              pCDATA = pTop + dat1;
              if myCDATA.char9 = cCDATA1;
                dat1 += 9;
                aDoCDATA = *ON;
              endif;
            endif;
            nextbeg = beg3;
            begok = 0;
            aFindElem = doFind(aKeyElem);
            where = cacAddXML(pTop
                   :pTop + beg1
                   :pTop + beg1
                   :pTop + beg2
                   :pTop + dat1
                   :pTop + dat2
                   :pTop + end1
                   :pTop + end2
                   :pTop + nextbeg
                   :aDoNada
                   :aDoCDATA
                   :aFindElem
                   :aKeyElem
                   :*OFF);
            if where = 0;
              count = cacFixXML();
              return count;
            endif;
            count += 1;
          // start end </node>
          //           xx
          else;
            where = cacGetXML(aKeyElem);
            nextbeg = end3;
            endok = 0;
            // <data><![CDATA[data]]></data> (1.8.1)
            //                    ---
            if dat2 > 0;
              pCDATA = pTop + dat2 - 2;
              if myCDATA.char3 = cCDATA2;
                dat2 -= 3;
              endif;
            endif;
            cacUpdXML(where
                   :pTop
                   :pTop + dat2
                   :pTop + end1
                   :pTop + end2
                   :pTop + nextbeg);
          endif;
        endif;
        
        // re-init everything on error/miss 
        if begok < 1 or endok < 1;
          deadzone=0;
          dat1=0;
          dat2=0;
          beg1=0;
          beg2=0;
          beg3=0;
          begs=0;
          begok=1;
          beg=0;
          beglen=-1;
          end1=0;
          end2=0;
          end3=0;
          ends=0;
          endok=1;
          end=0;
          endlen=-1;
          // next one
          if nextbeg > 0;
            beg1 = nextbeg;
          endif;
          nextbeg=0;
          isknow=0;
        endif;
  
        // deadzone <![CDATA[ ... deadzone ... ]]> 
        //          xxxxxxxxx
        if deadzone < 1;
          d = lilAssist(pCopy:find:j:9:cCDATA1);
          if find = *ON;
            deadzone = i;
            dat1 = i;
          endif;
        // deadzone <![CDATA[ ... deadzone ... ]]> 
        //                                     xxx
        else;
          d = lilAssist(pCopy:find:j:3:cCDATA2);
          if find = *ON;
            deadzone = 0;
          endif;
        endif;
        if deadzone > 1;
          iter;
        endif;
        
        // start beg <node ...  >
        //           xx
        // - or --
        // start end </node>
        //           xx
        if isknow < 1;
          if c = '<';
            beg1 = i;
          elseif beg1 > 0 and beg1+1 = i;
            if c = '/';
              end1 = beg1;
              beg1 = 0;
            endif;
            isknow = 1;
          endif;
        endif;
        if isknow < 1;
          iter;
        endif;

        // beg1 xml <node ...  >
        //          xxxxx      x
        //          <node ... />
        //          xxxxx     xx
        if beg1 > 0 and beg3 < 1;
          select;
          when c = '<';
            if beg3 < 1;
              beg3 = i;
            endif;
          when c = '/';
            if beg1 > 0 and beg > 0 and beg2 < 1;
              begs = i;
              iter;
            endif;
          when c = '>';
            if beg1 > 0 and beg2 < 1;
              if beg > 0;
                beg2 = i;
                if dat1 < 1;
                  dat1 = beg2 + 1;
                endif;
                if begs > 0 and begs+1 <> beg2;
                  begs = 0;
                endif;
              else;
                begok = 0;
              endif;
              iter;
            endif;
          other;
            // find start <node ...> 
            //            b+
            if beg1 > 0 and beg1+1 = i and beg < 1;
              for k = 1 to kcount;
                d = lilAssist(pCopy:find:j:len(k):search(k));
                if find = *ON;
                  beg = beg1; // bingo found it
                  begok = 1;
                  aKeyElem = k;
                  leave;
                else;
                  begok = 0;
                endif;
              endfor;
            endif;
          endsl;
          if beg3 < 1;
            iter;
          endif;
        endif;        

        // end1 xml </node>
        //          xxxxxxx
        if end1 > 0 and end3 < 1;
          select;
          when c = '<';
            if end3 < 1;
              end3 = i;
            endif;
          when c = '/';
            if end1 > 0 and end2 < 1 and ends < 1;
              ends = i;
              iter;
            endif;
          when c = '>';
            if end1 > 0 and end2 < 1;
              if end > 0;
                end2 = i;
                if dat2 < 1;
                  dat2 = end1 - 1;
                endif;
              else;
                endok = 0;
              endif;
              iter;
            endif;
          other;
            // find end </node>
            //           s+
            if end1 > 0 and ends+1 = i and end < 1;
              for k = 1 to kcount;
                d = lilAssist(pCopy:find:j:len(k):search(k));
                if find = *ON;
                  endok = 1;
                  end = end1; // bingo found it
                  aKeyElem = k;
                  leave;
                else;
                  endok = 0;
                endif;
              endfor;
            endif;
          endsl;
          if end3 < 1; 
            iter;
          endif;
        endif; 

       endfor; // end loop
        
       count = cacFixXML();
       return count;
      /end-free
     P                 E

      *****************************************************
      * where = bigElem
      * return (!*NULL=good; *NULL=bad)
      *****************************************************
     P bigElem         B                   export
     D bigElem         PI            10i 0
     D  pTop                           *   value
     D  pBottom                        *   value
     D  search                       18A   dim(XMLMAXATTR)
     D  doNest                        1N   dim(XMLMAXATTR)
     D  isNada                        1N
     D  isCDATA                       1N
     D  aElemTop1                      *
     D  aElemTop2                      *
     D  aDataVal1                      *
     D  aDataVal2                      *
     D  aElemEnd1                      *
     D  aElemEnd2                      *
     D  aElemNext                      *
      * vars
     D i               s             10i 0 inz(0)
     D j               s             10i 0 inz(0)
     D isIgnore        s              1N   inz(*OFF)
     D aTop            s               *   inz(*NULL)
     D aBot            s               *   inz(*NULL)
     D aBeg            s               *   inz(*NULL)
     D aEnd            s               *   inz(*NULL)
     D aNxt            s               *   inz(*NULL)
     D aLst            s               *   inz(*NULL)
     D aNada           s               *   inz(*NULL)
     D aNest           s               *   inz(*NULL)
     D search1         s             20A   inz(*BLANKS)
     D search2         s             20A   inz(*BLANKS)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D pCopy1          s               *   inz(*NULL)
     D myCopy1         ds                  likeds(over_t) based(pCopy1)
      * cdata
     D tmpCDATA        s              1N   inz(*OFF)
     D pCx1            s               *   inz(*NULL)
     D pCx2            s               *   inz(*NULL)

      /free
       isCDATA   = *OFF;
       isNada    = *OFF;
       aElemTop1 = *NULL;
       aElemTop2 = *NULL;
       aElemNext = *NULL;
       aElemEnd1 = *NULL;
       aElemEnd2 = *NULL;
       aDataVal1 = *NULL;
       aDataVal2 = *NULL;

       if pTop = *NULL or pBottom = *NULL;
         return XMLMAXATTR + 1;
       endif;

       // ----------------
       // past end
       aBot = pBottom + 1;

       // ----------------
       // check error
       // begin element search
       // < ... >
       // x
       aTop = bigScan(pTop:'<':aBot:*ON);
       if aTop <> *NULL;
         aElemTop1 = aTop;
       else;
         return XMLMAXATTR + 1;
       endif;
       // < ... >
       //       x
       aEnd = bigScan(aTop:'>':aBot);
       if aEnd <> *NULL;
         aElemTop2 = aEnd;
         // < ... />
         //       x
         // <? ... ?>
         //        x
         pCopy     = aEnd - 1;
         if myCopy.bytex = '/' or myCopy.bytex = '?';
           isNada = *ON;
           aElemEnd2 = aEnd;
           if myCopy.bytex = '?';
             isIgnore = *ON;
           endif;
         endif;
       else;
         return XMLMAXATTR + 1;
       endif;

       perfAdd(PERF_ANY_WATCH_BIGELEM:*ON);

       // ----------------
       // short value search (no data)
       // <search ... />
       if isNada = *ON;
         // < ... /> ... <
         //              x
         aNxt = bigScan(aEnd:'<':aBot);
         if aNxt <> *NULL;
           aElemNext = aNxt;
         else;
           aElemNext = aEnd + 1;
         endif;
         if myCopy.bytex = '/';
           for i = 1 to XMLMAXATTR;
             // all searched?
             if search(i) = *BLANKS;
               leave;
             endif;
             // <search ... />
             // xxxxxxx
             search1 = '<' + search(i);
             aBeg = bigScan(aTop:search1:aEnd:*OFF);
             if aBeg = aTop;
               if sDoTest > 8 and isIgnore = *OFF;
                 xmlDump('bigElem nada':aElemTop1:aElemTop2:*OFF);
               endif;
               perfAdd(PERF_ANY_WATCH_BIGELEM:*OFF);
               return i;
             endif;
           endfor;
         endif;
         // junk XML to next
         // < ... > ... <
         //             x
         if sDoTest > 8 and isIgnore = *OFF;
           xmlDump('bigElem nada':aElemTop1:aElemTop2:*OFF);
         endif;
         perfAdd(PERF_ANY_WATCH_BIGELEM:*OFF);
         return 0;
       endif;

       // ------------------
       // long value search
       // <search ... > ... </search>
       for i = 1 to XMLMAXATTR;
         // all searched?
         if search(i) = *BLANKS;
           leave;
         endif;
         // <search ... > ... </search>
         // xxxxxxx
         search1 = '<' + search(i);
         aBeg = bigScan(aTop:search1:aEnd:*OFF);
         if aBeg = aTop;

           // <search ... > ... </search>
           //                   xxxxxxxx
           search2 = '</' + search(i);

           // check nested XML element
           if doNest(i) = *ON;
             aNest= aBeg; // save 1st
             aEnd = aBeg; // find </search>
             j = 1;       // 0 means end
             dou aBeg = *NULL or aEnd = *NULL;
               // <search>.<search>?
               // 1111111  xxxxxxx
               aBeg = bigScan(aBeg+1:search1:aBot:*OFF);
               if aBeg <> *NULL;
                 j += 1;
               endif;
               // <search>.<search>.</search>.</search>?
               // 1111111           xxxxxxxx  nnnnnnnn
               aEnd = bigScan(aEnd+1:search2:aBot:*OFF);
               if aEnd <> *NULL;
                 j -= 1;
               endif;
               // found begin <search> was out of scope
               // <search>.<search>.</search>.</search>.<search>?
               // 1111111                     nnnnnnnn  xxxxxxx
               if  aBeg <> *NULL and aEnd <> *NULL 
               and aBeg > aEnd;
                 j -= 1;
               endif;
               if j <= 0;
                 leave;
               endif;
             enddo;
             // <search>.<search>.</search>.</search>
             // xxxxxxx
             aBeg = aNest; // restore 1st

           // check single XML element
           else;
             // <search>...</search>
             //            xxxxxxx
             aEnd = bigScan(aTop:search2:aBot:*OFF);
           endif;

           // ----------------
           // data between keywords
           if aEnd <> *NULL;
             aElemEnd1 = aEnd;
             // <search ... > ... </search>
             //                           x
             aLst = bigScan(aEnd:'>':aBot);
             if aLst <> *NULL;
               aElemEnd2 = aLst;
               // <search ... > ... </search>
               //              xxxxx
               aDataVal1 = aElemTop2 + 1;
               aDataVal2 = aElemEnd1 - 1;

               // check CDATA --- 1.6.2
               // <search ... ><![CDATA[ ... ]]></search>
               //              x
               aNxt = bigScan(aDataVal1:'<':aDataVal2);
               if aNxt <> *NULL;
                 tmpCDATA = bigCDATA(aNxt:aDataVal2:pCx1:pCx2);
                 if tmpCDATA = *ON;
                   aDataVal1 = pCx1;
                   aDataVal2 = pCx2;
                 endif;
               endif;
               // check override CDATA
               isCDATA = xmlGetCDATA();

               // next ...
               // </search> ... <
               //               x
               aNxt = bigScan(aLst:'<':aBot);
               if aNxt <> *NULL;
                 aElemNext = aNxt;
               endif;
               if sDoTest > 8;
                 xmlDump('bigElem data':aElemTop1:aElemEnd2:*OFF);
               endif;
               perfAdd(PERF_ANY_WATCH_BIGELEM:*OFF);
               return i;
             endif;
           endif;
           aElemEnd2 = pBottom;
           if sDoTest > 8;
             xmlDump('bigElem badd':aElemTop1:aElemEnd2:*OFF);
           endif;
           perfAdd(PERF_ANY_WATCH_BIGELEM:*OFF);
           return -1;
         endif;
       endfor;

       // -------------------
       // XML to next
       // < ... > ... <
       //             x
       aNxt = bigScan(aEnd:'<':aBot);
       if aNxt <> *NULL;
         aElemNext = aNxt;
       else;
         aElemNext = aEnd + 1;
       endif;

       // search failed
       if sDoTest > 8;
         xmlDump('bigElem junk':aElemTop1:aElemNext:*OFF);
       elseif isIgnore = *OFF;
         ileDoTest(*OFF);
       endif;
       perfAdd(PERF_ANY_WATCH_BIGELEM:*OFF);
       return 0;
      /end-free
     P                 E


      *****************************************************
      * xml DATA types 
      * return (*ON=yes, *OFF=no)
      *****************************************************
     P bigValType      B                   export
     D bigValType      PI             1N
     D   string                        *   value
     D   stringLen                   10i 0 value
     D   myAttr                       1A
     D   myDigits                    10i 0
     D   myFrac                      10i 0
      * vars
     d i               s             10i 0 inz(0)
     d rc              s              1N   inz(*OFF)
     d tmpAttr         s              1A   inz(*BLANKS)
     d tmpDigits       s             32A   inz(*BLANKS)
     d tmpFrac         s             32A   inz(*BLANKS)
     D memP            S               *   inz(*NULL)
     D memchar         s              1A   based(memP)
      /free
       // check in cache
       rc = cacScanTyp(%str(string:stringLen)
                      :myAttr:myDigits:myFrac);
       if rc = *ON;
         return *ON;
       endif;

       // do slow wau
       memP = string;
       for i = 1 to stringLen;
         select;
         when memchar = '0' and tmpAttr = *BLANKS;  // tmpDigits
           tmpDigits = %trim(tmpDigits) + '0';
         when memchar = '1' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '1';
         when memchar = '2' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '2';
         when memchar = '3' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '3';
         when memchar = '4' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '4';
         when memchar = '5' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '5';
         when memchar = '6' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '6';
         when memchar = '7' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '7';
         when memchar = '8' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '8';
         when memchar = '9' and tmpAttr = *BLANKS;
           tmpDigits = %trim(tmpDigits) + '9';
         when memchar = '0' and tmpAttr > *BLANKS;  // tmpFrac
           tmpFrac = %trim(tmpFrac) + '0';
         when memchar = '1' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '1';
         when memchar = '2' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '2';
         when memchar = '3' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '3';
         when memchar = '4' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '4';
         when memchar = '5' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '5';
         when memchar = '6' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '6';
         when memchar = '7' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '7';
         when memchar = '8' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '8';
         when memchar = '9' and tmpAttr > *BLANKS;
           tmpFrac = %trim(tmpFrac) + '9';
         when memchar = 'h' or memchar = 'H';       // hole
           tmpAttr = XML_ATTR_VAL_H;
         when memchar = 'b' or memchar = 'B';       // binary
           tmpAttr = XML_ATTR_VAL_B;
         when memchar = 'a' or memchar = 'A';       // char
           tmpAttr = XML_ATTR_VAL_A;
         when memchar = 'i' or memchar = 'I';       // signed
           tmpAttr = XML_ATTR_VAL_I;
         when memchar = 'u' or memchar = 'U';       // unsigned
           tmpAttr = XML_ATTR_VAL_U;
         when memchar = 'p' or memchar = 'P';       // packed
           tmpAttr = XML_ATTR_VAL_P;
         when memchar = 's' or memchar = 'S';       // zoned
           tmpAttr = XML_ATTR_VAL_S;
         when memchar = 'f' or memchar = 'F';       // float
           tmpAttr = memchar;
           if %trim(tmpDigits) < '8';
             tmpAttr = XML_ATTR_VAL_F;
           else;
             tmpAttr = XML_ATTR_VAL_D;
           endif;
         // ???? 
         other;
         endsl;
         // next char
         memP += 1;
       endfor;
       // digits before type "12p2"
       //                     x
       if tmpDigits = *BLANKS;
         myDigits = 0;
       else;
         myDigits = %int(tmpDigits);
       endif;
       // type "12p2"
       //         x
       myAttr = tmpAttr;
       // fractional follow type "12p2"
       //                            x
       if tmpFrac = *BLANKS;
         myFrac = 0;
       else;
         myFrac = %int(tmpFrac);
       endif;

       // save for fast cache
       cacAddTyp(%str(string:stringLen)
                :myAttr:myDigits:myFrac);

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * argv area
      * return size
      *****************************************************
     P ileSzArgv       B                   export
     D ileSzArgv       PI            10i 0
     D   start                         *
      /free
       start = sArgvBegP;
       return sArgvSz;
      /end-free
     P                 E

      *****************************************************
      * parm area
      * return size
      *****************************************************
     P ileSzParm       B                   export
     D ileSzParm       PI            10i 0
     D   start                         *
      /free
       start = sParmBegP;
       return sParmSz;
      /end-free
     P                 E

      *****************************************************
      * return area
      * return size
      *****************************************************
     P ileSzRet        B                   export
     D ileSzRet        PI            10i 0
     D   start                         *
      /free
       start = sRetBegP;
       return sRetSz;
      /end-free
     P                 E

      *****************************************************
      * offset round to quad 
      * return addr
      *****************************************************
     P uintQuad        B                   export
     D uintQuad        PI            20U 0
     D   start                       20U 0 value
      * vars
     D loop            s              1N    inz(*ON)
     D addr            s             20U 0  inz(0)
     D quad            s             20U 0  inz(0)
      /free
       addr = start;
       dow loop = *on;
         quad = %bitand(addr:X'000000000000000F');
         if quad = 0;
           leave;
         endif;
         addr += 1;
       enddo;
       return addr;
      /end-free
     P                 E

      *****************************************************
      * ILE round to quad 
      * return addr
      * note: start is assumed quad align
      *****************************************************
     P ileQuad         B                   export
     D ileQuad         PI              *
     D   start                         *   value
     D   offset                        *   value
      * vars
     D orig            s             20U 0  inz(0)
     D addr            s             20U 0  inz(0)
      /free
       orig = offset - start;
       addr = uintQuad(orig);
       return offset + (addr-orig);
      /end-free
     P                 E

      *****************************************************
      * offset round to align
      * return addr
      *****************************************************
     P uintAlign       B                   export
     D uintAlign       PI            20U 0
     D   start                       20U 0 value
     D   align                       20u 0 value
      * vars
     D loop            s              1N    inz(*ON)
     D addr            s             20U 0  inz(0)
     D bitm            s             20U 0  inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
      /free
       // 1 byte align is no align
       if align < 2;
         return start;
       endif;
       // align 2, 4, 8, 16, etc.
       addr = start;
       dow loop = *on;
         bitm = %bitand(addr:X'000000000000000F');
         if bitm = 0;
           leave;
         endif;
         select;
         when align = 8;
           select;
           when bitm = x'08';
             leave;
           other;
           endsl;
         when align = 4;
           select;
           when bitm = x'04';
             leave;
           when bitm = x'08';
             leave;
           when bitm = x'0C';
             leave;
           other;
           endsl;
         when align = 2;
           select;
           when bitm = x'02';
             leave;
           when bitm = x'04';
             leave;
           when bitm = x'06';
             leave;
           when bitm = x'08';
             leave;
           when bitm = x'0A';
             leave;
           when bitm = x'0C';
             leave;
           when bitm = x'0E';
             leave;
           other;
           endsl;
         other;
         endsl;
         addr += 1;
       enddo;
       return addr;
      /end-free
     P                 E

      *****************************************************
      * ILE round to
      * return addr
      * note: start is assumed quad align
      *****************************************************
     P ileAlign        B                   export
     D ileAlign        PI              *
     D   start                         *   value
     D   offset                        *   value
     D   align                       20u 0 value
      * vars
     D orig            s             20U 0  inz(0)
     D addr            s             20U 0  inz(0)
      /free
       orig = offset - start;
       addr = uintAlign(orig:align);
       return offset + (addr-orig);
      /end-free
     P                 E


      *****************************************************
      * ILE dec size 
      * return (*ON=good, *OFF=error)
      *****************************************************
     P ileDecSize      B
     D ileDecSize      PI            10i 0
     D   nbr                         10i 0 value
     D   zone                         1N   value
      * vars
     D declen          s             10i 0  inz(0)
     D l               s             10i 0  inz(0)
      /free
       if zone;
         declen = nbr;
       else;
         l = nbr;
         if %REM(l:2)=0;
           l += 1;
         endif;
         select;
         when l = 3;
           declen = 2;
         when l = 2;
           declen = 2;
         when l = 1;
           declen = 1;
         other;
           declen=%DIV((l+1):2); 
         endsl;
       endif;
       return declen;
      /end-free
     P                 E

      *****************************************************
      * ILE current position
      * return (*ON=good, *OFF=error)
      *****************************************************
      * top level parm ptr (or val) like
      * most all parms are pass by ref (ptr),
      * but by value can be specified for
      * *SRVPGMs in RPG (and ILE c compiler)
      * note: 
      * pass by value a copy out (pop)
      * will just return the original value
      * note:
      * we are not calculating natural alignment (ILE c)
      * because this is really for RPG calls (packed)
      *****************************************************
     P ileCurrent      B
     D ileCurrent      PI             1N
     D   node                              likeds(xmlNode_t)
      * vars
     D inRegister      S              1N   inz(*OFF)
     D argvType        S              1A   inz(XML_BY_MBR)
     D pCopy           s               *   inz(*NULL)
      /free
       // ------------
       // where is return placed?
       if node.xmlPrmRet = XML_IS_RETURN;
           ileCalcRet();
       endif;

       node.pgmSigPo = sSigP - sSigBegP;  // current signature location (was sSigP)
       node.pgmSigSz = 2;                 // signature size
       node.pgmArgPo = sArgvP - sArgvBegP;// current argv location (was sArgvP)
       node.pgmArgSz = 0;                 // no size pointer
       node.pgmValPo = sParmBegP - sParmP;// current parm location (was sParmP)
       node.pgmValSz = 0;                 // no size value
       if sRetBegP = *NULL;
         node.pgmRetPo = 0;               // current return location (was sParmP)
       else;
         node.pgmRetPo = sRetBegP - sParmP;// current return location (was sParmP)
       endif;
       node.pgmRetSz = 0;                 // no size value

       // ------------
       // by reference or by value
       if node.xmlPrmRet = XML_IS_PARM;
         // ------------
         // by reference (PGM or SRVPGM top)
         if node.xmlBy = XML_BY_REF 
         and node.pgmArgTop = XML_PGM_TOP_TRUE;
           argvType = XML_BY_REF;
         // ------------
         // by value (SRVPGM only)
         elseif node.xmlBy = XML_BY_VAL
         and node.xmlCallAs = XML_FUNC_SRVPGM;
           argvType = XML_BY_VAL;
         endif;
       endif;

       // no data default ILE
       if node.xmlAttr = XML_ATTR_VAL_B 
       and node.xmlStrSz < 2;
         node.xmlStrSz = 0;
       endif;
       if node.xmlStrSz < 1;
         select;
         // hole
         when node.xmlAttr = XML_ATTR_VAL_H;
           node.xmlStrP = %addr(sADefault);
           node.xmlStrSz = 1;
         // binary (hex char)
         when node.xmlAttr = XML_ATTR_VAL_B;
           node.xmlStrP = %addr(sBDefault);
           node.xmlStrSz = 2;
         // character
         when node.xmlAttr = XML_ATTR_VAL_A;
           node.xmlStrP = %addr(sADefault);
           node.xmlStrSz = 1;
         // signed int
         when node.xmlAttr = XML_ATTR_VAL_I;
           node.xmlStrP = %addr(sIDefault);
           node.xmlStrSz = 1;
         // unsigned int
         when node.xmlAttr = XML_ATTR_VAL_U;
           node.xmlStrP = %addr(sUDefault);
           node.xmlStrSz = 1;
         // float
         when node.xmlAttr = XML_ATTR_VAL_F;
           node.xmlStrP = %addr(sFDefault);
           node.xmlStrSz = 1;
         // double
         when node.xmlAttr = XML_ATTR_VAL_D;
           node.xmlStrP = %addr(sDDefault);
           node.xmlStrSz = 1;
         // packed decimal
         when node.xmlAttr = XML_ATTR_VAL_P;
           node.xmlStrP = %addr(sPDefault);
           node.xmlStrSz = 1;
         // zoned decimal
         when node.xmlAttr = XML_ATTR_VAL_S;
           node.xmlStrP = %addr(sSDefault);
           node.xmlStrSz = 1;
         // other?
         other;
         endsl;
       endif;


       // data sizes
       select;

       // hole
       when node.xmlAttr = XML_ATTR_VAL_H;
         node.pgmValSz = node.xmlDigits;
         node.pgmRetSz = node.pgmValSz;

       // binary (hex char)
       when node.xmlAttr = XML_ATTR_VAL_B;
         node.pgmValSz = node.xmlDigits;
         node.pgmRetSz = node.pgmValSz;
         inRegister = *ON;

       // character
       when node.xmlAttr = XML_ATTR_VAL_A;
         node.pgmValSz = node.xmlDigits;
         if node.xmlVary = XML_VARY_ON;
           node.pgmValSz += 2;
         elseif node.xmlVary = XML_VARY_4;
           node.pgmValSz += 4;
         endif;
         node.pgmRetSz = node.pgmValSz;

       // signed int
       when node.xmlAttr = XML_ATTR_VAL_I
         or node.xmlAttr = XML_ATTR_VAL_U;
         select;
         when node.xmlDigits <= 3;
           node.pgmValSz = 1;
           if node.xmlAttr = XML_ATTR_VAL_I;
             node.pgmRetSz = RESULT_INT8;
           else;
             node.pgmRetSz = RESULT_UINT8;
           endif;
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           node.pgmValSz = 2;
           if node.xmlAttr = XML_ATTR_VAL_I;
             node.pgmRetSz = RESULT_INT16;
           else;
             node.pgmRetSz = RESULT_UINT16;
           endif;
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           node.pgmValSz = 4;
           if node.xmlAttr = XML_ATTR_VAL_I;
             node.pgmRetSz = RESULT_INT32;
           else;
             node.pgmRetSz = RESULT_UINT32;
           endif;
         when node.xmlDigits > 10;
           node.pgmValSz = 8;
           if node.xmlAttr = XML_ATTR_VAL_I;
             node.pgmRetSz = RESULT_INT64;
           else;
             node.pgmRetSz = RESULT_UINT64;
           endif;
         other;
         endsl;

       // float
       when node.xmlAttr = XML_ATTR_VAL_F;
         node.pgmValSz = 4;
         node.pgmRetSz = RESULT_FLOAT64;

       // double
       when node.xmlAttr = XML_ATTR_VAL_D;
         node.pgmValSz = 8;
         node.pgmRetSz = RESULT_FLOAT64;

       // packed decimal
       when node.xmlAttr = XML_ATTR_VAL_P;
         node.pgmValSz = ileDecSize(node.xmlDigits:*OFF);
         node.pgmRetSz = node.pgmValSz;

       // zoned decimal
       when node.xmlAttr = XML_ATTR_VAL_S;
         node.pgmValSz = ileDecSize(node.xmlDigits:*ON);
         node.pgmRetSz = node.pgmValSz;

       // other?
       other;
         node.pgmValErr = XML_PGM_ERROR_TRUE;
       endsl;

       // -----------
       // may return register, 
       // not memory aggregate
       if inRegister = *ON;
         select;
         when node.pgmRetSz = 1;
           node.pgmRetSz = RESULT_UINT8;
         when node.pgmRetSz > 1 and node.pgmRetSz <= 2;
           node.pgmRetSz = RESULT_UINT16;
         when node.pgmRetSz > 2 and node.pgmRetSz <= 4;
           node.pgmRetSz = RESULT_UINT32;
         when node.pgmRetSz > 4 and node.pgmRetSz <= 8;
           node.pgmRetSz = RESULT_UINT64;
         // other will return as aggregate
         other;
         endsl;
       endif;

       // -----------
       // data assumed not ptr
       node.pgmPtrTyp = XML_PTR_NADA;

       // -----------
       // parm is by reference (pointer)
       if argvType = XML_BY_REF;
         if node.xmlCallAs = XML_FUNC_SRVPGM 
         or sOPM = XML_PGM_OPM_TRUE;
           // req 16-byte aligned for _ILECALL
           pCopy = ileAlign(sOrigP:sArgvP:16);
           node.pgmArgPo = pCopy - sArgvBegP;
           node.pgmArgSz = %size(sArgvP);   // ILE ptr (SRVPGM)
           node.pgmPtrTyp = XML_PTR_ILE;    // write ILE ptr
         else;
           // req 4-byte aligned for _ILECALL
           pCopy = ileAlign(sOrigP:sArgvP:4);
           node.pgmArgPo = pCopy - sArgvBegP;
           node.pgmArgSz = 4;               // PASE ptr32 (PGM)
           node.pgmPtrTyp = XML_PTR_PASE;   // write PASE ptr
         endif;
       // -----------
       // parm is by value
       elseif argvType = XML_BY_VAL;
         node.pgmArgSz = node.pgmValSz;
         // signature _ILECALL only (SRVPGM)
         // only parms (not return value)
         // only top value is "signature"
         if  node.xmlCallAs = XML_FUNC_SRVPGM
         and node.xmlPrmRet = XML_IS_PARM
         and node.pgmArgTop = XML_PGM_TOP_TRUE;
           // -----------
           // data type value alignment
           // must match _ILECALL expected
           select;
           // -----------
           // signed int / unsigned int
           when node.xmlAttr = XML_ATTR_VAL_I
           or   node.xmlAttr = XML_ATTR_VAL_U;
             select;
             when node.xmlDigits <= 3;
               // req 1-byte align (none)
             when node.xmlDigits>3 and node.xmlDigits <= 5;
               // req 2-byte aligned for _ILECALL
               pCopy = ileAlign(sOrigP:sArgvP:2);
               node.pgmArgPo = pCopy - sArgvBegP;
             when node.xmlDigits > 5 and node.xmlDigits <= 10;
               // req 4-byte aligned for _ILECALL
               pCopy = ileAlign(sOrigP:sArgvP:4);
               node.pgmArgPo = pCopy - sArgvBegP;
             when node.xmlDigits > 10;
               // req 8-byte aligned for _ILECALL
               pCopy = ileAlign(sOrigP:sArgvP:8);
               node.pgmArgPo = pCopy - sArgvBegP;
             other;
             endsl;
           // -----------
           // float
           when node.xmlAttr = XML_ATTR_VAL_F;
             // req 4-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:4);
             node.pgmArgPo = pCopy - sArgvBegP;
           // -----------
           // double
           when node.xmlAttr = XML_ATTR_VAL_D;
             // req 8-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:8);
             node.pgmArgPo = pCopy - sArgvBegP;
           // -----------
           // aggregates alignment < 9
           when node.pgmArgSz = 1;
             // req 1-byte aligned for _ILECALL
           when node.pgmArgSz = 2;
             // req 2-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:2);
             node.pgmArgPo = pCopy - sArgvBegP;
           when node.pgmArgSz = 3;
             // req 4-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:4);
             node.pgmArgPo = pCopy - sArgvBegP;
           when node.pgmArgSz = 4;
             // req 4-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:4);
             node.pgmArgPo = pCopy - sArgvBegP;
           when node.pgmArgSz = 5;
             // req 8-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:8);
             node.pgmArgPo = pCopy - sArgvBegP;
           when node.pgmArgSz = 6;
             // req 8-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:8);
             node.pgmArgPo = pCopy - sArgvBegP;
           when node.pgmArgSz = 7;
             // req 8-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:8);
             node.pgmArgPo = pCopy - sArgvBegP;
           when node.pgmArgSz = 8;
             // req 8-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:8);
             node.pgmArgPo = pCopy - sArgvBegP;
           // -----------
           // aggregates alignment > 8
           other;
             // req 16-byte aligned for _ILECALL
             pCopy = ileAlign(sOrigP:sArgvP:16);
             node.pgmArgPo = pCopy - sArgvBegP;
           endsl;
         endif;
       endif;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * ILE next position
      * return (*ON=good, *OFF=error)
      *****************************************************
     P ileNext         B
     D ileNext         PI             1N
     D   node                              likeds(xmlNode_t)
      * vars
     D pCopy           s               *   inz(*NULL)
      /free
       sSigP += node.pgmSigSz;        // new signature location
       sSigSz += node.pgmSigSz;       // size signature location
       sArgvP += node.pgmArgSz;       // new argv location
       // SRVPGM support by value mixed with by ref
       // if this entry was ptr we need quad align
       // next to avoid ileCurrent possible overlay
       // of this ptr with next by value argument
       if  node.xmlCallAs = XML_FUNC_SRVPGM
       and node.xmlPrmRet = XML_IS_PARM
       and node.pgmArgTop = XML_PGM_TOP_TRUE
       and node.pgmPtrTyp = XML_PTR_ILE;
         pCopy = sArgvP;
         sArgvP = ileQuad(sOrigP:sArgvP);
         sArgvSz += (sArgvP - pCopy);
       endif;
       sArgvSz = sArgvP - sArgvBegP;  // size argv location
       if node.xmlPrmRet = XML_IS_PARM;
         sParmP += node.pgmValSz;     // new parm location
         sParmSz += node.pgmValSz;    // size parm location
       else;
         sRetP += node.pgmValSz;      // new return location
         if sRetSz = 0;
           sRetSz = node.pgmRetSz;    // special return size
         endif;
         if sRetAgg = *ON;            // return is aggregate
           sRetSz = sRetP - sRetBegP; // aggregate return size
         endif;
         sRetAgg = *ON;               // 2nd+ implies aggregate
       endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * ILE push data input 
      * return (*ON=good, *OFF=error)
      *****************************************************
     P ilePushData     B                   export
     D ilePushData     PI             1N
     D   node                              likeds(xmlNode_t)
      * vars
     D rc              s              1N   inz(*OFF)
     D rc9             s              1N   inz(*ON)
     D i               s             10i 0 inz(0)
     D pArgv           s               *   inz(*NULL)
     D myArgv          ds                  likeds(over_t) based(pArgv)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D pSig            s               *   inz(*NULL)
     D mySig           ds                  likeds(over_t) based(pSig)
     D str             s             64A   inz(*BLANKS)
     D strSz           s             10i 0 inz(0)
     D strP            s               *   inz(%addr(str))
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D trimSz          s             10i 0 inz(0)
     D convRc          s             10i 0 inz(0)
     d convDigits      s             10i 0 inz(0)
     d convLen         s             10i 0 inz(0)
     D convPad         s             10i 0 inz(0)
     D convVary        s              1A   inz(XML_VARY_OFF)
     D convHex         s              1N   inz(*OFF)
     D cntCCSID        s             10i 0 inz(0)
     D srcCCSID        s             10i 0 dim(XMLMAXATTR) inz(0)
     D tgtCCSID        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free

       Monitor;

       perfAdd(PERF_ANY_WATCH_PUSH:*ON);

       // --------------
       // where are we?
       // (alignment calulated)
       rc = ileCurrent(node);

       // original string
       string = node.xmlStrP;
       stringLen = node.xmlStrSz;

       // calculated in/out area
       pArgv = sArgvBegP + node.pgmArgPo;
       sArgvP = pArgv; // may move based align (value)
       pSig = sSigBegP + node.pgmSigPo;
       if node.xmlPrmRet = XML_IS_PARM;
         pCopy = sParmP;
         node.pgmTruOff = sParmP - sParmBegP;
       else;
         pCopy = sRetP;
         node.pgmTruOff = sRetP - sParmBegP;
       endif;

       // signature _ILECALL only (SRVPGM)
       // only parms (not return value)
       // only top value is "signature"
       if  node.xmlCallAs = XML_FUNC_SRVPGM
       and node.xmlPrmRet = XML_IS_PARM
       and node.pgmArgTop = XML_PGM_TOP_TRUE;
         // pointer to value?
         if node.pgmPtrTyp = XML_PTR_ILE;
           mySig.shortx = ARG_SPCPTR;
         // by value
         else;
           // opm mode not support by value
           if sOPM = XML_PGM_OPM_TRUE;
             node.pgmValErr = XML_PGM_ERROR_TRUE;
             return *OFF;
           endif;
           // data type value
           select;
           // signed int
           when node.xmlAttr = XML_ATTR_VAL_I;
             select;
             when node.xmlDigits <= 3;
               mySig.shortx = ARG_INT8;
               //mySig.shortx = 1;
             when node.xmlDigits>3 and node.xmlDigits <= 5;
               mySig.shortx = ARG_INT16;
               //mySig.shortx = 2;
             when node.xmlDigits > 5 and node.xmlDigits <= 10;
               mySig.shortx = ARG_INT32;
               //mySig.shortx = 4;
             when node.xmlDigits > 10;
               mySig.shortx = ARG_INT64;
               //mySig.shortx = 8;
             other;
             endsl;
           // unsigned int (mmm)
           when node.xmlAttr = XML_ATTR_VAL_U;
             select;
             when node.xmlDigits <= 3;
               mySig.shortx = ARG_UINT8;
               //mySig.shortx = 1;
             when node.xmlDigits>3 and node.xmlDigits <= 5;
               mySig.shortx = ARG_UINT16;
               //mySig.shortx = 2;
             when node.xmlDigits > 5 and node.xmlDigits <= 10;
               mySig.shortx = ARG_UINT32;
               //mySig.shortx = 4;
             when node.xmlDigits > 10;
               mySig.shortx = ARG_UINT64;
               //mySig.shortx = 8;
             other;
             endsl;
           // float or double
           when node.xmlAttr = XML_ATTR_VAL_F;
             mySig.shortx = ARG_FLOAT32;
             //mySig.shortx = 4;
           when node.xmlAttr = XML_ATTR_VAL_D;
             mySig.shortx = ARG_FLOAT64;
             //mySig.shortx = 8;
           // binary (hex char)
           // character
           // packed or zoned decimal
           // other?
           other;
             if node.pgmArgSz < 1;
               mySig.shortx = 1;
             elseif node.pgmArgSz < 32767;
               mySig.shortx = node.pgmArgSz;
             else;
               mySig.shortx = 32767;
             endif;
           endsl;
         endif;
       endif;

       // by value argument?
       if node.xmlPrmRet = XML_IS_PARM 
       and node.xmlBy = XML_BY_VAL
       and node.xmlCallAs = XML_FUNC_SRVPGM;
         pCopy = pArgv;
         myCopy.ulonglongx = 0;
         pCopy += 8;
         myCopy.ulonglongx = 0;
         pCopy += 8;
         myCopy.ulonglongx = 0;
         pCopy += 8;
         myCopy.ulonglongx = 0;
         pCopy = pArgv;
       endif;

       // pointer to value?
       if node.pgmPtrTyp = XML_PTR_ILE;      // write ILE ptr
         myArgv.ptrx = sParmP;
         if node.xmlIsOmit = XML_PARM_OMIT_TRUE; // write NULL OMIT
           myArgv.ptrx = *NULL;
         endif;
         if sOPM = XML_PGM_OPM_TRUE;         // (1.6.8)
           pArgv += %size(sParmBegP);
           myArgv.ptrx = *NULL;              // null terminate
         endif;
       elseif node.pgmPtrTyp = XML_PTR_PASE; // write PASE ptr
         if sOPM = XML_PGM_OPM_TRUE;         // (1.6.8)
           myArgv.ptrx = sParmP;             // by ref (ile addr)
           pArgv += %size(sParmBegP);
           myArgv.ptrx = *NULL;              // null terminate
         else;
           myArgv.uintx = sOrig 
                      + (sParmP - sOrigP);   // by ref (pase addr)
           pArgv += 4;
           myArgv.uintx = 0;                 // null terminate
         endif;
       endif;

       // data values
       select;

       // hole
       when node.xmlAttr = XML_ATTR_VAL_H;
         memset(pCopy:x'00':node.xmlDigits);

       // binary (hex char)
       // string = 'F0F1F2CDEF' is type='5b', node.xmlDigits = 5
       // string = 'F0F1'       is type='2b', node.xmlDigits = 2
       // - padded with x'00', stringLen/2 < node.xmlDigits
       // - truncated,         stringLen/2 > node.xmlDigits
       // -- or --
       // simple character (string char)
       // string = 'charlie'   is type='nA', node.xmlDigits = n
       // - padded with x'40', stringLen < node.xmlDigits
       // - truncated,         stringLen > node.xmlDigits
       when node.xmlAttr = XML_ATTR_VAL_B
       or   node.xmlAttr = XML_ATTR_VAL_A;
         // pad *BLANKS or Zero
         if node.xmlAttr = XML_ATTR_VAL_A;
           convPad = x'40'; // *BLANKS
         endif;
         // varying field - nnchars...
         convVary = node.xmlVary;
         // convert hex
         if node.xmlAttr = XML_ATTR_VAL_B
         or node.xmlIsHex = XML_ATTR_HEX_TRUE;
           convHex = *ON;
         endif;
         // convert ccsid
         if node.xmlbCCSID1 > 0;
           cntCCSID = 1;
           srcCCSID(1) = node.xmlbCCSID1;
           tgtCCSID(1) = node.xmlbCCSID2;
           if node.xmlbCCSID3 > 0;
             cntCCSID = 2;
             srcCCSID(2) =  tgtCCSID(1);
             tgtCCSID(2) = node.xmlbCCSID3;
           endif;
           if node.xmlbCCSID4 > 0;
             cntCCSID = 3;
             srcCCSID(3) =  tgtCCSID(2);
             tgtCCSID(3) = node.xmlbCCSID4;
           endif;
         endif;
         // pad fill area
         rc9 = fillChar(pCopy:node.xmlDigits
                   :string:stringLen
                   :trimSz
                   :convPad:convVary:convHex
                   :cntCCSID:srcCCSID:tgtCCSID
                   :*OFF:*OFF:*OFF);

       // signed int
       when node.xmlAttr = XML_ATTR_VAL_I;
         select;
         when node.xmlDigits <= 3;
           myCopy.chrx = %INT(%str(string:stringLen));
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           myCopy.shortx = %INT(%str(string:stringLen));
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           myCopy.intx = %INT(%str(string:stringLen));
         when node.xmlDigits > 10;
           myCopy.longlongx = %INT(%str(string:stringLen));
         other;
         endsl;

       // unsigned int (mmm)
       when node.xmlAttr = XML_ATTR_VAL_U;
         select;
         when node.xmlDigits <= 3;
           myCopy.uchrx = %UNS(%str(string:stringLen));
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           myCopy.ushortx = %UNS(%str(string:stringLen));
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           myCopy.uintx = %UNS(%str(string:stringLen));
         when node.xmlDigits > 10;
           myCopy.ulonglongx = %UNS(%str(string:stringLen));
         other;
         endsl;

       // float or double
       when node.xmlAttr = XML_ATTR_VAL_F
         or node.xmlAttr = XML_ATTR_VAL_D;
         rc = cpyInF64(pCopy:node);

       // packed or zoned decimal
       when node.xmlAttr = XML_ATTR_VAL_P
         or node.xmlAttr = XML_ATTR_VAL_S;
         rc = cpyInDec(pCopy:node);

       // other?
       other;
         node.pgmValErr = XML_PGM_ERROR_TRUE;
       endsl;

       // -------------
       // error
       On-error;
         node.pgmValErr = XML_PGM_ERROR_TRUE;
       Endmon;

       // --------------
       // hex of data (1.6.8)
       if rc9 = *OFF or node.pgmValErr = XML_PGM_ERROR_TRUE;
         Monitor;
           node.pgmValHex = *BLANKS;
           trimSz = %div(%size(node.pgmValHex):2);
           convRc = cpyB2Hex(%addr(node.pgmValHex)
                            :pCopy:trimSz);
         On-error;
         Endmon;
       endif;

       // --------------
       // next
       rc = ileNext(node);

       perfAdd(PERF_ANY_WATCH_PUSH:*OFF);

       if rc9 = *OFF or node.pgmValErr = XML_PGM_ERROR_TRUE;
         node.pgmValErr = XML_PGM_ERROR_TRUE;
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * ILE pop data int 
      * return
      *****************************************************
     P ilePushLen      B                   export
     D ilePushLen      PI             1N
     D   node                              likeds(xmlNode_t)
      * vars
     D f64             s              8f   inz(0.0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
      /free

       Monitor;

       // -----------
       // data copy target
       pCopy = sParmBegP + node.pgmTruOff;
       // real
       f64 = node.xmlStrSz;
       select;
       // signed int
       when node.xmlAttr = XML_ATTR_VAL_I;
         select;
         when node.xmlDigits <= 3;
           myCopy.chrx = node.xmlStrSz;
           return *ON;
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           myCopy.shortx = node.xmlStrSz;
           return *ON;
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           myCopy.intx = node.xmlStrSz;
           return *ON;
         when node.xmlDigits > 10;
           myCopy.longlongx = node.xmlStrSz;
           return *ON;
         other;
         endsl;

       // unsigned int (mmm)
       when node.xmlAttr = XML_ATTR_VAL_U;
         select;
         when node.xmlDigits <= 3;
           myCopy.uchrx = node.xmlStrSz;
           return *ON;
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           myCopy.ushortx = node.xmlStrSz;
           return *ON;
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           myCopy.uintx = node.xmlStrSz;
           return *ON;
         when node.xmlDigits > 10;
           myCopy.ulonglongx = node.xmlStrSz;
           return *ON;
         other;
         endsl;

       // float
       when node.xmlAttr = XML_ATTR_VAL_F;
         myCopy.floatx = f64;
         return *ON;

       // double
       when node.xmlAttr = XML_ATTR_VAL_D;
         myCopy.doublex = f64;
         return *ON;

       // packed decimal
       when node.xmlAttr = XML_ATTR_VAL_P;
         QXXDTOP(pCopy:node.xmlDigits:node.xmlFrac:f64);
         return *ON;

       // zoned decimal
       when node.xmlAttr = XML_ATTR_VAL_S;
         QXXDTOZ(pCopy:node.xmlDigits:node.xmlFrac:f64);
         return *ON;

       // other?
       other;
       endsl;

       // -------------
       // error
       On-error;
       Endmon;

       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * ILE pop data output 
      * return (*ON=good, *OFF=error)
      *****************************************************
     P ilePopData      B                   export
     D ilePopData      PI             1N
     D   outPtrP                       *
     D   node                              likeds(xmlNode_t)
      * vars
     D rc              s              1N   inz(*OFF)
     D rc9             s              1N   inz(*ON)
     D i               s             10i 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D pCopy1          s               *   inz(*NULL)
     D myCopy1         ds                  likeds(over_t) based(pCopy1)
     D str             s             64A   inz(*BLANKS)
     D strP            s               *   inz(%addr(str))
     D strSz           s             10i 0 inz(0)
     D trimSz          s             10i 0 inz(0)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D convRc          s             10i 0 inz(0)
     D convPad         s             10i 0 inz(0)
     D convHex         s              1N   inz(*OFF)
     D convVary        s              1A   inz(XML_VARY_OFF)
     D cntCCSID        s             10i 0 inz(0)
     D srcCCSID        s             10i 0 dim(XMLMAXATTR) inz(0)
     D tgtCCSID        s             10i 0 dim(XMLMAXATTR) inz(0)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
      /free
       Monitor;

       perfAdd(PERF_ANY_WATCH_POP:*ON);

       cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
       cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)

       // --------------
       // where are we?
       rc = ileCurrent(node);

       // original string
       string = node.xmlStrP;
       stringLen = node.xmlStrSz;

       // --------------
       // input only?
       if node.xmlIO = XML_IO_INPUT;
         rc = ileNext(node);
         perfAdd(PERF_ANY_WATCH_POP:*OFF);
         return *ON;
       endif;

       // calculated in/out area
       if node.xmlPrmRet = XML_IS_PARM;
         pCopy = sParmP;
         node.pgmTruOff = sParmP - sParmBegP; // ADC (1.9.2)
       else;
         pCopy = sRetP;
         node.pgmTruOff = sRetP - sParmBegP;  // ADC (1.9.2)
       endif;

       // --------------
       // copy out

       // <![CDATA[
       // ooooooooo
       if node.xmlIsCDATA = XML_ATTR_CDATA_TRUE;  // ADC (1.6.2)
         str = cCDATA1;
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
       endif;

       // --------------
       // by value argument?
       if node.xmlPrmRet = XML_IS_PARM 
       and node.xmlBy = XML_BY_VAL
       and node.xmlCallAs = XML_FUNC_SRVPGM;
         cpybytes(outPtrP:string:stringLen);
         outPtrP += stringLen;

       // --------------
       // by reference argument
       else;
       select;

       // hole
       when node.xmlAttr = XML_ATTR_VAL_H;
         pCopy1 = outPtrP;
         myCopy1.bytex = '0';
         outPtrP += 1;

       // binary (hex char)
       // string = 'F0F1F2CDEF' is type='5b', node.xmlDigits = 5
       // string = 'F0F1'       is type='2b', node.xmlDigits = 2
       // -- or --
       // simple character (string char)
       // string = 'charlie'   is type='nA', node.xmlDigits = n
       when node.xmlAttr = XML_ATTR_VAL_B
       or   node.xmlAttr = XML_ATTR_VAL_A;
         // pad *BLANKS or Zero
         if node.xmlAttr = XML_ATTR_VAL_A;
           convPad = x'40'; // *BLANKS
         endif;
         // varying field - nnchars...
         convVary = node.xmlVary;
         // convert hex
         if node.xmlAttr = XML_ATTR_VAL_B
         or node.xmlIsHex = XML_ATTR_HEX_TRUE;
           convHex = *ON;
         endif;
         // convert ccsid
         if node.xmlaCCSID1 > 0;
           cntCCSID = 1;
           srcCCSID(1) = node.xmlaCCSID1;
           tgtCCSID(1) = node.xmlaCCSID2;
           if node.xmlaCCSID3 > 0;
             cntCCSID = 2;
             srcCCSID(2) =  tgtCCSID(1);
             tgtCCSID(2) = node.xmlaCCSID3;
           endif;
           if node.xmlaCCSID4 > 0;
             cntCCSID = 3;
             srcCCSID(3) =  tgtCCSID(2);
             tgtCCSID(3) = node.xmlaCCSID4;
           endif;
         endif;
         // trim return area
         // trim='on|off' (1.7.1)
         if node.xmlTrim = XML_ATTR_TRIM_TRUE
         or (node.xmlTrim = XML_ATTR_TRIM_DEFAULT 
             and node.xmlAttr = XML_ATTR_VAL_A);
           rc9 = trimChar(outPtrP:-1
                   :pCopy:node.xmlDigits
                   :trimSz
                   :convPad:convVary:convHex
                   :cntCCSID:srcCCSID:tgtCCSID
                   :*OFF:*OFF:*OFF:*OFF:*OFF);
           outPtrP += trimSz;
         // Greg's problem XML_ATTR_VAL_B (@ADC 1.7.1)
         // QSYGETPH is 00000001 96BE1590 B3114000 
         // qwtsetp  is 00000001 96BE1590 B3110000 (bad trim)
         else;
           rc9 = fullChar(outPtrP:-1
                   :pCopy:node.xmlDigits
                   :trimSz
                   :convPad:convVary:convHex
                   :cntCCSID:srcCCSID:tgtCCSID
                   :*OFF:*OFF:*OFF:*OFF:*OFF);
           outPtrP += trimSz;
         endif;

       // signed int
       when node.xmlAttr = XML_ATTR_VAL_I;
         select;
         when node.xmlDigits <= 3;
           str = %char(myCopy.chrx);
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           str = %char(myCopy.shortx);
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           str = %char(myCopy.intx);
         when node.xmlDigits > 10;
           str = %char(myCopy.longlongx);
         other;
         endsl;
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

       // unsiged int (mmm)
       when node.xmlAttr = XML_ATTR_VAL_U;
         select;
         when node.xmlDigits <= 3;
           str = %char(myCopy.uchrx);
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           str = %char(myCopy.ushortx);
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           str = %char(myCopy.uintx);
         when node.xmlDigits > 10;
           str = %char(myCopy.ulonglongx);
         other;
         endsl;
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

       // float or double
       when node.xmlAttr = XML_ATTR_VAL_F
         or node.xmlAttr = XML_ATTR_VAL_D;
         rc = cpyOutF64(outPtrP:pCopy:node);

       // packed or zoned decimal
       when node.xmlAttr = XML_ATTR_VAL_P
         or node.xmlAttr = XML_ATTR_VAL_S;
         rc = cpyOutDec(outPtrP:pCopy:node);

       // other?
       other;
         node.pgmValErr = XML_PGM_ERROR_TRUE;
       endsl;
       endif;

       // -------------
       // error
       On-error;
         node.pgmValErr = XML_PGM_ERROR_TRUE;
       Endmon;

       if node.xmlIsCDATA = XML_ATTR_CDATA_TRUE;  // ADC (1.6.2)
         str = cCDATA2;
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
       endif;

       // --------------
       // hex of data (1.6.8)
       if rc9 = *OFF or node.pgmValErr = XML_PGM_ERROR_TRUE;
         Monitor;
           node.pgmValHex = *BLANKS;
           trimSz = %div(%size(node.pgmValHex):2);
           convRc = cpyB2Hex(%addr(node.pgmValHex)
                            :pCopy:trimSz);
         On-error;
         Endmon;
       endif;

       // --------------
       // next
       rc = ileNext(node);

       perfAdd(PERF_ANY_WATCH_POP:*OFF);

       if rc9 = *OFF or node.pgmValErr = XML_PGM_ERROR_TRUE;
         node.pgmValErr = XML_PGM_ERROR_TRUE;
         return *OFF;
       endif;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * ILE pop data int 
      * return
      *****************************************************
     P ilePopVal       B                   export
     D ilePopVal       PI            10i 0
     D   node                              likeds(xmlNode_t)
      * vars
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
      /free

       Monitor;

       // -----------
       // data copy target
       pCopy = sParmBegP + node.pgmTruOff;
       select;
       // signed int
       when node.xmlAttr = XML_ATTR_VAL_I;
         select;
         when node.xmlDigits <= 3;
           return myCopy.chrx;
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           return myCopy.shortx;
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           return myCopy.intx;
         when node.xmlDigits > 10;
           return myCopy.longlongx;
         other;
         endsl;

       // unsigned int (mmm)
       when node.xmlAttr = XML_ATTR_VAL_U;
         select;
         when node.xmlDigits <= 3;
           return myCopy.uchrx;
         when node.xmlDigits>3 and node.xmlDigits <= 5;
           return myCopy.ushortx;
         when node.xmlDigits > 5 and node.xmlDigits <= 10;
           return myCopy.uintx;
         when node.xmlDigits > 10;
           return myCopy.ulonglongx;
         other;
         endsl;

       // float
       when node.xmlAttr = XML_ATTR_VAL_F;
         return myCopy.floatx;

       // double
       when node.xmlAttr = XML_ATTR_VAL_D;
         return myCopy.doublex;

       // packed decimal
       when node.xmlAttr = XML_ATTR_VAL_P;
         return QXXPTOD(pCopy:node.xmlDigits:node.xmlFrac);

       // zoned decimal
       when node.xmlAttr = XML_ATTR_VAL_S;
         return QXXZTOD(pCopy:node.xmlDigits:node.xmlFrac);

       // other?
       other;
         return 0;
       endsl;

       // -------------
       // error
       On-error;
       Endmon;

       return 0;
      /end-free
     P                 E

      *------------------------------------------------
      * Use QSZRTVPR API to get the current OS release
      *------------------------------------------------
     P ileIsV5         B                   export
     D ileIsV5         PI             1N

     d ErrorCode...
     d                 DS                  qualified
     d  BytesProv                    10I 0
     d  BytesAvail                   10I 0

     d PRDI0100...
     d                 DS                  qualified
     d   ProdID                       7A
     d   version                      6A
     d   ProdOpt                      4A
     d   LoadID                      10A

     d PRDR0100...
     d                 DS                  qualified
     d   BytesRtn                    10I 0
     d   BytesAval                   10I 0
     d   Rsv                         10I 0
     d   ProdID                       7A
     d   version                      6A

     D RtvPrdInf       PR                  ExtPgm('QSZRTVPR')
     d  RESULT                      128a   options(*varsize)
     d  RSTLEN                       10i 0 const
     d  FORMAT                        8a   const
     d  OSINFO                       27a   const
     d   Error_Code                 256a   options(*varsize)

     D format          s              8A   inz('PRDR0100')
     D size            s             10i 0 inz(%size(PRDR0100))
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)

      /free
       ErrorCode.BytesProv  = 0;
       ErrorCode.BytesAvail = 0;
       PRDI0100.ProdID      = '*OPSYS';
       PRDI0100.version     = '*CUR';
       PRDI0100.ProdOpt     = '0000';
       PRDI0100.LoadID      = '*CODE';
       PRDR0100.BytesRtn    = 0;
       PRDR0100.BytesAval   = 0;
       PRDR0100.Rsv         = 0;
       PRDR0100.ProdID      = *BLANKS;
       PRDR0100.version     = *BLANKS;
       RtvPrdInf( PRDR0100
               : size
               : format
               : PRDI0100
               : ErrorCode );

       pCopy = %addr(PRDR0100.version);
       if myCopy.char2 = 'V5';
         return *ON;
       endif;

       return *OFF;
      /end-free
     P                 E 

      *****************************************************
      * ileJob
      * return (NA)
      *****************************************************
     P ileJob          B                   export
     D ileJob          PI             1N
     D   jobName                     10A
     D   jobUserID                   10A
     D   jobNbr                       6A
     D   jobInfo                           likeds(myJob_t)
      * vars
     D i               s             10i 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D aJob            s             26A   inz(*BLANKS)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)

      * job info
     D RtvJobInf       PR                  ExtPgm('QUSRJOBI')
     D   RcvVar                   32766A   options(*varsize)
     D   RcvVarLen                   10I 0 CONST
     D   Format                       8A   CONST
     D   JobName                     26A   CONST
     D   IntJobID                    16A   CONST
     D   ErrorCode                32766A   options(*varsize)

     D dsJobI0400      DS
     D   Job4_ByteRtn                10I 0
     D   Job4_ByteAvl                10I 0
     D   Job4_JobName                10A
     D   Job4_UserID                 10A
     D   Job4_JobNbr                  6A
     D   Job4_IntJob                 16A
     D   Job4_Status                 10A
     D   Job4_Type                    1A
     D   Job4_SbType                  1A
     D   Job4_DateEnt                13A
     D   Job4_DateAct                13A
     D   Job4_JobAcct                15A
     D   Job4_JobD                   10A
     D   Job4_JobDLib                10A
     D   Job4_UnitWrk                24A
     D   Job4_ModeNam                 8A
     D   Job4_InqMsgR                10A
     D   Job4_LogCl                  10A
     D   Job4_BrkMsgH                10A
     D   Job4_StsMsgH                10A
     D   Job4_DevAct                 13A
     D   Job4_DDMCnvH                10A
     D   Job4_DateSep                 1A
     D   Job4_DateFmt                 4A
     D   Job4_PrtText                30A
     D   Job4_SbmName                10A
     D   Job4_SbmUser                10A
     D   Job4_SbmNbr                  6A
     D   Job4_MsgQ                   10A
     D   Job4_MsgQLib                10A
     D   Job4_TimeSep                 1A
     D   Job4_CCSID                  10i 0
     D   Job4_SchdRun                 8A
     D   Job4_PrtFmt                 10A
     D   Job4_SrtSeq                 10A
     D   Job4_SrtSeqL                10A
     D   Job4_LangId                  3A
     D   Job4_CntryId                 2A
     D   Job4_Complet                 1A
     D   Job4_SignOn                  1A
     D   Job4_Switchs                 8A
     D   Job4_MsgQAct                10A
     D   Job4_Resrv1                  1A
     D   Job4_MsgQMax                10i 0
     D   Job4_DfCCSID                10i 0
     D   Job4_Route                  80A
     D   Job4_DecFmt                  1A
     D   Job4_CharId                 10A
     D   Job4_SrvType                30A
     D   Job4_AlwThrd                 1A
     D   Job4_JobLog                  1A
     D   Job4_Resrv2                  1A
     D   Job4_JobEnd                 10i 0
     D   Job4_TypeEnh                10i 0
     D   Job4_DateEnd                13A
     D   Job4_Resrv3                  1A
     D   Job4_SpolAct                10A
     D   Job4_OffAspG                10i 0
     D   Job4_NbrAspG                10i 0
     D   Job4_LenAspG                10i 0
     D   Job4_ZoneNam                10A
     D   Job4_JLogOut                10A
     D   Job4_AspG                32000A

     D dsJobI0600      DS
     D   Job6_ByteRtn                10I 0
     D   Job6_ByteAvl                10I 0
     D   Job6_JobName                10A
     D   Job6_UserID                 10A
     D   Job6_JobNbr                  6A
     D   Job6_IntJob                 16A
     D   Job6_Status                 10A
     D   Job6_Type                    1A
     D   Job6_SbType                  1A
     D   Job6_Swtchs                  8A
     D   Job6_EndSts                  1A
     D   Job6_SbsName                10A
     D   Job6_SbsLib                 10A
     D   Job6_CurUser                10A
     D   Job6_DBCS                    1A
     D   Job6_ExitKey                 1A
     D   Job6_CancKey                 1A
     D   Job6_PrdRetC                10i 0
     D   Job6_UsrRetC                10i 0
     D   Job6_PgmRetC                10i 0
     D   Job6_SpecEnv                10A
     D   Job6_DevName                10A
     D   Job6_GrpName                10A
     D   Job6_GrpNams                10A   dim(15)
     D   Job6_JobUser                10A
     D   Job6_JobUSet                 1A
     D   Job6_IPAddr                 15A
     D   Job6_Resrv1                  2A
     D   Job6_OffZone                10i 0
     D   Job6_LenZone                10i 0
     D   Job6_Zone                32000A

     D dsJobI0700      DS
     D   Job7_ByteRtn                10I 0
     D   Job7_ByteAvl                10I 0
     D   Job7_JobName                10A
     D   Job7_UserID                 10A
     D   Job7_JobNbr                  6A
     D   Job7_IntJob                 16A
     D   Job7_Status                 10A
     D   Job7_Type                    1A
     D   Job7_SbType                  1A
     D   Job7_Reserv1                 2A
     D   Job7_NbrSysL                10I 0
     D   Job7_NbrPrdL                10I 0
     D   Job7_OneCurL                10I 0
     D   Job7_NbrUsrL                10I 0
     D   Job7_Libl                32000A

     D dsEC            DS
     D  dsECBytesP             1      4I 0 INZ(256)
     D  dsECBytesA             5      8I 0 INZ(0)
     D  dsECMsgID              9     15
     D  dsECReserv            16     16
     D  dsECMsgDta            17    256
      /free
       // * - my job
       if jobName = *BLANKS;
         aJob = '*';
       // 'name      user      nbr   ' (26 length)
       else;
         aJob = jobName + jobUserID + jobNbr;
       endif;

       // initialize
       jobInfo.Job0_JobName = jobName;
       jobInfo.Job0_UserID  = jobUserID;
       jobInfo.Job0_JobNbr  = jobNbr;
       jobInfo.Job0_LangId  = *BLANKS;
       jobInfo.Job0_CntryId = *BLANKS;
       jobInfo.Job0_CCSID   = 0;
       jobInfo.Job0_DfCCSID = 0;
       jobInfo.Job0_CurUser = *BLANKS;
       jobInfo.Job0_SbsName = *BLANKS;
       jobInfo.Job0_SbsLib  = *BLANKS;
       jobInfo.Job0_Status  = *BLANKS;
       jobInfo.Job0_CurL    = *BLANKS;
       jobInfo.Job0_SysL    = *BLANKS;
       jobInfo.Job0_PrdL    = *BLANKS;
       jobInfo.Job0_UsrL    = *BLANKS;

       // retrieve system

       RtvJobInf(dsJOBI0400:%size(dsJOBI0400):'JOBI0400':aJob:*BLANKS:dsEC);
       if dsECBytesA > 0;
         return *OFF;
       endif;
       jobName   = Job4_JobName;  // JOB(?)
       jobUserID = Job4_UserID;   // USER(?)
       jobNbr    = Job4_JobNbr;   // NBR(?)
       jobInfo.Job0_JobName = Job4_JobName;  // JOB(?)
       jobInfo.Job0_UserID  = Job4_UserID;   // USER(?)
       jobInfo.Job0_JobNbr  = Job4_JobNbr;   // NBR(?)
       jobInfo.Job0_LangId  = Job4_LangId;   // LANGID(?)
       jobInfo.Job0_CntryId = Job4_CntryId;  // CNTRYID(?)
       jobInfo.Job0_CCSID   = Job4_CCSID;    // CCSID(?N)
       jobInfo.Job0_DfCCSID = Job4_DfCCSID;  // DFTCCSID(?N)

       RtvJobInf(dsJOBI0600:%size(dsJOBI0600):'JOBI0600':aJob:*BLANKS:dsEC);
       if dsECBytesA > 0;
         return *OFF;
       endif;
       jobInfo.Job0_CurUser = Job6_CurUser;  // CURUSER(?)
       jobInfo.Job0_SbsName = Job6_SbsName;
       jobInfo.Job0_SbsLib  = Job6_SbsLib;
       jobInfo.Job0_Status  = Job6_Status;

       RtvJobInf(dsJOBI0700:%size(dsJOBI0700):'JOBI0700':aJob:*BLANKS:dsEC);
       if dsECBytesA > 0;
         return *OFF;
       endif;
       pCopy = %addr(Job7_Libl);
       for i = 1 to Job7_NbrSysL; // SYSLIBL(?)
         jobInfo.Job0_SysL = %trim(jobInfo.Job0_SysL) 
                           + ' ' + myCopy.char10;
         pCopy += 11;
       endfor;
       for i = 1 to Job7_NbrPrdL; // PRDLIBL(?)
         jobInfo.Job0_PrdL = %trim(jobInfo.Job0_PrdL) 
                           + ' ' + myCopy.char10;
         pCopy += 11;
       endfor;
       if Job7_OneCurL > 0;       // CURLIBL(?)
         jobInfo.Job0_CurL = %trim(jobInfo.Job0_CurL) 
                           + ' ' + myCopy.char10;
         pCopy += 11;
       endif;
       for i = 1 to Job7_NbrUsrL; // USRLIBL(?)
         jobInfo.Job0_UsrL = %trim(jobInfo.Job0_UsrL) 
                           + ' ' + myCopy.char10;
         pCopy += 11;
       endfor;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * rc=ileRslv(...)
      * return (*ON=good, *OFF=error)
      * Note: 
      * calling ILE and call argument buffer
      * was prepared by plugile using "ILE memory" 
      * (not pase memory)
      *
      * ptr = rslvsp(objType:pgm1:lib1:x'0000');
      *
      * actmark = ileload(srvpgm, errno_ile)
      * QleActBndPgmLong(srvpgm,
      *         0, // don't need by-address actmark
      *         0, // don't need activation info
      *         0, //  no activation info length
      *         0); // don't return error code
      *
      * rc = ilesym(actmark, symbolName, exportPtr, errno_ile);
      * QleGetExpLong(&actmark,
      *         0, // don't need export id
      *         0, // name is null-terminated string
      *         (char*)symbolName, // proto not const-correct
      *         exportPtr,
      *         &exportType,
      *         0); // don't return error code
      *****************************************************
     P ileRslv         B                   export
     D ileRslv         PI             1N
     D  pgm2                         10A   value
     D  lib2                         10A   value
     D  pSym                           *
     D  sym2                        128A   value options(*nopass)
      * vars
     D rcb             S              1N   inz(*OFF)
     D rc              S             10I 0 inz(0)
     D pgm1            s             10A   inz(*BLANKS)
     D lib1            s             10A   inz(*BLANKS)
     D sym1            s            128A   inz(*BLANKS)
     D len1            S             10I 0 inz(0)
     D typ1            S             10I 0 inz(0)
     D pILEChk         S               *   inz(*NULL)
     D pILESym         S               *   inz(*NULL)
     D deadPtr         S               *   Procptr inz(*NULL)
     D AnyDS           ds                  qualified based(Template)
     D   AnyPtr                        *   Procptr
     D myPtr           s               *   inz(*NULL)
     D myDS            ds                  likeds(AnyDS) based(myPtr)
      * more
     D objType         S              2A   inz(RSLOBJ_TS_PGM)
     D actmark         S             10i 0 inz(0)
     D actmark1        S             20i 0 inz(0)
     D paseRc          S             10I 0 inz(0)
     D sym0            S            128A   inz(*BLANKS)
      /free
       if %parms >= 4;
         sym1 = sym2;
       endif;

       pSym = *NULL;
       myPtr = %addr(pILESym);

       if sym1 <> *BLANKS;
         objType = RSLOBJ_TS_SRVPGM;
       endif;

       // convert 
       pgm1 = pgm2;
       rcb = toUpperSafe(%addr(pgm1):%size(pgm1));
       lib1 = lib2;
       rcb = toUpperSafe(%addr(lib1):%size(lib1));

       // library list (1.6.8)
       if lib1 = *BLANKS;
          lib1 = '*LIBL';
       endif;

       // _RSLOBJ2/rslvsp cache
       Monitor;

       rcb = cacScanPgm(CAC_QP2_RSLOBJ2:pgm1:lib1:sym0:
                      pILESym:actmark);
       if rcb = *OFF;
         // need to call OPM in V5R4 (1.6.8)
         myDS.AnyPtr = rslvsp(objType:pgm1:lib1:x'0000');
         if myDS.AnyPtr <> deadPtr;
           cacAddPgm(CAC_QP2_RSLOBJ2:pgm1:lib1:sym0:
                 pILESym:actmark);
         else;
           errsSevere(QP2_ERROR_RSLOBJ2_FAIL:pgm1);
           return *OFF;
         endif;
       endif;

       On-error;
         errsSevere(QP2_ERROR_RSLOBJ2_FAIL:pgm1);
         return *OFF;
       Endmon;

       // ------------
       // *PGM
       if sym1 = *BLANKS;
         pSym = pILESym;
         return *ON;
       endif;

       // ------------
       // *SRVPGM

       // activation cache;
       Monitor;

       rcb = cacScanPgm(CAC_QP2_ILELOAD:pgm1:lib1:sym1:
                      pILESym:actmark);
       if rcb = *OFF;
         actmark1 = actbndpgm(%addr(pILESym));
         if actmark1 > 0;
           actmark = actmark1;
           cacAddPgm(CAC_QP2_ILELOAD:pgm1:lib1:sym1:
                   pILESym:actmark);
          else;
           errsSevere(QP2_ERROR_ILELOAD_FAIL:sym1);
           return *OFF;
         endif;
       endif;

       On-error;
         errsSevere(QP2_ERROR_ILELOAD_FAIL:sym1);
         return *OFF;
       Endmon;


       // ILE SYM cache;
       Monitor;

       rcb = cacScanPgm(CAC_QP2_ILESYM:pgm1:lib1:sym1:
                  pILESym:actmark);
       if rcb = *OFF;
         actmark1 = actmark;
         len1 = %len(%trim(sym1));
         pILEChk = actsympgm(actmark1:0:len1:sym1:%addr(pILESym):typ1);
         if myDS.AnyPtr <> deadPtr;
           cacAddPgm(CAC_QP2_ILESYM:pgm1:lib1:sym1:
                     pILESym:actmark);
         else;
           errsSevere(QP2_ERROR_ILESYM_FAIL:sym1);
           return *OFF;
         endif;
       endif;

       On-error;
         errsSevere(QP2_ERROR_ILESYM_FAIL:sym1);
         return *OFF;
       Endmon;

       // --------------
       // procedure pointer
       pSym = pILESym;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * rc=ilePGM(...)
      * return (*ON=good, *OFF=error)
      * Note: 
      * calling ILE and call argument buffer
      * was prepared by plugile using "ILE memory" 
      * (not pase memory) 
      *****************************************************
     P ilePGM          B                   export
     D ilePGM          PI             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  piReturn                       *
      * vars
     D i               S             10I 0 inz(0)
     D j               S             10I 0 inz(0)
     D rcb             S              1N   inz(*OFF)
     D rc              S             10I 0 inz(0)
     D paseRc          S             10I 0 inz(0)
     D min             S             10U 0 inz(X'FFFFFFFF')
     D pILESym         S               *   inz(*NULL)
     D actmark         S             10I 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
      * debug
     D tBenArgSz       s             10i 0 inz(0)
     D tBenArgP        S               *   inz(*NULL)
     D tBenPrmSz       s             10i 0 inz(0)
     D tBenPrmP        S               *   inz(*NULL)
     D tBenRetSz       s             10i 0 inz(0)
     D tBenRetP        S               *   inz(*NULL)
      * old pgm
     D pargv           S               *   inz(*NULL)
     D argc            S             10I 0 inz(0)
     d argv            s               *   dim(256) based(pargv)
      /free
       Monitor;

       tBenArgSz = ileSzArgv(tBenArgP);
       tBenPrmSz = ileSzParm(tBenPrmP);
       tBenRetSz = ileSzRet(tBenRetP);

       rcb = ileRslv(pgm1:lib1:pILESym);
       if rcb = *OFF;
         return *OFF;
       endif;

       // _CALLPGMV(&object_pointer, (void **)&argv[2], argc-2);
       pargv = sArgvBegP;
       for argc = 0 to 256;
          if argv(argc+1) = *NULL;
           leave;
         endif;
       endfor;
       if piReturn <> *NULL;
         pCopy = piReturn;
         myCopy.intx = -1;
       endif;
       callpgmv(pILESym:argv:argc);
       if piReturn <> *NULL;
         pCopy = piReturn;
         myCopy.intx = 0;
       endif;

       On-error;
         errsSevere(QP2_ERROR_PGMCALL_FAIL:pgm1);
         return *OFF;
       Endmon;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * rc=ileSRV(...)
      * return (*ON=good, *OFF=error)
      * Note: 
      * calling ILE and call argument buffer
      * was prepared by plugile using "ILE memory" 
      * (not pase memory) 
      *****************************************************
     P ileSRV          B                   export
     D ileSRV          PI             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  sym1                        128A
     D  piReturn                       *
     D  retSize                      10i 0
      * vars
     D j               S             10I 0 inz(0)
     D rcb             S              1N   inz(*OFF)
     D rc              S             10I 0 inz(0)
     D paseRc          S             10I 0 inz(0)
     D min             S             10U 0 inz(X'FFFFFFFF')
     D pILESym         S               *   inz(*NULL)
     D pCopy           s               *
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D myBuf           S          65000A   inz(*BLANKS)
     D myPtr           S               *   inz(*NULL)
     D myCopy2         ds                  likeds(over_t) based(pCopy)
      * debug
     D tBenArgSz       s             10i 0 inz(0)
     D tBenArgP        S               *   inz(*NULL)
     D tBenPrmSz       s             10i 0 inz(0)
     D tBenPrmP        S               *   inz(*NULL)
     D tBenRetSz       s             10i 0 inz(0)
     D tBenRetP        S               *   inz(*NULL)
      * old pgm
     D pargv           S               *   inz(*NULL)
     D argc            S             10I 0 inz(0)
     d argv            s               *   dim(256) based(pargv)
     d div16           s             10i 0 inz(16)
     D AnyDS           ds                  qualified based(Template)
     D   AnyProc                       *   Procptr
     D anyProc         s               *   inz(*NULL)
     D myDS            ds                  likeds(AnyDS) based(anyProc)
     D procPtr         S               *   ProcPtr
     D pMyProc0        Pr         65000A   ExtProc(procPtr)
     D pMyProc1        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D pMyProc2        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D pMyProc3        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D pMyProc4        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D pMyProc5        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D pMyProc6        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D pMyProc7        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D pMyProc8        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D pMyProc9        Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D pMyProc10       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D pMyProc11       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D pMyProc12       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D pMyProc13       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D pMyProc14       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D pMyProc15       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D pMyProc16       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D pMyProc17       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D pMyProc18       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D pMyProc19       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D pMyProc20       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D pMyProc21       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D pMyProc22       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D pMyProc23       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D pMyProc24       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D pMyProc25       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D  pargv25                        *   value
     D pMyProc26       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D  pargv25                        *   value
     D  pargv26                        *   value
     D pMyProc27       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D  pargv25                        *   value
     D  pargv26                        *   value
     D  pargv27                        *   value
     D pMyProc28       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D  pargv25                        *   value
     D  pargv26                        *   value
     D  pargv27                        *   value
     D  pargv28                        *   value
     D pMyProc29       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D  pargv25                        *   value
     D  pargv26                        *   value
     D  pargv27                        *   value
     D  pargv28                        *   value
     D  pargv29                        *   value
     D pMyProc30       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D  pargv25                        *   value
     D  pargv26                        *   value
     D  pargv27                        *   value
     D  pargv28                        *   value
     D  pargv29                        *   value
     D  pargv30                        *   value
     D pMyProc31       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D  pargv25                        *   value
     D  pargv26                        *   value
     D  pargv27                        *   value
     D  pargv28                        *   value
     D  pargv29                        *   value
     D  pargv30                        *   value
     D  pargv31                        *   value
     D pMyProc32       Pr         65000A   ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
     D  pargv3                         *   value
     D  pargv4                         *   value
     D  pargv5                         *   value
     D  pargv6                         *   value
     D  pargv7                         *   value
     D  pargv8                         *   value
     D  pargv9                         *   value
     D  pargv10                        *   value
     D  pargv11                        *   value
     D  pargv12                        *   value
     D  pargv13                        *   value
     D  pargv14                        *   value
     D  pargv15                        *   value
     D  pargv16                        *   value
     D  pargv17                        *   value
     D  pargv18                        *   value
     D  pargv19                        *   value
     D  pargv20                        *   value
     D  pargv21                        *   value
     D  pargv22                        *   value
     D  pargv23                        *   value
     D  pargv24                        *   value
     D  pargv25                        *   value
     D  pargv26                        *   value
     D  pargv27                        *   value
     D  pargv28                        *   value
     D  pargv29                        *   value
     D  pargv30                        *   value
     D  pargv31                        *   value
     D  pargv32                        *   value
      /free

       Monitor;

       tBenArgSz = ileSzArgv(tBenArgP);
       tBenPrmSz = ileSzParm(tBenPrmP);
       tBenRetSz = ileSzRet(tBenRetP);

       rcb = ileRslv(pgm1:lib1:pILESym:sym1);
       if rcb = *OFF;
         return *OFF;
       endif;

       pargv = sArgvBegP;
       for argc = 0 to 256;
          if argv(argc+1) = *NULL;
           leave;
         endif;
       endfor;
       if piReturn <> *NULL;
         pCopy = piReturn;
         myCopy.intx = -1;
       endif;


       anyProc = %addr(pILESym);
       procPtr = myDS.AnyProc;

       select;
       when argc = 0;
         myBuf = pMyProc0();
       when argc = 1;
         myBuf = pMyProc1(argv(1));
       when argc = 2;
         myBuf = pMyProc2(argv(1):argv(2));
       when argc = 3;
         myBuf = pMyProc3(argv(1):argv(2):argv(3));
       when argc = 4;
         myBuf = pMyProc4(argv(1):argv(2):argv(3):argv(4));
       when argc = 5;
         myBuf = pMyProc5(argv(1):argv(2):argv(3):argv(4)
                         :argv(5));
       when argc = 6;
         myBuf = pMyProc6(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6));
       when argc = 7;
         myBuf = pMyProc7(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7));
       when argc = 8;
         myBuf = pMyProc8(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8));
       when argc = 9;
         myBuf = pMyProc9(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9));
       when argc = 10;
         myBuf = pMyProc10(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10));
       when argc = 11;
         myBuf = pMyProc11(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11));
       when argc = 12;
         myBuf = pMyProc12(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12));
       when argc = 13;
         myBuf = pMyProc13(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13));
       when argc = 14;
         myBuf = pMyProc14(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14));
       when argc = 15;
         myBuf = pMyProc15(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15));
       when argc = 16;
         myBuf = pMyProc16(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16));
       when argc = 17;
         myBuf = pMyProc17(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17));
       when argc = 18;
         myBuf = pMyProc18(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18));
       when argc = 19;
         myBuf = pMyProc19(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19));
       when argc = 20;
         myBuf = pMyProc20(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20));
       when argc = 21;
         myBuf = pMyProc21(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21));
       when argc = 22;
         myBuf = pMyProc22(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22));
       when argc = 23;
         myBuf = pMyProc23(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23));
       when argc = 24;
         myBuf = pMyProc24(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24));
       when argc = 25;
         myBuf = pMyProc25(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24)
                         :argv(25));
       when argc = 26;
         myBuf = pMyProc26(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24)
                         :argv(25):argv(26));
       when argc = 27;
         myBuf = pMyProc27(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24)
                         :argv(25):argv(26):argv(27));
       when argc = 28;
         myBuf = pMyProc28(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24)
                         :argv(25):argv(26):argv(27):argv(28));
       when argc = 29;
         myBuf = pMyProc29(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24)
                         :argv(25):argv(26):argv(27):argv(28)
                         :argv(29));
       when argc = 30;
         myBuf = pMyProc30(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24)
                         :argv(25):argv(26):argv(27):argv(28)
                         :argv(29):argv(30));
       when argc = 31;
         myBuf = pMyProc31(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24)
                         :argv(25):argv(26):argv(27):argv(28)
                         :argv(29):argv(30):argv(31));
       when argc = 32;
         myBuf = pMyProc32(argv(1):argv(2):argv(3):argv(4)
                         :argv(5):argv(6):argv(7):argv(8)
                         :argv(9):argv(10):argv(11):argv(12)
                         :argv(13):argv(14):argv(15):argv(16)
                         :argv(17):argv(18):argv(19):argv(20)
                         :argv(21):argv(22):argv(23):argv(24)
                         :argv(25):argv(26):argv(27):argv(28)
                         :argv(29):argv(30):argv(31):argv(32));
       // other?
       other;
         errsSevere(QP2_ERROR_ILECALL_FAIL:sym1);
         return *OFF;
       endsl;

       // if not an aggregate we need to copy rc
       // from PASE ILE BASE to the return area
       // xml is expecting as output
       if piReturn <> *NULL;
         myPtr = %addr(myBuf);
         pCopy = piReturn;
         select;
         when retSize = RESULT_INT8;
           myCopy.chrx =  myCopy2.chrx; 
         when retSize = RESULT_UINT8;
           myCopy.uchrx = myCopy2.uchrx; 
         when retSize = RESULT_INT16;
           myCopy.shortx = myCopy2.shortx; 
         when retSize = RESULT_UINT16;
           myCopy.ushortx = myCopy2.ushortx; 
         when retSize = RESULT_INT32;
           myCopy.intx = myCopy2.intx; 
         when retSize = RESULT_UINT32;
           myCopy.uintx = myCopy2.uintx; 
         when retSize = RESULT_INT64;
           myCopy.longlongx = myCopy2.longlongx; 
         when retSize = RESULT_UINT64;
           myCopy.ulonglongx = myCopy2.ulonglongx;
         when retSize = RESULT_FLOAT64;
           myCopy.doublex = myCopy2.doublex;
         other;
           if retSize > 0;
             cpybytes(piReturn:myPtr:retSize);
           endif;
         endsl;
       endif;

       On-error;
         errsSevere(QP2_ERROR_ILECALL_FAIL:sym1);
         return *OFF;
       Endmon;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * rc = ileExec()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ileExec         B                   export
     D ileExec         PI             1N
     D cmd                             *   value
     D cmdLen                        10i 0 value
     D myMem                           *
     D myLen                         10i 0
     D noGet                          1N   value options(*nopass)
      * vars
     D cmdstr          s           4096A   inz(*BLANKS)
     D mymax           s             10i 0 inz(0)
     D len             s             10i 0 inz(0)
     D rcb             s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D flen            s             10i 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D memI            s             10i 0 inz(0)
     D ptrMemP         s               *   inz(*NULL)
     D memCtl          ds                  likeds(paseRec_t) based(ptrMemP)
     D mytmp           s           1024A   inz(*BLANKS)
     D jobName         s             10A   inz(*BLANKS)
     D jobUserID       s             10A   inz(*BLANKS)
     D jobNbr          s              6A   inz(*BLANKS)
     D jobInfo         ds                  likeds(myJob_t)
     D i               s             10i 0 inz(0)
     D p1              s               *   inz(*NULL)
     D m1              ds                  likeds(over_t) based(p1)
     D p2              s               *   inz(*NULL)
     D m2              ds                  likeds(over_t) based(p2)
      /free
       Monitor;

       // tmp file: /tmp/xmlservice-qsh-name-user-nbr.log
       rcb = ileJob(jobName:jobUserID:jobNbr:jobInfo);
       mytmp = '/tmp/xmlservice-qsh-'
              + %trim(jobName) + '-'
              + %trim(jobUserID) + '-'
              + %trim(jobNbr)
              +'.log';

       // reusable ILE memory buffer 
       memI = cacAddBig(SZOPM:CAC_HEAP_PGM_OPM);
       ptrMemP = cacScanBig(memI);
       myMem = memCtl.paseOrigP;
       mymax = myLen;
       myLen = 0;

       ileEZero();

       // -------------
       // execute command
       // BTW -- Thanks Nathanael BONNET
       // "How many quotes to screw in a lightblub?"
       // "More than i had. Thanks for scanrpl add."
       putenv('QIBM_QSH_CMD_OUTPUT=FILE=' + %trim(mytmp));
       putenv('QIBM_QSH_CMD_ESCAPE_MSG=Y');
       // build escaped STRQSH
       cmdstr = 'STRQSH CMD('''
           + '/usr/bin/qsh -c ''''';
       // V6R1 not support scanrpl (inconceivable)
       //  + %scanrpl( '''' : '''''' : %str(cmd:cmdLen))
       p1 = cmd;
       p2 = %addr(cmdstr) + %len(%trim(cmdstr));
       for i = 1 to cmdLen;
         // null term string (done)
         if m1.char1 = x'00';
           leave;
         // escaped single quotes
         elseif m1.char1 = x'7D';
           m2.char1 = x'7D';
           p2 += 1;
           m2.char1 = x'7D';
           p2 += 1;
           p1 += 1;
         // escaped open
         elseif m1.char1 = '(';
           m2.char1 = '\';
           p2 += 1;
           m2.char1 = '(';
           p2 += 1;
           p1 += 1;
         // escaped close
         elseif m1.char1 = ')';
           m2.char1 = '\';
           p2 += 1;
           m2.char1 = ')';
           p2 += 1;
           p1 += 1;
         // just another byte (copy)
         else;
           m2.bytex = m1.bytex;
           p2 += 1;
           p1 += 1;
         endif;
       endfor;
       //  + ''''''')';
       cmdstr = %trim(cmdstr) + ''''''')';
       len = %len(%trim(cmdstr));
       cmdexec(cmdstr:len);

       flen = ipcBotXMLf(myMem:mymax:mytmp);
       pCopy = myMem + flen;
       myCopy.bytex = x'00';
       myLen = strlen(myMem);
       rc1 = ipcRmvXMLf();

       // -------------
       // error
       On-error;
         ileSetSts();
         rcb = *OFF;
       Endmon;

       return rcb;
      /end-free
     P                 E


