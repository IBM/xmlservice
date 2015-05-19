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
      /copy plugjson_h

      *****************************************************
      * global vars
      *****************************************************

      *****************************************************
      * json do it
      * return (*ON=good, *OFF=error)
      *****************************************************
     P jsonRun         B                   export
     D jsonRun         PI             1N
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

       On-error;
         errsSevere(XML_ERROR_SCAN_ONERROR:sHint);
         rc = *OFF;
       Endmon;

       return rc;
      /end-free
     P                 E


