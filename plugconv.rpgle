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
      /copy plugipc_h
      /copy plugile_h
      /copy plugmri_h
      /copy plugerr_h
      /copy plugpase_h
      /copy plugcach_h
      /copy plugxml_h
      /copy plugconv_h

      *****************************************************
      * ipc globals
      *****************************************************
     D sHint           s             60A   inz(*BLANKS)
     D sPadPtrI        s             10i 0 inz(0)
     D sConvPtrI       s             10i 0 inz(0)
     D sCCSIDpase      S             10i 0 inz(0)
     D sCCSIDile       S             10i 0 inz(0)

     D sHexCBeg        S              5A   inz('<hex>')
     D sHexCEnd        S              6A   inz('</hex>')

     D padAlloc        PR             1N
     D  buffLen                      10i 0

     D convAlloc       PR             1N
     D  buffLen                      10i 0

     D convAlloc2      PR             1N
     D  buffPtr                        *   Value
     D  buffLen                      10i 0

     D trimConv        PR             1N
     D  pTgt                           *   Value
     D  trimSz                       10i 0
     D  nMax                         10i 0 Value 
     D  pad                          10i 0 Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)

     D padConv         PR             1N
     D  pTgt                           *   Value
     D  trimSz                       10i 0 Value
     D  nMax                         10i 0 Value 
     D  pad                          10i 0 Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)

      * reserved unicode chars 
     D wlt             S              1C   inz(%UCS2('<'))                      &lt;
     D wgt             S              1C   inz(%UCS2('>'))                      &gt;
     D wamp            S              1C   inz(%UCS2('&'))                      &amp;
     D wquot           S              1C   inz(%UCS2('"'))                      &quot;
     D wapos           S              1C   inz(%UCS2(''''))                     &apos;
      * reserved job ccsid chars 
     D clt             S              1C   inz(*blank)                          &lt;
     D cgt             S              1C   inz(*blank)                          &gt;
     D camp            S              1C   inz(*blank)                          &amp;
     D cquot           S              1C   inz(*blank)                          &quot;
     D capos           S              1C   inz(*blank)                          &apos;
      * reserved unicode  
     D welt            S              4C   inz(%UCS2('&lt;'))                   &lt;
     D wegt            S              4C   inz(%UCS2('&gt;'))                   &gt;
     D weamp           S              5C   inz(%UCS2('&amp;'))                  &amp;
     D wequot          S              6C   inz(%UCS2('&quot;'))                 &quot;
     D weapos          S              6C   inz(%UCS2('&apos;'))                 &apos
      * reserved job ccsid chars 
     D celt            S              4A                                        &lt;
     D cegt            S              4A   inz(*blank)                          &gt;
     D ceamp           S              5A   inz(*blank)                          &amp;
     D cequot          S              6A   inz(*blank)                          &quot;
     D ceapos          S              6A   inz(*blank)                          &apos;
      * flag to inidcate coverting to job ccsid is done
     D escpCvtd        S              1N   inz(*OFF)

      *****************************************************
      * padAlloc
      * return (*ON-good,*OFF-error)
      *****************************************************
     P padAlloc        B
     D padAlloc        PI             1N
     D  buffLen                      10i 0
      * vars
     D rcb             s              1N   inz(*OFF)
     D aPadPtrP        s               *   inz(*NULL)
     D aPadSz          s             10i 0 inz(0)
      /free
       if sPadPtrI <> 0;
         aPadPtrP = cacScanBig(sPadPtrI:aPadSz);
         if aPadPtrP = *NULL;
           sPadPtrI = 0;
         elseif aPadSz < buffLen;
           cacClrBig(sPadPtrI);
           sPadPtrI = 0;
         endif;
       endif;
       if sPadPtrI = 0;
         sPadPtrI = cacAddBig(buffLen:CAC_HEAP_ILE_REUSE);
       endif;
       if sPadPtrI = 0;
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * convAlloc
      * return (*ON-good,*OFF-error)
      *****************************************************
     P convAlloc       B
     D convAlloc       PI             1N
     D  buffLen                      10i 0
      * vars
     D rcb             s              1N   inz(*OFF)
     D aConvPtrP       s               *   inz(*NULL)
     D aConvSz         s             10i 0 inz(0)
      /free
       if sConvPtrI <> 0;
         aConvPtrP = cacScanBig(sConvPtrI:aConvSz);
         if aConvPtrP = *NULL;
           sConvPtrI = 0;
         elseif aConvSz < buffLen;
           cacClrBig(sConvPtrI);
           sConvPtrI = 0;
         endif;
       endif;
       if sConvPtrI = 0;
         sConvPtrI = cacAddBig(buffLen:CAC_HEAP_ILE_REUSE);
       endif;
       if sConvPtrI = 0;
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * convAlloc2
      * return (*ON-good,*OFF-error)
      *****************************************************
     P convAlloc2      B
     D convAlloc2      PI             1N
     D  buffPtr                        *   Value
     D  buffLen                      10i 0
      * vars
     D rcb             s              1N   inz(*OFF)
     D maxBytes        s             10i 0 inz(0)
      /free
       maxBytes   = bigTrim(buffPtr:buffLen);
       if buffLen < maxBytes;
         maxBytes = buffLen;
       endif;
       rcb = convAlloc(maxBytes);
       if rcb = *OFF;
         return *OFF;
       endif;
       buffLen = maxBytes;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * CCSID conversion
      * return (>-1 - good, <0 - error)
      *****************************************************
     P convOpen        B                   export
     D convOpen        PI            10i 0
     D  fromCCSID                    10i 0 Value
     D  toCCSID                      10i 0 Value
     D  conv                               likeds(ciconv_t)
      * vars
     D rc              s             10i 0 inz(0)
      /free
       Monitor;

       sHint =  'convOpen '
             + CALL_MSG_CONV_SOURCE + ':' + %char(fromCCSID)
             + CALL_MSG_CONV_TARGET + ':' + %char(toCCSID);

       // qtqCode_t:
       //             to         from
       // qtqCCSID    0 - job    PaseCCSID
       // qtqAltCnv   0 - na     0 - IBM default
       // qtqAltSub   0 - na     0 - not returned to initial shift state
       // qtqAltSft   0 - na     0 - substitution characters not returned
       // qtqOptLen   0 - na     0 - inbytesleft parameter must be specified
       // qtqMixErr   0 - na     0 - no error dbcs
       // qtqRsv      0 - na     0 - na
       cacNulCnv(conv);

       // If unsuccessful, QtqIconvOpen() returns -1 
       // and in the return value of the conversion 
       // descriptor and sets errno to indicate the error.
       conv.fromcode.qtqCCSID = fromCCSID;
       conv.tocode.qtqCCSID = toCCSID;
       conv.conv = iconvOpen(conv.tocode:conv.fromcode);
       if conv.conv.rtn < 0;
         errsCritical(CALL_ERROR_CONV_FAIL:sHint);
         rc = -1;
       endif;

       On-error;
         rc = -1;
       Endmon;

       if rc < 0;
         memset(%addr(conv.tocode):0:%size(conv.tocode));
         memset(%addr(conv.fromcode):0:%size(conv.fromcode));
         memset(%addr(conv.conv):0:%size(conv.conv));
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * CCSID conversion
      * return (>-1 - good, <0 - error)
      *****************************************************
     P convClose       B                   export
     D convClose       PI            10i 0
     D  conv                               likeds(ciconv_t)
      * vars
     D rc              s             10i 0 inz(0)
      /free
       Monitor;

       sHint = 'convClose '
             + CALL_MSG_CONV_SOURCE + ':' + %char(conv.fromcode.qtqCCSID)
             + CALL_MSG_CONV_TARGET + ':' + %char(conv.tocode.qtqCCSID);

       iconvClose(conv.conv);

       On-error;
         rc = -1;
       Endmon;

       memset(%addr(conv.tocode):0:%size(conv.tocode));
       memset(%addr(conv.fromcode):0:%size(conv.fromcode));
       memset(%addr(conv.conv):0:%size(conv.conv));

       return rc;
      /end-free
     P                 E


      *****************************************************
      * CCSID conversion
      * return (>-1 - good, <0 - error)
      *****************************************************
     P convCall        B                   export
     D convCall        PI            10i 0
     D  conv                               likeds(ciconv_t)
     D  buffPtr                        *
     D  buffLen                      10i 0
     D  outPtr                         *   options(*nopass)
     D  outLen                       10i 0 options(*nopass)
      * vars
     D aConvPtrP       s               *   inz(*NULL)
     D aConvSz         s             10i 0 inz(0)
     D fromPtr         s               *   inz(*NULL)
     D fromBytes       s             10i 0 inz(0)
     D toPtr           s               *   inz(*NULL)
     D toBytes         s             10i 0 inz(0)
     D toMax           s             10i 0 inz(0)
     D maxBytes        s             10i 0 inz(0)
     D maxOut          s             10i 0 inz(0)
     D maxZero         s             10i 0 inz(0)
     D rcb             s              1N   inz(*OFF)
     D rc              s             10i 0 inz(0)
     D isOpen          s              1N   inz(*OFF)
      /free
       Monitor;

       sHint =  'convCall '
             + CALL_MSG_CONV_SOURCE + ':' + %char(conv.fromcode.qtqCCSID)
             + CALL_MSG_CONV_TARGET + ':' + %char(conv.tocode.qtqCCSID);

       // size_t iconv (cd, inbuf, inbytesleft, outbuf, outbytesleft)
       // inbytesleft  - number of bytes not converted input buffer
       // outbytesleft - available bytes to end output buffer
       // If an error occurs, iconv() returns -1 
       // in the return value, and sets errno to indicate the error.
       maxBytes   = buffLen;
       rcb = convAlloc2(buffPtr:maxBytes);
       if rcb = *OFF;
         errsCritical(CALL_ERROR_CONV_FAIL:sHint);
         return -1;
       endif;
       fromPtr    = buffPtr;
       fromBytes  = maxBytes;
       if %parms >= 5;
         toPtr      = outPtr;
         toBytes    = outLen;
       else;
         aConvPtrP  = cacScanBig(sConvPtrI:aConvSz);
         toPtr      = aConvPtrP;
         toBytes    = aConvSz;
         if toBytes >= buffLen;
           toBytes  = buffLen;
         endif;
         rcb = convAlloc(toBytes);
         if rcb = *OFF;
           errsCritical(CALL_ERROR_CONV_FAIL:sHint);
           return -1;
         endif;
       endif;
       // convert
       toMax = toBytes;
       rc = iconv(conv.conv
                 :%addr(fromPtr):%addr(fromBytes)
                 :%addr(toPtr):%addr(toBytes));
       maxBytes = toMax - toBytes;
       // did it work?
       if rc > -1;
         // out buffer provided (no copy)
         if %parms >= 5;
           toPtr = outPtr;
           maxOut = outLen;
           // how many bytes unused output buffer?
           outLen = toBytes;
         // copy result into single buffer
         else;
           toPtr = buffPtr;
           maxOut = buffLen;
           // copy result back single buffer
           cpybytes(buffPtr:aConvPtrP:maxBytes);
         endif;
         // possible null terminate
         maxZero = maxOut - maxBytes;
         if maxZero > 4096;
           maxZero = 4096;
         endif;
         if maxZero > 0;
            memset(toPtr + maxBytes:0:maxZero);
         endif;
         // how many input bytes did not convert?
         buffLen = fromBytes;
       endif;

       On-error;
         rc = -1;
       Endmon;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * CCSID conversion
      * return (>-1 - good, <0 - error)
      *****************************************************
     P convCCSID       B                   export
     D convCCSID       PI            10i 0
     D  fromCCSID                    10i 0 Value
     D  toCCSID                      10i 0 Value
     D  buffPtr                        *
     D  buffLen                      10i 0
     D  outPtr                         *   options(*nopass)
     D  outLen                       10i 0 options(*nopass)
      * vars
     D rc              s             10i 0 inz(0)
     D rcb             s              1N   inz(*OFF)
     D conv            ds                  likeds(ciconv_t)
      /free
       sHint = CALL_MSG_CONV_SOURCE + ':' + %char(fromCCSID)
             + CALL_MSG_CONV_TARGET + ':' + %char(toCCSID);

       // check reality
       if fromCCSID < 0;
         fromCCSID = 0;
       endif;
       if toCCSID < 0;
         toCCSID = 0;
       endif;
       if fromCCSID = 0 and toCCSID = 0;
         return 0;
       endif;
       
       cacNulCnv(conv);
       rcb = cacScanCnv(fromCCSID:toCCSID:conv);
       if rcb = *OFF;
         rc = convOpen(fromCCSID:toCCSID:conv);
         if rc > -1;
           rcb = *ON;
           cacAddCnv(conv);
         endif;
       endif;

       if rcb = *ON;
         if %parms >= 6;
           rc = convCall(conv:buffPtr:buffLen:outPtr:outLen);
         else;
           rc = convCall(conv:buffPtr:buffLen);
         endif;
       else;
          rc = -1;
       endif;

       if rc < 0;
         errsCritical(CALL_ERROR_CONV_FAIL:sHint);
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * CCSID conversion
      * return (>-1-good,<0-error)
      *****************************************************
     P convCCSID2      B                   export
     D convCCSID2      PI            10i 0
     D  fromCCSID                    10i 0 Value
     D  toCCSID                      10i 0 Value
     D  buffPtr                        *   Value
     D  buffLen                      10i 0 Value
     D  outPtr                         *   Value options(*nopass)
     D  outLen                       10i 0 Value options(*nopass)
      /free
       if %parms >= 6;
         return convCCSID(fromCCSID:toCCSID:buffPtr:buffLen:outPtr:outLen);
       endif;
       return convCCSID(fromCCSID:toCCSID:buffPtr:buffLen);
      /end-free
     P                 E


      *****************************************************
      * convPASE - fix error not use QDCXLATE
      * return (NA)
      * Note (was):
      *   QP2_2_ASCII  const('QTCPASC')
      *   QP2_2_EBCDIC const('QTCPEBC')
      *****************************************************
     P ccsidPASE       B                   export
     D ccsidPASE       PI
     D   myccsid                     10i 0 value
      /free
       sCCSIDpase = myccsid;
      /end-free
     P                 E

     P ccsidILE        B                   export
     D ccsidILE        PI
     D   myccsid                     10i 0 value
      /free
       sCCSIDile = myccsid;
      /end-free
     P                 E
     
     P getccsidPASE...
     P                 B                   export
     D getccsidPASE...
     D                 PI            10i 0
      /free
       return sCCSIDpase;
      /end-free
     P                 E

     P getccsidILE...
     P                 B                   export
     D getccsidILE...
     D                 PI            10i 0
      /free
       return sCCSIDile;
      /end-free
     P                 E


      *****************************************************
      * CCSID conversion
      * return (>-1 good, <0 error)
      *****************************************************
     P convUTF16       B                   export
     D convUTF16       PI            10i 0
     D   buffPtr                       *   value
     D   maxLen                      10i 0 value
     D   toILE                        1N   value
     D   outPtr                        *   value options(*nopass)
     D   outLen                      10i 0 value options(*nopass)
      * vars
     D rc              S             10i 0 inz(0)
     D paseCCSID       S             10i 0 inz(0)
     D ileCCSID        S             10i 0 inz(0)
     D fromCCSID       S             10i 0 inz(0)
     D toCCSID         S             10i 0 inz(0)
     D pIn             s               *   inz(*NULL)
     D paseIn          S             10i 0 inz(0)
     D paseData        S          32766A   inz(*BLANKS)
     D pOut            s               *   inz(*NULL)
     D paseOut         S             10i 0 inz(0)
     D retLen          S             10i 0 inz(0)
     D savLen          S             10i 0 inz(0)
     D pTmp            s               *
     D myCopy          ds                  likeds(over_t) based(pTmp)
      /free
       // pase CCSID validation
       paseCCSID = 1200;
       // ile CCSID validation
       ileCCSID = sCCSIDile;
       if ileCCSID < 0;
         ileCCSID = 0;
       endif;
       // PASE<>ILE conversion direction?
       if toILE = *ON;
         fromCCSID = paseCCSID;
         toCCSID = ileCCSID;
       else;
         fromCCSID = ileCCSID;
         toCCSID = paseCCSID;
       endif;
       // input buffer
       pIn = buffPtr;
       paseIn = maxlen;
       // output buffer supplied
       if %parms >= 5;
         pOut = outPtr;
         paseOut = outLen;
         pTmp = pOut;
       // output buffer temp
       else;
         pOut = %addr(paseData);
         paseOut = maxLen;
         pTmp = pIn;
       endif;
       savLen = paseOut;
       rc = convCCSID(fromCCSID:toCCSID
              :pIn:paseIn:pOut:paseOut);
       if rc > -1;
         retLen = savLen - paseOut;
         if retLen > 0;
           // need copy out (single buffer)
           if %parms < 4;
             cpybytes(pIn:pOut:retLen);
           endif;
         else;
           retLen = 0;
         endif;
         // null terminate
         pTmp += retLen;
         myCopy.bytex = x'00';
       else;
         retLen = rc;
       endif;
       return retLen;
      /end-free
     P                 E



      *****************************************************
      * CCSID conversion
      * return (>-1 good, <0 error)
      *****************************************************
     P convPASE        B                   export
     D convPASE        PI            10i 0
     D   buffPtr                       *   value
     D   maxLen                      10i 0 value
     D   toILE                        1N   value
     D   outPtr                        *   value options(*nopass)
     D   outLen                      10i 0 value options(*nopass)
      * vars
     D rc              S             10i 0 inz(0)
     D paseCCSID       S             10i 0 inz(0)
     D ileCCSID        S             10i 0 inz(0)
     D fromCCSID       S             10i 0 inz(0)
     D toCCSID         S             10i 0 inz(0)
     D pIn             s               *   inz(*NULL)
     D paseIn          S             10i 0 inz(0)
     D paseData        S          32766A   inz(*BLANKS)
     D pOut            s               *   inz(*NULL)
     D paseOut         S             10i 0 inz(0)
     D retLen          S             10i 0 inz(0)
     D savLen          S             10i 0 inz(0)
     D pTmp            s               *
     D myCopy          ds                  likeds(over_t) based(pTmp)
      /free
       // pase CCSID validation
       paseCCSID = sCCSIDpase;
       if paseCCSID <= 0;
         paseCCSID = PaseLstCCSID();
       endif;
       // ile CCSID validation
       ileCCSID = sCCSIDile;
       if ileCCSID < 0;
         ileCCSID = 0;
       endif;
       // PASE<>ILE conversion direction?
       if toILE = *ON;
         fromCCSID = paseCCSID;
         toCCSID = ileCCSID;
       else;
         fromCCSID = ileCCSID;
         toCCSID = paseCCSID;
       endif;
       // input buffer
       pIn = buffPtr;
       paseIn = maxlen;
       // output buffer supplied
       if %parms >= 5;
         pOut = outPtr;
         paseOut = outLen;
         pTmp = pOut;
       // output buffer temp
       else;
         pOut = %addr(paseData);
         paseOut = maxLen;
         pTmp = pIn;
       endif;
       savLen = paseOut;
       rc = convCCSID(fromCCSID:toCCSID
              :pIn:paseIn:pOut:paseOut);
       if rc > -1;
         retLen = savLen - paseOut;
         if retLen > 0;
           // need copy out (single buffer)
           if %parms < 4;
             cpybytes(pIn:pOut:retLen);
           endif;
         else;
           retLen = 0;
         endif;
         // null terminate
         pTmp += retLen;
         myCopy.bytex = x'00';
       else;
         retLen = rc;
       endif;
       return retLen;
      /end-free
     P                 E

      *****************************************************
      * convert hex 2 bin
      * return (*ON-good,*OFF-error)
      *****************************************************
     P convX2B         B                   export
     D convX2B         PI             1N
     D  pTarget                        *   Value 
     D  nLength                      10i 0 Value 
      * vars
     D aConvPtrP       s               *   inz(*NULL)
     D trimSz          s             10i 0 inz(0)
     d strHalf         s             10i 0 inz(0)
     d strTwo          s             10i 0 inz(2)
     D rcb             s              1N   inz(*OFF)
     D maxBytes        s             10i 0 inz(0)
     D pOut            s             10i 0 inz(0)
      /free
       // assure allocation
       maxBytes  = nLength;
       rcb = convAlloc2(pTarget:maxBytes);
       if rcb = *OFF;
         return *OFF;
       endif;
       // do conversion
       if maxBytes > 1;
         strHalf = %div(maxBytes:strTwo);
       else;
         return *OFF;
       endif;
       aConvPtrP  = cacScanBig(sConvPtrI);
       trimSz = cpyX2Bin(aConvPtrP:pTarget:strHalf);
       if trimSz <= 0;
         return *OFF;
       endif;
       // zero back buffer
       if maxBytes-trimSz > 0;
         memset(aConvPtrP+trimSz:x'00':maxBytes-trimSz);
       endif;
       // copy out
       cpybytes(pTarget:aConvPtrP:maxBytes);
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * convert hex 2 bin
      * return (n - number of binary bytes size)
      *****************************************************
     P cpyX2Bin        B                   export
     D cpyX2Bin        PI            10i 0
     D  pTarget                        *   Value 
     D  pSource                        *   Value 
     D  nLength                      10U 0 Value 
      * vars
     D inbr            s             10U 0 inz(0)
     D hnbr            s             10U 0 inz(0)
     D lnbr            s             10U 0 inz(0)
     D ptCopy          s               *   inz(*NULL)
     D tCopy           ds                  likeds(over_t) based(ptCopy)
     D psCopy          s               *   inz(*NULL)
     D sCopy           ds                  likeds(over_t) based(psCopy)
      /free
       ptCopy = pTarget;
       psCopy = pSource;
       dow psCopy < pSource + nLength*2;
         // high bits
         select;
         when sCopy.bytex='F' or sCopy.bytex='f';
          hnbr = 15;
         when sCopy.bytex='E' or sCopy.bytex='e';
          hnbr = 14;
         when sCopy.bytex='D' or sCopy.bytex='d';
          hnbr = 13;
         when sCopy.bytex='C' or sCopy.bytex='c';
          hnbr = 12;
         when sCopy.bytex='B' or sCopy.bytex='b';
          hnbr = 11;
         when sCopy.bytex='A' or sCopy.bytex='a';
          hnbr = 10;
         when sCopy.bytex='9';
          hnbr = 9;
         when sCopy.bytex='8';
          hnbr = 8;
         when sCopy.bytex='7';
          hnbr = 7;
         when sCopy.bytex='6';
          hnbr = 6;
         when sCopy.bytex='5';
          hnbr = 5;
         when sCopy.bytex='4';
          hnbr = 4;
         when sCopy.bytex='3';
          hnbr = 3;
         when sCopy.bytex='2';
          hnbr = 2;
         when sCopy.bytex='1';
          hnbr = 1;
         // other?
         other;
           hnbr = 0;
         endsl;
         psCopy += 1;
         // low bits
         select;
         when sCopy.bytex='F' or sCopy.bytex='f';
          lnbr = 15;
         when sCopy.bytex='E' or sCopy.bytex='e';
          lnbr = 14;
         when sCopy.bytex='D' or sCopy.bytex='d';
          lnbr = 13;
         when sCopy.bytex='C' or sCopy.bytex='c';
          lnbr = 12;
         when sCopy.bytex='B' or sCopy.bytex='b';
          lnbr = 11;
         when sCopy.bytex='A' or sCopy.bytex='a';
          lnbr = 10;
         when sCopy.bytex='9';
          lnbr = 9;
         when sCopy.bytex='8';
          lnbr = 8;
         when sCopy.bytex='7';
          lnbr = 7;
         when sCopy.bytex='6';
          lnbr = 6;
         when sCopy.bytex='5';
          lnbr = 5;
         when sCopy.bytex='4';
          lnbr = 4;
         when sCopy.bytex='3';
          lnbr = 3;
         when sCopy.bytex='2';
          lnbr = 2;
         when sCopy.bytex='1';
          lnbr = 1;
         // other?
         other;
           lnbr = 0;
         endsl;
         psCopy += 1;
         // copy and next
         tCopy.uchrx = hnbr * 16 + lnbr;
         ptCopy += 1;
         inbr += 1;
       enddo;
       return inbr;
      /end-free
     P                 E


      *****************************************************
      * copy convert bin 2 hex
      * return (*ON-good,*OFF-error)
      *****************************************************
     P convB2X         B                   export
     D convB2X         PI             1N
     D  pTarget                        *   Value 
     D  nLength                      10i 0 Value 
      * vars
     D aConvPtrP       s               *   inz(*NULL)
     D trimSz          s             10i 0 inz(0)
     D rcb             s              1N   inz(*OFF)
     D maxBytes        s             10i 0 inz(0)
      /free
       // assure allocation
       maxBytes   = nLength;
       rcb = convAlloc2(pTarget:maxBytes);
       if rcb = *OFF;
         return *OFF;
       endif;
       aConvPtrP  = cacScanBig(sConvPtrI);
       trimSz = cpyB2Hex(aConvPtrP:pTarget:maxBytes);
       if trimSz <= 0;
         return *OFF;
       endif;
       // copy out
       cpybytes(pTarget:aConvPtrP:trimSz);
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * convert hex 2 bin
      * return (n - number of hex character bytes size string)
      *****************************************************
     P cpyB2Hex        B                   export
     D cpyB2Hex        PI            10i 0
     D  pTarget                        *   Value 
     D  pSource                        *   Value 
     D  nLength                      10U 0 Value 
      * vars
     D itrim           s             10U 0 inz(0)
     D inbr            s             10U 0 inz(0)
     D hnbr            s             10U 0 inz(0)
     D lnbr            s             10U 0 inz(0)
     D hchr            s              1A   inz(*BLANKS)
     D lchr            s              1A   inz(*BLANKS)
     D ptCopy          s               *   inz(*NULL)
     D tCopy           ds                  likeds(over_t) based(ptCopy)
     D psCopy          s               *   inz(*NULL)
     D sCopy           ds                  likeds(over_t) based(psCopy)
      /free
       ptCopy = pTarget;
       psCopy = pSource;
       dow ptCopy < pTarget + nLength*2;
         // high bits
         hnbr = sCopy.uchrx;
         select;
         when hnbr>=240; // x'FO'
          hchr = 'F';
          lnbr = hnbr - 240;
         when hnbr>=224 and hnbr<240; // x'E0'
          hchr = 'E';
          lnbr = hnbr - 224;
         when hnbr>=208 and hnbr<224; // x'D0'
          hchr = 'D';
          lnbr = hnbr - 208;
         when hnbr>=192 and hnbr<208; // x'C0'
          hchr = 'C';
          lnbr = hnbr - 192;
         when hnbr>=176 and hnbr<192; // x'B0'
          hchr = 'B';
          lnbr = hnbr - 176;
         when hnbr>=160 and hnbr<176; // x'A0'
          hchr = 'A';
          lnbr = hnbr - 160;
         when hnbr>=144 and hnbr<160; // x'90'
          hchr = '9';
          lnbr = hnbr - 144;
         when hnbr>=128 and hnbr<144; // x'80'
          hchr = '8';
          lnbr = hnbr - 128;
         when hnbr>=112 and hnbr<128; // x'70'
          hchr = '7';
          lnbr = hnbr - 112;
         when hnbr>=96 and hnbr<112; // x'60'
          hchr = '6';
          lnbr = hnbr - 96;
         when hnbr>=80 and hnbr<96; // x'50'
          hchr = '5';
          lnbr = hnbr - 80;
         when hnbr>=64 and hnbr<80; // x'40'
          hchr = '4';
          lnbr = hnbr - 64;
         when hnbr>=48 and hnbr<64; // x'30'
          hchr = '3';
          lnbr = hnbr - 48;
         when hnbr>=32 and hnbr<48; // x'20'
          hchr = '2';
          lnbr = hnbr - 32;
         when hnbr>=16 and hnbr<32; // x'10'
          hchr = '1';
          lnbr = hnbr - 16;
         // other?
         other;
          hchr = '0';
          lnbr = hnbr;
         endsl;
         // low bits
         select;
         when lnbr>=15; // x'0F'
          lchr = 'F';
         when lnbr>=14 and lnbr<15; // x'0E'
          lchr = 'E';
         when lnbr>=13 and lnbr<14; // x'0D'
          lchr = 'D';
         when lnbr>=12 and lnbr<13; // x'0C'
          lchr = 'C';
         when lnbr>=11 and lnbr<12; // x'0B'
          lchr = 'B';
         when lnbr>=10 and lnbr<11; // x'0A'
          lchr = 'A';
         when lnbr>=9 and lnbr<10; // x'09'
          lchr = '9';
         when lnbr>=8 and lnbr<9; // x'08'
          lchr = '8';
         when lnbr>=7 and lnbr<8; // x'07'
          lchr = '7';
         when lnbr>=6 and lnbr<7; // x'06'
          lchr = '6';
         when lnbr>=5 and lnbr<6; // x'05'
          lchr = '5';
         when lnbr>=4 and lnbr<5; // x'04'
          lchr = '4';
         when lnbr>=3 and lnbr<4; // x'03'
          lchr = '3';
         when lnbr>=2 and lnbr<3; // x'02'
          lchr = '2';
         when lnbr>=1 and lnbr<2; // x'01'
          lchr = '1';
         // other?
         other;
          lchr = '0';
         endsl;
         psCopy += 1;
         // copy and next
         tCopy.bytex = hchr;
         ptCopy += 1;
         inbr += 1;
         tCopy.bytex = lchr;
         ptCopy += 1;
         inbr += 1;
         if hnbr > 0 or lnbr > 0;
           itrim = inbr;
         endif;
       enddo;
       return itrim; // use to be inbr (padded zeros)
      /end-free
     P                 E


      *****************************************************
      * convert misc
      * return (*ON,*OFF)
      *****************************************************


      *****************************************************
      * isDigit
      * return (*ON-true,*OFF-false)
      *****************************************************
     P isDigit         B                   export
     D isDigit         PI             1N
     D  pSource                        *   Value 
     D  nLength                      10i 0 Value 
      * vars
     D psCopy          s               *   inz(*NULL)
     D sCopy           ds                  likeds(over_t) based(psCopy)
      /free
       psCopy = pSource;
       dow psCopy < pSource + nLength;
         if sCopy.bytex='9'
         or sCopy.bytex='8'
         or sCopy.bytex='7'
         or sCopy.bytex='6'
         or sCopy.bytex='5'
         or sCopy.bytex='4'
         or sCopy.bytex='3'
         or sCopy.bytex='2'
         or sCopy.bytex='1'
         or sCopy.bytex='0';
           // ok
         else;
           return *OFF;
         endif;
         psCopy += 1;
       enddo;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * toUpperSafe
      * return (*ON-good,*OFF-error)
      *****************************************************
     P toUpperSafe...
     P                 B                   export
     D toUpperSafe...
     D                 PI             1N
     D  pSource                        *   Value 
     D  nLength                      10i 0 Value 
      * vars
     D psCopy          s               *   inz(*NULL)
     D sCopy           ds                  likeds(over_t) based(psCopy)
     D myon_t          DS                  qualified based(Template)
     D  fillx                         3a
     D  bytex                         1a
     D myInt1          s             10i 0 inz(0)
     D piCopy1         s               *   inz(%addr(myInt1))
     D iCopy1          ds                  likeds(myon_t) based(piCopy1)
     D myInt2          s             10i 0 inz(0)
     D piCopy2         s               *   inz(%addr(myInt2))
     D iCopy2          ds                  likeds(myon_t) based(piCopy2)
      /free
       psCopy = pSource;
       // do not convert double qoute "BothUpLow"
       if sCopy.bytex = '"';
         return *ON;
       endif;
       dow psCopy < pSource + nLength;
         myInt1 = 0;
         myInt2 = 0;
         iCopy1.bytex = sCopy.bytex;
         if islower(myInt1) > 0;
           myInt2 = toupper(myInt1);
           sCopy.bytex = iCopy2.bytex;
         endif;
         psCopy += 1;
       enddo;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * convert w/pad minimum characters
      * return (*ON - good,*OFF - bad)
      *****************************************************
     P trimConv        B
     D trimConv        PI             1N
     D  pTgt                           *   Value
     D  trimSz                       10i 0
     D  nMax                         10i 0 Value 
     D  pad                          10i 0 Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)
      * vars
     D rc              s              1N   inz(*ON)
     D i               s             10i 0 inz(0)
     D convRc          s             10i 0 inz(0)
      /free
       // pad fill tail part buffer
       if nMax-trimSz > 0;
         memset(pTgt+trimSz:pad:nMax-trimSz);
       endif;

       // current size
       trimSz = bigTrim(pTgt:nMax);

       // ccsid conversions
       if cntCCSID > 0;
         for i = 1 to cntCCSID;
           convRc = 
             convCCSID2(srcCCSID(i):tgtCCSID(i)
                       :pTgt:nMax);
           if convRc < 0;
             rc = *OFF;
           endif;
           // new convert size
           trimSz = bigTrim(pTgt:nMax);
           // pad fill tail part buffer
           if nMax-trimSz > 0;
             memset(pTgt+trimSz:pad:nMax-trimSz);
           endif;
         endfor;
       endif;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * convert w/pad full characters
      * return (*ON - good,*OFF - bad)
      *****************************************************
     P padConv         B
     D padConv         PI             1N
     D  pTgt                           *   Value
     D  trimSz                       10i 0 Value
     D  nMax                         10i 0 Value 
     D  pad                          10i 0 Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)
      * vars
     D rc              s              1N   inz(*ON)
     D i               s             10i 0 inz(0)
     D convRc          s             10i 0 inz(0)
      /free
       // pad fill tail part buffer
       if nMax-trimSz > 0;
         memset(pTgt+trimSz:pad:nMax-trimSz);
       endif;
       // ccsid conversions
       if cntCCSID > 0;
         for i = 1 to cntCCSID;
           convRc = 
             convCCSID2(srcCCSID(i):tgtCCSID(i)
                       :pTgt:nMax);
           if convRc < 0;
             rc = *OFF;
           endif;
         endfor;
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * convert fill character
      * return (*ON - error,*OFF - good)
      *****************************************************
     P fillChar        B                   export
     D fillChar        PI             1N
     D  pTgt                           *   Value
     D  tgtMax                       10i 0 Value 
     D  pSrc                           *   Value 
     D  nLength                      10i 0 Value 
     D  trimSz                       10i 0
     D  pad                          10i 0 Value 
     D  isVary                        1A   Value 
     D  isHex                         1N   Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)
     D  rmCDATA                       1N   value
     D  rmLF                          1N   value
     D  rmQuote                       1N   value
      * vars
     D rc              s              1N   inz(*ON)
     d strHalf         s             10i 0 inz(0)
     d strTwo          s             10i 0 inz(2)
     D maxBytes        s             10i 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
      /free
       trimSz = 0;
       
       // varying length field
       pCopy = pTgt;
       if isVary = XML_VARY_ON;
         myCopy.shortx = nLength;
         pCopy += 2;
       elseif isVary = XML_VARY_4;
         myCopy.intx = nLength;
         pCopy += 4;
       endif;

       // total size actual in bytes
       // double byte safe (i think)
       if nLength > 0;
         maxBytes = bigTrim(pSrc:nLength);
       endif;

       // any work to do?
       if maxBytes > 0;
         if isHex = *ON;
           // <data type='5b'>F0F1F2CDEF</data>
           // which is strHalf = strlen(string)/2 = 5b
           strHalf = %div(maxBytes:strTwo);
           // truncate
           if strHalf > nLength;
             strHalf = nLength;
           endif;
           // copy out string hex to binary
           // return nbr of binary bytes copied
           if strHalf > 0;
             trimSz = cpyX2Bin(pCopy:pSrc:strHalf);
           endif;
         else;
           if maxBytes > nLength;
             trimSz = nLength;
           else;
             trimSz = maxBytes;
           endif;
           // copy out string
           if trimSz > 0;
             cpybytes(pCopy:pSrc:trimSz);
           endif;
         endif;
       endif;


       // convert and pad
       // pCopy is pTgt, so source is untouched
       rc = trimConv(pCopy:trimSz:tgtMax:pad
                   :cntCCSID:srcCCSID:tgtCCSID);

       // take out junk (@ADC 1.7.4)
       if trimSz > 0 and (rmCDATA = *ON or rmLF = *ON or rmQuote = *ON);
         bigJunkOut(pCopy:pCopy+trimSz:rmCDATA:rmLF:rmQuote);
         trimSz = bigTrim(pCopy:trimSz);
       endif;

       // varying length field
       pCopy = pTgt;
       if isVary = XML_VARY_ON;
         myCopy.shortx = trimSz;
         pCopy += 2;
       elseif isVary = XML_VARY_4;
         myCopy.intx = trimSz;
         pCopy += 4;
       endif;
       

       return rc;
      /end-free
     P                 E

      *****************************************************
      * convert trim character
      * return (*ON - error,*OFF - good)
      *****************************************************
     P trimChar        B                   export
     D trimChar        PI             1N
     D  pTgt                           *   Value
     D  tgtMax                       10i 0 Value
     D  pSrc                           *   Value 
     D  srcMax                       10i 0 Value 
     D  trimSz                       10i 0
     D  pad                          10i 0 Value 
     D  isVary                        1A   Value 
     D  toHex                         1N   Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)
     D  rmCDATA                       1N   value
     D  rmLF                          1N   value
     D  rmQuote                       1N   value
     D  addHex                        1N   value
     D  addCDATA                      1N   value
      * vars
     D rc              s              1N   inz(*ON)
     D nLength         s             10i 0 inz(0)
     D nMax            s             10i 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D aPadPtrP        s               *   inz(*NULL)
     D aPadSz          s             10i 0 inz(0)
     d szHex           s             10i 0 inz(0)
     d szCDATA         s             10i 0 inz(0)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
      /free
       
       trimSz = 0;
       
       // <hex> ... </hex>
       // ooooo
       if addHex = *ON;
         szHex = %size(sHexCBeg) + %size(sHexCEnd);
         if tgtMax < 1 or tgtMax > szHex;
           pCopy = pTgt;
           cpybytes(pCopy:%addr(sHexCBeg):%size(sHexCBeg));
           pTgt += %size(sHexCBeg);
           if tgtMax > 0;
               tgtMax -= szHex;
           endif;
         else;
           return *OFF;
         endif;
       endif;
       
       // <![CDATA[...]]>
       // ooooooooo
       if addCDATA = *ON;
         cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
         cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)
         szCDATA = %size(cCDATA1) + %size(cCDATA2);
         if tgtMax < 1 or tgtMax > szCDATA;
           pCopy = pTgt;
           cpybytes(pCopy:%addr(cCDATA1):%size(cCDATA1));
           pTgt += %size(cCDATA1);
           if tgtMax > 0;
               tgtMax -= szCDATA;
           endif;
         else;
           return *OFF;
         endif;
       endif;

       // source varying length field
       pCopy = pSrc;
       if isVary = XML_VARY_ON;
         nLength = myCopy.shortx;
         pCopy += 2;
       elseif isVary = XML_VARY_4;
         nLength = myCopy.intx;
         pCopy += 4;
       else;
         nLength = srcMax;
       endif;
       
       // target maximum output
       if tgtMax > 0;
         nMax = tgtMax;
       else;
         nMax = nLength;
       endif;
       
       if nLength > nMax;
         sHint = 'padAlloc ' + %char(nLength) + ' GT ' + %char(nMax);
         errsWarning(CALL_ERROR_CONV_FAIL:sHint);
         return *OFF;
       endif;

       // pCopy is pSrc, so source would be killed
       // therfore we need a temp buffer (1.7.0)
       if nMax > 0 and cntCCSID > 0;
         rc = padAlloc(nMax);
         if rc = *OFF;
           sHint = 'padAlloc ALLOCSIZE '+ %char(nMax);
           errsWarning(CALL_ERROR_CONV_FAIL:sHint);
           return rc;
         endif;
         aPadPtrP = cacScanBig(sPadPtrI:aPadSz);
         cpybytes(aPadPtrP:pCopy:nLength);
       else;
         aPadPtrP = pCopy;
       endif;

       // convert and pad
       rc = trimConv(aPadPtrP:nLength:nMax:pad
                   :cntCCSID:srcCCSID:tgtCCSID);
       
       // any work to do?
       if nLength > 0;
         // copy out min size
         if toHex = *ON;
           if tgtMax > 0 and nLength * 2 > tgtMax;
             nLength = %div(tgtMax:2);
           endif;
           trimSz = cpyB2Hex(pTgt:aPadPtrP:nLength);
         else;
           IF xmlGetESCP() = *ON;//escape xml reserved chars
             escape(pTgt:aPadPtrP:nLength);
           ELSE;
             cpybytes(pTgt:aPadPtrP:nLength);
           ENDIF;
           trimSz = nLength;
         endif;
       endif;
       
       // take out junk (@ADC 1.7.4)
       if trimSz > 0 and (rmCDATA = *ON or rmLF = *ON or rmQuote = *ON);
         bigJunkOut(pTgt:pTgt+trimSz:rmCDATA:rmLF:rmQuote);
         trimSz = bigTrim(pTgt:trimSz);
       endif;

       // move copyout overlay past data
       pCopy = pTgt + trimSz;

       // <![CDATA[...]]>
       //             ooo
       if addCDATA = *ON;
         cpybytes(pCopy:%addr(cCDATA2):%size(cCDATA2));
         trimSz += (%size(cCDATA1) + %size(cCDATA2));
         pCopy += %size(cCDATA2);
       endif;
       
       // <hex> ... </hex>
       //           oooooo
       if addHex = *ON;
         cpybytes(pCopy:%addr(sHexCEnd):%size(sHexCEnd));
         trimSz += (%size(sHexCBeg) + %size(sHexCEnd));
         pCopy += %size(sHexCEnd);
       endif;

       return rc;
      /end-free
     P                 E
     
     

      *****************************************************
      * convert full character
      * return (*ON - error,*OFF - good)
      *****************************************************
     P fullChar        B                   export
     D fullChar        PI             1N
     D  pTgt                           *   Value
     D  tgtMax                       10i 0 Value
     D  pSrc                           *   Value 
     D  srcMax                       10i 0 Value 
     D  trimSz                       10i 0
     D  pad                          10i 0 Value 
     D  isVary                        1A   Value 
     D  toHex                         1N   Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)
     D  rmCDATA                       1N   value
     D  rmLF                          1N   value
     D  rmQuote                       1N   value
     D  addHex                        1N   value
     D  addCDATA                      1N   value
      * vars
     D rc              s              1N   inz(*ON)
     D nLength         s             10i 0 inz(0)
     D nMax            s             10i 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D aPadPtrP        s               *   inz(*NULL)
     D aPadSz          s             10i 0 inz(0)
     d szHex           s             10i 0 inz(0)
     d szCDATA         s             10i 0 inz(0)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
      /free
       
       trimSz = 0;
       
       // <hex> ... </hex>
       // ooooo
       if addHex = *ON;
         szHex = %size(sHexCBeg) + %size(sHexCEnd);
         if tgtMax < 1 or tgtMax > szHex;
           pCopy = pTgt;
           cpybytes(pCopy:%addr(sHexCBeg):%size(sHexCBeg));
           pTgt += %size(sHexCBeg);
           if tgtMax > 0;
               tgtMax -= szHex;
           endif;
         else;
           return *OFF;
         endif;
       endif;
       
       // <![CDATA[...]]>
       // ooooooooo
       if addCDATA = *ON;
         cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
         cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)
         szCDATA = %size(cCDATA1) + %size(cCDATA2);
         if tgtMax < 1 or tgtMax > szCDATA;
           pCopy = pTgt;
           cpybytes(pCopy:%addr(cCDATA1):%size(cCDATA1));
           pTgt += %size(cCDATA1);
           if tgtMax > 0;
               tgtMax -= szCDATA;
           endif;
         else;
           return *OFF;
         endif;
       endif;

       // source varying length field
       pCopy = pSrc;
       if isVary = XML_VARY_ON;
         nLength = myCopy.shortx;
         pCopy += 2;
       elseif isVary = XML_VARY_4;
         nLength = myCopy.intx;
         pCopy += 4;
       else;
         nLength = srcMax;
       endif;
       
       // target maximum output
       if tgtMax > 0;
         nMax = tgtMax;
       else;
         nMax = nLength;
       endif;
       
       if nLength > nMax;
         sHint = 'padAlloc ' + %char(nLength) + ' GT ' + %char(nMax);
         errsWarning(CALL_ERROR_CONV_FAIL:sHint);
         return *OFF;
       endif;

       // pCopy is pSrc, so source would be killed
       // therfore we need a temp buffer (1.7.0)
       if nMax > 0 and cntCCSID > 0;
         rc = padAlloc(nMax);
         if rc = *OFF;
           sHint = 'padAlloc ALLOCSIZE '+ %char(nMax);
           errsWarning(CALL_ERROR_CONV_FAIL:sHint);
           return rc;
         endif;
         aPadPtrP = cacScanBig(sPadPtrI:aPadSz);
         cpybytes(aPadPtrP:pCopy:nLength);
       else;
         aPadPtrP = pCopy;
       endif;

       // convert and pad
       rc = padConv(aPadPtrP:nLength:nLength:pad
                   :cntCCSID:srcCCSID:tgtCCSID);
       
       // any work to do?
       if nLength > 0;
         // copy out min size
         if toHex = *ON;
           if tgtMax > 0 and nLength * 2 > tgtMax;
             nLength = %div(tgtMax:2);
           endif;
           trimSz = cpyB2Hex(pTgt:aPadPtrP:nLength);
         else;
           IF xmlGetESCP() = *ON; 
             escape(pTgt:aPadPtrP:nLength);
           ELSE;
             cpybytes(pTgt:aPadPtrP:nLength);
           ENDIF;
           trimSz = nLength;
         endif;
       endif;

       // take out junk (@ADC 1.7.4)
       if trimSz > 0 and (rmCDATA = *ON or rmLF = *ON or rmQuote = *ON);
         bigJunkOut(pTgt:pTgt+trimSz:rmCDATA:rmLF:rmQuote);
       endif;

       // move copyout overlay past data
       pCopy = pTgt + trimSz;

       // <![CDATA[...]]>
       //             ooo
       if addCDATA = *ON;
         cpybytes(pCopy:%addr(cCDATA2):%size(cCDATA2));
         trimSz += (%size(cCDATA1) + %size(cCDATA2));
         pCopy += %size(cCDATA2);
       endif;
       
       // <hex> ... </hex>
       //           oooooo
       if addHex = *ON;
         cpybytes(pCopy:%addr(sHexCEnd):%size(sHexCEnd));
         trimSz += (%size(sHexCBeg) + %size(sHexCEnd));
         pCopy += %size(sHexCEnd);
       endif;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * hexDump
      * return (NA)
      *****************************************************
     P hexDump         B                   export
     D hexDump         PI
     D   piParm                        *   value
     D   piSize                      10i 0 value
     D   pxParm                        *   value
     D   pxSize                      10i 0 value
     D   pcParm                        *   value
     D   pcSize                      10i 0 value
      * vars
     D hhSize          s             10i 0 inz(0)
     D xxSize          s             10i 0 inz(0)
     D pxCopy          s               *   inz(*NULL)
     D xCopy           ds                  likeds(over_t) based(pxCopy)
     D pcCopy          s               *   inz(*NULL)
     D cCopy           ds                  likeds(over_t) based(pcCopy)
      /free
       Monitor;
       // --------------------
       // empty output buffers
       memset(pxParm:x'40':pxSize);
       memset(pcParm:x'40':pcSize);
       // --------------------
       // store hex in pxParm buffer
       hhSize = piSize;
       if hhSize > pxSize;
         hhSize = pxSize;
       endif;
       hhSize = %div(hhSize:2);
       xxSize = cpyB2Hex(pxParm:piParm:hhSize);
       // --------------------
       // store character xlate in pcParm 
       pxCopy = pxParm;
       pcCopy = pcParm;
       dow pxCopy < pxParm + xxSize
       and pcCopy < pcParm + pcSize;
         select;
         when xCopy.twox='F9';
           cCopy.twox=' 9';
         when xCopy.twox='F8';
           cCopy.twox=' 8';
         when xCopy.twox='F7';
           cCopy.twox=' 7';
         when xCopy.twox='F6';
           cCopy.twox=' 6';
         when xCopy.twox='F5';
           cCopy.twox=' 5';
         when xCopy.twox='F4';
           cCopy.twox=' 4';
         when xCopy.twox='F3';
           cCopy.twox=' 3';
         when xCopy.twox='F2';
           cCopy.twox=' 2';
         when xCopy.twox='F1';
           cCopy.twox=' 1';
         when xCopy.twox='F0';
           cCopy.twox=' 0';
         when xCopy.twox='81';
           cCopy.twox=' a';
         when xCopy.twox='82';
           cCopy.twox=' b';
         when xCopy.twox='83';
           cCopy.twox=' c';
         when xCopy.twox='84';
           cCopy.twox=' d';
         when xCopy.twox='85';
           cCopy.twox=' e';
         when xCopy.twox='86';
           cCopy.twox=' f';
         when xCopy.twox='87';
           cCopy.twox=' g';
         when xCopy.twox='88';
           cCopy.twox=' h';
         when xCopy.twox='89';
           cCopy.twox=' i';
         when xCopy.twox='91';
           cCopy.twox=' j';
         when xCopy.twox='92';
           cCopy.twox=' k';
         when xCopy.twox='93';
           cCopy.twox=' l';
         when xCopy.twox='94';
           cCopy.twox=' m';
         when xCopy.twox='95';
           cCopy.twox=' n';
         when xCopy.twox='96';
           cCopy.twox=' o';
         when xCopy.twox='97';
           cCopy.twox=' p';
         when xCopy.twox='98';
           cCopy.twox=' q';
         when xCopy.twox='99';
           cCopy.twox=' r';
         when xCopy.twox='A2';
           cCopy.twox=' s';
         when xCopy.twox='A3';
           cCopy.twox=' t';
         when xCopy.twox='A4';
           cCopy.twox=' u';
         when xCopy.twox='A5';
           cCopy.twox=' v';
         when xCopy.twox='A6';
           cCopy.twox=' w';
         when xCopy.twox='A7';
           cCopy.twox=' x';
         when xCopy.twox='A8';
           cCopy.twox=' y';
         when xCopy.twox='A9';
           cCopy.twox=' z';
         when xCopy.twox='C1';
           cCopy.twox=' A';
         when xCopy.twox='C2';
           cCopy.twox=' B';
         when xCopy.twox='C3';
           cCopy.twox=' C';
         when xCopy.twox='C4';
           cCopy.twox=' D';
         when xCopy.twox='C5';
           cCopy.twox=' E';
         when xCopy.twox='C6';
           cCopy.twox=' F';
         when xCopy.twox='C7';
           cCopy.twox=' G';
         when xCopy.twox='C8';
           cCopy.twox=' H';
         when xCopy.twox='C9';
           cCopy.twox=' I';
         when xCopy.twox='D1';
           cCopy.twox=' J';
         when xCopy.twox='D2';
           cCopy.twox=' K';
         when xCopy.twox='D3';
           cCopy.twox=' L';
         when xCopy.twox='D4';
           cCopy.twox=' M';
         when xCopy.twox='D5';
           cCopy.twox=' N';
         when xCopy.twox='D6';
           cCopy.twox=' O';
         when xCopy.twox='D7';
           cCopy.twox=' P';
         when xCopy.twox='D8';
           cCopy.twox=' Q';
         when xCopy.twox='D9';
           cCopy.twox=' R';
         when xCopy.twox='E2';
           cCopy.twox=' S';
         when xCopy.twox='E3';
           cCopy.twox=' T';
         when xCopy.twox='E4';
           cCopy.twox=' U';
         when xCopy.twox='E5';
           cCopy.twox=' V';
         when xCopy.twox='E6';
           cCopy.twox=' W';
         when xCopy.twox='E7';
           cCopy.twox=' X';
         when xCopy.twox='E8';
           cCopy.twox=' Y';
         when xCopy.twox='E9';
           cCopy.twox=' Z';
         other;
           cCopy.twox=' .';
         endsl;
         pxCopy += 2;
         pcCopy += 2;
       enddo;
       On-error;
       Endmon;
      /end-free
     P                 E
      *****************************************************
      * escape xml reserved chars
      * return none
      *****************************************************
     P escape          B
     D escape          PI
     D  pTgt                           *   value
     D  pSrc                           *   value
     D  srcLen                       10i 0
      * vars
     D i               s             10i 0 inz(0)
     D ch              s              1A   inz(*blank)
     D len             s             10i 0 inz(0)
      /FREE
       // translate xml reserved chars to job ccsid if not have this done yet
       IF escpCvtd = *OFF;
         clt = %char(wlt);
         cgt = %char(wgt);
         camp = %char(wamp);
         cquot = %char(wquot);
         capos = %char(wapos);

         celt = %char(welt);
         cegt = %char(wegt);
         ceamp = %char(weamp);
         cequot = %char(wequot);
         ceapos = %char(weapos);

         escpCvtd = *ON;
       ENDIF;
       // scan xml reserved chars and escape
       FOR i = 0 to (srcLen-1);
         ch = %STR(pSrc+i:1);
         SELECT;
           WHEN ch = clt;
             cpybytes(pTgt:%ADDR(celt):%size(celt));
             len += %size(celt);
             pTgt +=  %size(celt);
           WHEN ch = cgt;
             cpybytes(pTgt:%ADDR(cegt):%size(cegt));
             len += %size(cegt);
             pTgt += %size(cegt);
           WHEN ch = camp;
             cpybytes(pTgt:%ADDR(ceamp):%size(ceamp));
             len += %size(ceamp);
             pTgt += %size(ceamp);
           WHEN ch = cquot;
             cpybytes(pTgt:%ADDR(cequot):%size(cequot));
             len += %size(cequot);
             pTgt += %size(cequot);
           WHEN ch = capos;
             cpybytes(pTgt:%ADDR(ceapos):%size(ceapos));
             len += %size(ceapos);
             pTgt += %size(ceapos);
           OTHER;
             cpybytes(pTgt:pSrc+i:1);
             len += 1;
             pTgt += 1;
         ENDSL;
       ENDFOR;
       srcLen = len;
      /END-FREE
     P                 E
