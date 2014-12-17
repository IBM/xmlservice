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
      /copy plugbug_h
      /copy plugcach_h
      /copy plugile_h
      /copy plugxml_h
      /copy plugerr_h
      /copy plugsql_h
      /copy plugcli_h
      /copy plugdb2_h
      /copy plugipc_h
      /copy plugconv_h

      *****************************************************
      * globals
      *****************************************************
     D sTooLate        s              1N   inz(*OFF)
     D sServMode       s              1N   inz(*OFF)
     D sV5Binary       s              1N   inz(*OFF)

     D db2_connect_libl...        
     D                 PR             1N
     D  conn                         10A
     D  sqlCode                      10I 0

     D db2_option_is_sql_naming...        
     D                 PR             1N
     D  options                      10A   value

     D db2_option_is_autocommit...        
     D                 PR             1N
     D  options                      10A   value

     D db2_ctor_statement...        
     D                 PR             1N
     D  conn                         10A
     D  stmt                         10A
     D  hstmt                        10I 0
     D  sqlCode                      10I 0


     D db2_get_data...        
     D                 PR             1N
     D  stmt                         10A
     D  colnum                        5I 0
     D  ctype                         5I 0
     D  buf                            *
     D  inLen                        10I 0
     D  outLen                       10I 0
     D  sqlCode                      10I 0


     D db2_lob_length...        
     D                 PR             1N
     D  conn                         10A
     D  lob_loc                      10I 0
     D  loc_ind                      10I 0
     D  loc_type                      5I 0
     D  len                          10I 0
     D  sqlCode                      10I 0

     D db2_lob_data...        
     D                 PR             1N
     D  conn                         10A
     D  lob_loc                      10I 0
     D  loc_ind                      10I 0
     D  loc_type                      5I 0
     D  forBeg                       10I 0
     D  forLen                       10I 0
     D  cType                         5I 0
     D  buf                            *
     D  bufLen                       10I 0
     D  outLen                       10I 0
     D  sqlCode                      10I 0

     D db2_meta_set...        
     D                 PR
     D  p1                             *   options(*nopass)
     D  cb1                           5i 0 options(*nopass)
     D  p2                             *   options(*nopass)
     D  cb2                           5i 0 options(*nopass)
     D  p3                             *   options(*nopass)
     D  cb3                           5i 0 options(*nopass)
     D  p4                             *   options(*nopass)
     D  cb4                           5i 0 options(*nopass)
     D  p5                             *   options(*nopass)
     D  cb5                           5i 0 options(*nopass)
     D  p6                             *   options(*nopass)
     D  cb6                           5i 0 options(*nopass)

     
     D db2_stmt_free_monitor...        
     D                 PR            10I 0
     D   hstmt                       10I 0 value

     D db2_conn_free_monitor...        
     D                 PR            10I 0
     D   hdbc                        10I 0 value

     D db2_env_free_monitor...        
     D                 PR            10I 0
     D   lenv                        10I 0 value

     D db2_disconnect_monitor...        
     D                 PR            10I 0
     D   hdbc                        10I 0 value

      *****************************************************
      * which IBM i release static init
      *****************************************************
     P db2Static       B                   export
     D db2Static       PI
      * vars
     D rc              s              1N   inz(*OFF)
      /free
       // V5 or V6 for DB2_BINARY or DB2_BINARY_V6
       rc = ileIsV5();
       if rc = *ON;
         sV5Binary = *ON;
       else;
         sV5Binary = *OFF;
       endif;

      /end-free
     P                 E
     
     
      *****************************************************
      * RPG CLI monitored free 
      *****************************************************
     P db2_stmt_free_monitor...
     P                 B
     D db2_stmt_free_monitor...        
     D                 PI            10I 0
     D   hstmt                       10I 0 value
      * vars
     DDB2_RC1          S             10I 0 inz(0)
      /free
       Monitor;

       DB2_RC1 = db2FreeStm(hstmt:DB2_DROP);

       // -------------
       // error
       On-error;
         DB2_RC1 = DB2_ERROR;
       Endmon;

       return DB2_RC1; // @ADC error 1.7.1
      /end-free
     P                 E


     P db2_conn_free_monitor...
     P                 B
     D db2_conn_free_monitor...        
     D                 PI            10I 0
     D   hdbc                        10I 0 value
      * vars
     DDB2_RC1          S             10I 0 inz(0)
     D jvm             S              1N   inz(*OFF)
      /free
       Monitor;

       // running JVM in process (1.9.2)
       jvm = ipcDoJVM();
       if jvm = *OFF;
         DB2_RC1=db2FreeConnect(hdbc);
       endif;
       
       // -------------
       // error
       On-error;
         DB2_RC1 = DB2_ERROR;
       Endmon;

       return DB2_RC1; // @ADC error 1.7.1
      /end-free
     P                 E

     P db2_env_free_monitor...
     P                 B
     D db2_env_free_monitor...        
     D                 PI            10I 0
     D   lenv                        10I 0 value
      * vars
     DDB2_RC1          S             10I 0 inz(0)
     D jvm             S              1N   inz(*OFF)
      /free
       Monitor;
       
       // running JVM in process (1.9.2)
       jvm = ipcDoJVM();
       if jvm = *OFF;
         DB2_RC1=db2FreeEnv(lenv);
       endif;
       
       // -------------
       // error
       On-error;
         DB2_RC1 = DB2_ERROR;
       Endmon;

       return DB2_RC1; // @ADC error 1.7.1
      /end-free
     P                 E

     P db2_disconnect_monitor...
     P                 B
     D db2_disconnect_monitor...        
     D                 PI            10I 0
     D   hdbc                        10I 0 value
      * vars
     DDB2_RC1          S             10I 0 inz(0)
     D jvm             S              1N   inz(*OFF)
      /free
       Monitor;
       
       // running JVM in process (1.9.2)
       jvm = ipcDoJVM();
       if jvm = *OFF;
         DB2_RC1=db2Disconnect(hdbc);
       endif;
       
       // -------------
       // error
       On-error;
         DB2_RC1 = DB2_ERROR;
       Endmon;

       return DB2_RC1; // @ADC error 1.7.1
      /end-free
     P                 E


      *****************************************************
      * RPG CLI any active 
      *****************************************************
     P db2_active_any...
     P                 B                   export
     D db2_active_any...        
     D                 PI             1N
     D  type                          1A   value
     D  label                        10A
      *vars
     D rc              s              1N   inz(*OFF)
     D i               s             10i 0 inz(0)
      * options
     D opts            s             10A   inz(*BLANKS)
     D pOpt2           s               *   inz(*NULL)
      * connection
     D conn            s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
      * statment
     D stmt            s             10A   inz(*BLANKS)
     D hstmt           s             10I 0 inz(0)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       select;
       when type = SQL_ACTIVE_OPTIONS;
         rc = cacScanOPT(CAC_OPT_ACTIVE:i:opts:pOpt2);
         if rc = *ON;
           label = opts;
         endif;
       when type = SQL_ACTIVE_CONN;
         rc = cacScanDB2(CAC_CONN_ACTIVE:i:henv:hdbc
                :conn:option1:db:uid:pwd);
         if rc = *ON;
           label = conn;
         endif;
       when type = SQL_ACTIVE_STMT;
         rc = cacScanStm(CAC_STMT_ACTIVE:i:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
         if rc = *ON;
           label = stmt;
         endif;
       other;
       endsl;
       return rc;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect options
      *****************************************************
     P db2_options_ctor...
     P                 B                   export
     D db2_options_ctor...        
     D                 PI             1N
     D pOpt                            *   value
      * vars
     D pOpt2           s               *   inz(*NULL)
     D doFlags         ds                  likeds(sqOpt_t)
     D                                     based(pOpt2)
      /free
       pOpt2 = pOpt;

       // cache count
       doFlags.sqUsed            = 0;
       doFlags.sqLabel           = *BLANKS;
       // ENV level ...
       // servermode='on' (global env level)
       doFlags.sqSrvMode         = *OFF;
       // CONN level ...
       // naming='system|sql' (default system naming)
       doFlags.sqNamSQL          = *OFF;
       // commit='none|uncomitted|committed|repeatable|serializable'
       doFlags.sqComMiss         = *ON;
       doFlags.sqComNone         = *OFF;
       doFlags.sqComUnCom        = *ON;
       doFlags.sqComCommi        = *OFF;
       doFlags.sqComRepea        = *OFF;
       doFlags.sqComSeria        = *OFF;
       // autocommit='on|off'
       doFlags.sqAutoComm        = *ON;
       // datefmt='iso|usa|eur|jis|mdy|dmy|ymd|jul|job'
       doFlags.sqDFmtMiss        = *ON;
       doFlags.sqDFmtISO         = *OFF;
       doFlags.sqDFmtUSA         = *OFF;
       doFlags.sqDFmtEUR         = *OFF;
       doFlags.sqDFmtJIS         = *OFF;
       doFlags.sqDFmtMDY         = *OFF;
       doFlags.sqDFmtDMY         = *OFF;
       doFlags.sqDFmtYMD         = *OFF;
       doFlags.sqDFmtJUL         = *OFF;
       doFlags.sqDFmtJOB         = *OFF;
       // datesep='slash|dash|period|comma|blank|job'
       doFlags.sqDSepMiss        = *ON;
       doFlags.sqDSepSlas        = *OFF;
       doFlags.sqDSepDash        = *OFF;
       doFlags.sqDSepDot         = *OFF;
       doFlags.sqDSepComa        = *OFF;
       doFlags.sqDSepBlk         = *OFF;
       doFlags.sqDSepJOB         = *OFF;
       // timefmt='iso|usa|eur|jis|hms|job'
       doFlags.sqTFmtMiss        = *ON;
       doFlags.sqTFmtISO         = *OFF;
       doFlags.sqTFmtUSA         = *OFF;
       doFlags.sqTFmtEUR         = *OFF;
       doFlags.sqTFmtJIS         = *OFF;
       doFlags.sqTFmtHMS         = *OFF;
       doFlags.sqTFmtJOB         = *OFF;
       // timesep='colon|period|comma|blank|job'
       doFlags.sqTSepMiss        = *ON;
       doFlags.sqTSepColn        = *OFF;
       doFlags.sqTSepDot         = *OFF;
       doFlags.sqTSepComa        = *OFF;
       doFlags.sqTSepBlk         = *OFF;
       doFlags.sqTSepJOB         = *OFF;
       // decimalsep='period|comma|blank|job'
       doFlags.sqPSepMiss        = *ON;
       doFlags.sqPSepDot         = *OFF;
       doFlags.sqPSepComa        = *OFF;
       doFlags.sqPSepBlk         = *OFF;
       doFlags.sqPSepJOB         = *OFF;
       // optimize='first|all'
       doFlags.sqOptzMiss        = *ON;
       doFlags.sqOptzFrst        = *OFF;
       doFlags.sqOptzAll         = *OFF;
       // sqllib='mylib'
       doFlags.sqLIB             = *BLANKS;
       doFlags.sqLIBlen          = 0;
       // libl='curlib1 mylib2 mylib3'
       doFlags.sqLIBL            = *BLANKS;
       doFlags.sqLIBLlen         = 0;
       // STMT level ...
       // scrollable='on|off'
       doFlags.sqScMiss          = *ON;
       doFlags.sqScroll          = *OFF;
       // sensitive='unspecified|sensitive|insensitive'
       doFlags.sqSenMiss         = *ON;
       doFlags.sqSenUn           = *OFF;
       doFlags.sqSenOn           = *OFF;
       doFlags.sqSenOFF          = *OFF;
       // cursor='forward|static|dynamic'
       doFlags.sqCurMiss         = *ON;
       doFlags.sqCurFwd          = *OFF;
       doFlags.sqCurStat         = *OFF;
       doFlags.sqCurDyn          = *OFF;
       // fetchonly='on|off'
       doFlags.sqFetMiss         = *ON;
       doFlags.sqFetOnly         = *OFF;
       // fullopen='on|off'
       doFlags.sqFullMiss        = *ON;
       doFlags.sqFullOpn         = *OFF;

       return *ON;
      /end-free
     P                 E

     P db2_option_is_autocommit...
     P                 B
     D db2_option_is_autocommit...        
     D                 PI             1N
     D  options                      10A   value
      * vars
     D rc              s              1N   inz(*OFF)
     D iopt            s             10i 0 inz(0)
     D doDefault       ds                  likeds(sqOpt_t)
     D pOpt2           s               *   inz(*NULL)
     D doFlags         ds                  likeds(sqOpt_t)
     D                                     based(pOpt2)
      /free
       // *** old options
       rc = cacScanOPT(CAC_OPT_ACTIVE:iopt:options:pOpt2);
       // *** options (default) ***
       if rc = *OFF or pOpt2 = *NULL;
         pOpt2 = %addr(doDefault);
         rc =db2_options_ctor(pOpt2);
       endif;
       // good
       return doFlags.sqAutoComm;
      /end-free
     P                 E

     P db2_option_is_sql_naming...
     P                 B
     D db2_option_is_sql_naming...        
     D                 PI             1N
     D  options                      10A   value
      * vars
     D rc              s              1N   inz(*OFF)
     D iopt            s             10i 0 inz(0)
     D doDefault       ds                  likeds(sqOpt_t)
     D pOpt2           s               *   inz(*NULL)
     D doFlags         ds                  likeds(sqOpt_t)
     D                                     based(pOpt2)
      /free
       // *** old options
       rc = cacScanOPT(CAC_OPT_ACTIVE:iopt:options:pOpt2);
       // *** options (default) ***
       if rc = *OFF or pOpt2 = *NULL;
         pOpt2 = %addr(doDefault);
         rc =db2_options_ctor(pOpt2);
       endif;
       // good
       return doFlags.sqNamSQL;
      /end-free
     P                 E

     P db2_options_setup...
     P                 B                   export
     D db2_options_setup...        
     D                 PI             1N
     D  label                        10A
     D  sqloptions                 1024A
      * vars
     D newOpt          s              1N   inz(*ON)
     D rc              s              1N   inz(*OFF)
     D iopt            s             10i 0 inz(0)
     D pTop            s               *   inz(*NULL)
     D pBeg            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D len             s             10i 0 inz(0)
     D chglibl         s           1032A   inz(*BLANKS)
     D curlib          s             10A   inz(*BLANKS)
     D doCtl1          s           1032A   inz(*BLANKS)
     D pOpt2           s               *   inz(*NULL)
     D doFlags         ds                  likeds(sqOpt_t)
      * attribute search
     D search          s             20A   dim(XMLMAXATTR) inz(*BLANKS)
     D pName           s               *   dim(XMLMAXATTR) inz(*NULL)
     D pValue          s               *   dim(XMLMAXATTR) inz(*NULL)
     D valueLen        s             10i 0 dim(XMLMAXATTR) inz(0)
      /free
       // *** old options ***
       rc = cacScanOPT(CAC_OPT_ACTIVE:iopt:label:pOpt2);
       if rc = *ON;
         newOpt = *OFF;
       endif;

       // *** new options ***
       rc =db2_options_ctor(%addr(doFlags));

       // parse elements (input)
       doCtl1 = %trim(sqloptions);
       pTop = %addr(doCtl1);
       len  = %len(%trim(doCtl1));
       if len < 2;
         return *ON;
       endif;
       pLst = pTop + len;
       // locate attributes
       search(1)  = 'servermode';
       search(2)  = 'naming';
       search(3)  = 'commit';
       search(4)  = 'autocommit';
       search(5)  = 'datefmt';
       search(6)  = 'datesep';
       search(7)  = 'timefmt';
       search(8)  = 'timesep';
       search(9)  = 'decimalsep';
       search(10) = 'optimize';
       search(11) = 'sqllib';
       search(12) = 'libl';
       search(13) = 'scrollable';
       search(14) = 'sensitive';
       search(15) = 'cursor';
       search(16) = 'fetchonly';
       search(17) = 'fullopen';
       rc = bigDimAttr(pTop:pLst:search:pName:pValue:valueLen);
       if rc = *OFF;
         return *ON;
       endif;

       // ENV level ...

       // servermode='on' (global env level)
       if valueLen(1) <> 0;
         if 'on' = %str(pValue(1):2);
           doFlags.sqSrvMode = *ON;
         endif;
       endif;

       // CONN level ...

       // naming='system|sql'
       if valueLen(2) <> 0;
         if 'sq' = %str(pValue(2):2);
           doFlags.sqNamSQL  = *ON;
         endif;
       endif;

       // commit='none|uncomitted|committed|repeatable|serializable'
       doFlags.sqComMiss = *ON;
       doFlags.sqComUnCom = *ON;
       if valueLen(3) <> 0;
         if 'no' = %str(pValue(3):2);
           doFlags.sqComNone = *ON;
           doFlags.sqComMiss = *OFF;
           doFlags.sqComUnCom = *OFF;
         elseif 'un' = %str(pValue(3):2);
           doFlags.sqComUnCom = *ON;
           doFlags.sqComMiss = *OFF;
         elseif 'co' = %str(pValue(3):2);
           doFlags.sqComCommi = *ON;
           doFlags.sqComMiss = *OFF;
           doFlags.sqComUnCom = *OFF;
         elseif 're' = %str(pValue(3):2);
           doFlags.sqComRepea = *ON;
           doFlags.sqComMiss = *OFF;
           doFlags.sqComUnCom = *OFF;
         elseif 'se' = %str(pValue(3):2);
           doFlags.sqComSeria = *ON;
           doFlags.sqComMiss = *OFF;
           doFlags.sqComUnCom = *OFF;
         endif;
       endif;

       // autocommit='on|off'
       doFlags.sqAutoComm = *ON;
       if valueLen(4) <> 0;
         if 'of' = %str(pValue(4):2);
           doFlags.sqAutoComm = *OFF;
         endif;
       endif;

       // datefmt='iso|usa|eur|jis|mdy|dmy|ymd|jul|job'
       doFlags.sqDFmtMiss = *ON;
       if valueLen(5) <> 0;
         if 'iso' = %str(pValue(5):3);
           doFlags.sqDFmtISO = *ON;
           doFlags.sqDFmtMiss = *OFF;
         elseif 'usa' = %str(pValue(5):3);
           doFlags.sqDFmtUSA = *ON;
           doFlags.sqDFmtMiss = *OFF;
         elseif 'eur' = %str(pValue(5):3);
           doFlags.sqDFmtEUR = *ON;
           doFlags.sqDFmtMiss = *OFF;
         elseif 'jis' = %str(pValue(5):3);
           doFlags.sqDFmtJIS = *ON;
           doFlags.sqDFmtMiss = *OFF;
         elseif 'mdy' = %str(pValue(5):3);
           doFlags.sqDFmtMDY = *ON;
           doFlags.sqDFmtMiss = *OFF;
         elseif 'dmy' = %str(pValue(5):3);
           doFlags.sqDFmtDMY = *ON;
           doFlags.sqDFmtMiss = *OFF;
         elseif 'ymd' = %str(pValue(5):3);
           doFlags.sqDFmtYMD = *ON;
           doFlags.sqDFmtMiss = *OFF;
         elseif 'jul' = %str(pValue(5):3);
           doFlags.sqDFmtJUL = *ON;
           doFlags.sqDFmtMiss = *OFF;
         elseif 'job' = %str(pValue(5):3);
           doFlags.sqDFmtJOB = *ON;
           doFlags.sqDFmtMiss = *OFF;
         endif;
       endif;

       // datesep='slash|dash|period|comma|blank|job'
       doFlags.sqDSepMiss  = *ON;
       if valueLen(6) <> 0;
         if 'sl' = %str(pValue(6):2);
           doFlags.sqDSepSlas = *OFF;
           doFlags.sqDSepMiss = *OFF;
         elseif 'da' = %str(pValue(6):2);
           doFlags.sqDSepDash = *ON;
           doFlags.sqDSepMiss = *OFF;
         elseif 'pe' = %str(pValue(6):2);
           doFlags.sqDSepDot  = *ON;
           doFlags.sqDSepMiss = *OFF;
         elseif 'co' = %str(pValue(6):2);
           doFlags.sqDSepComa = *ON;
           doFlags.sqDSepMiss = *OFF;
         elseif 'bl' = %str(pValue(6):2);
           doFlags.sqDSepBlk  = *ON;
           doFlags.sqDSepMiss = *OFF;
         elseif 'jo' = %str(pValue(6):2);
           doFlags.sqDSepJOB  = *ON;
           doFlags.sqDSepMiss = *OFF;
         endif;
       endif;

       // timefmt='iso|usa|eur|jis|hms|job'
       doFlags.sqTFmtMiss = *ON;
       if valueLen(7) <> 0;
         if 'iso' = %str(pValue(7):3);
           doFlags.sqTFmtISO = *ON;
           doFlags.sqTFmtMiss = *OFF;
         elseif 'usa' = %str(pValue(7):3);
           doFlags.sqTFmtUSA = *ON;
           doFlags.sqTFmtMiss = *OFF;
         elseif 'eur' = %str(pValue(7):3);
           doFlags.sqTFmtEUR = *ON;
           doFlags.sqTFmtMiss = *OFF;
         elseif 'jis' = %str(pValue(7):3);
           doFlags.sqTFmtJIS = *ON;
           doFlags.sqTFmtMiss = *OFF;
         elseif 'hms' = %str(pValue(7):3);
           doFlags.sqTFmtHMS = *ON;
           doFlags.sqTFmtMiss = *OFF;
         elseif 'job' = %str(pValue(7):3);
           doFlags.sqTFmtJOB = *ON;
           doFlags.sqTFmtMiss = *OFF;
         endif;
       endif;

       // timesep='colon|period|comma|blank|job'
       doFlags.sqTSepMiss = *ON;
       if valueLen(8) <> 0;
         if 'col' = %str(pValue(8):3);
           doFlags.sqTSepColn = *ON;
           doFlags.sqTSepMiss = *OFF;
         elseif 'per' = %str(pValue(8):3);
           doFlags.sqTSepDot  = *ON;
           doFlags.sqTSepMiss = *OFF;
         elseif 'com' = %str(pValue(8):3);
           doFlags.sqTSepComa = *ON;
           doFlags.sqTSepMiss = *OFF;
         elseif 'bla' = %str(pValue(8):3);
           doFlags.sqTSepBlk  = *ON;
           doFlags.sqTSepMiss = *OFF;
         elseif 'job' = %str(pValue(8):3);
           doFlags.sqTSepJOB  = *ON;
           doFlags.sqTSepMiss = *OFF;
         endif;
       endif;

       // decimalsep='period|comma|blank|job'
       doFlags.sqPSepMiss = *ON;
       if valueLen(9) <> 0;
         if 'per' = %str(pValue(9):3);
           doFlags.sqPSepDot  = *ON;
           doFlags.sqPSepMiss = *OFF;
         elseif 'com' = %str(pValue(9):3);
           doFlags.sqPSepComa = *ON;
           doFlags.sqPSepMiss = *OFF;
         elseif 'bla' = %str(pValue(9):3);
           doFlags.sqPSepBlk  = *ON;
           doFlags.sqPSepMiss = *OFF;
         elseif 'job' = %str(pValue(9):3);
           doFlags.sqPSepJOB  = *ON;
           doFlags.sqPSepMiss = *OFF;
         endif;
       endif;

       // optimize='first|all'
       doFlags.sqOptzMiss = *ON;
       if valueLen(10) <> 0;
         if 'fir' = %str(pValue(10):3);
           doFlags.sqOptzFrst = *ON;
           doFlags.sqOptzMiss = *OFF;
         elseif 'all' = %str(pValue(10):3);
           doFlags.sqOptzAll  = *ON;
           doFlags.sqOptzMiss = *OFF;
         endif;
       endif;

       // sqllib='mylib'
       if valueLen(11) <> 0;
         doFlags.sqLIB = %str(pValue(11):valueLen(11));
         doFlags.sqLIBlen = %len(%trim(doFlags.sqLIB));
       endif;

       // libl='curlib1 mylib2 mylib3'
       if valueLen(12) <> 0;
         doFlags.sqLIBL = %str(pValue(12):valueLen(12));
         // 'curlib1 mylib2 mylib3'
         //         x
         pTop = %addr(doFlags.sqLIBL);
         pLst = pTop + %len(%trim(doFlags.sqLIBL));
         pBeg = bigScan(pTop:' ':pLst:*ON);
         if pBeg <> *NULL;
            curlib = %str(pTop:pBeg-pTop);
         else;
            curlib = %trim(doFlags.sqLIBL);
         endif;
         chglibl = 'CHGLIBL LIBL('
                 + %trim(doFlags.sqLIBL)
                 + ')';
         doFlags.sqLIBL = %trim(chglibl);
         doFlags.sqLIBLlen = %len(%trim(doFlags.sqLIBL));
       endif;

       // STMT level ...

       // scrollable='on|off'
       doFlags.sqScMiss = *ON;
       if valueLen(13) <> 0;
         if 'on' = %str(pValue(13):2);
           doFlags.sqScroll = *ON;
           doFlags.sqScMiss = *OFF;
         endif;
       endif;

       // sensitive='unspecified|sensitive|insensitive'
       doFlags.sqSenMiss = *ON;
       if valueLen(14) <> 0;
         if 'un' = %str(pValue(14):2);
           doFlags.sqSenUn = *ON;
           doFlags.sqSenMiss = *OFF;
         endif;
         if 'se' = %str(pValue(14):2);
           doFlags.sqSenOn = *ON;
           doFlags.sqSenMiss = *OFF;
         endif;
         if 'in' = %str(pValue(14):2);
           doFlags.sqSenOFF = *ON;
           doFlags.sqSenMiss = *OFF;
         endif;
       endif;

       // cursor='forward|static|dynamic'
       doFlags.sqCurMiss = *ON;
       if valueLen(15) <> 0;
         if 'fo' = %str(pValue(15):2);
           doFlags.sqCurFwd = *ON;
           doFlags.sqCurMiss = *OFF;
         endif;
         if 'st' = %str(pValue(15):2);
           doFlags.sqCurStat = *ON;
           doFlags.sqCurMiss = *OFF;
         endif;
         if 'dy' = %str(pValue(15):2);
           doFlags.sqCurDyn = *ON;
           doFlags.sqCurMiss = *OFF;
         endif;
       endif;

       // fetchonly='on|off'
       doFlags.sqFetMiss = *ON;
       if valueLen(16) <> 0;
         if 'of' = %str(pValue(16):2);
           doFlags.sqFetOnly = *OFF;
           doFlags.sqFetMiss = *OFF;
         endif;
       endif;

       // fullopen='on|off'
       doFlags.sqFullMiss = *ON;
       if valueLen(17) <> 0;
         if 'on' = %str(pValue(17):2);
           doFlags.sqFullOpn = *ON;
           doFlags.sqFullMiss = *OFF;
         endif;
       endif;

       // save for fast
       pOpt2 = %addr(doFlags);
       if newOpt = *ON;
         rc = cacScanOPT(CAC_OPT_NEW:iopt:label:pOpt2);
       else;
         rc = cacScanOPT(CAC_OPT_UPDATE:iopt:label:pOpt2);
       endif;
       if rc = *OFF;
         return *OFF;
       endif;

       // good
       return *ON;
      /end-free
     P                 E


     P db2_env_options...
     P                 B                   export
     D db2_env_options...        
     D                 PI             1N
     D  conn                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0
      * vars
     D rc              s              1N   inz(*OFF)
     D iopt            s             10i 0 inz(0)
     D pTop            s               *   inz(*NULL)
     D pBeg            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D opt             s             10i 0 inz(0)
     D pOpt            s               *   inz(%addr(opt))
     D len             s             10i 0 inz(0)
     D doCtl1          s           1032A   inz(*BLANKS)
     D doDefault       ds                  likeds(sqOpt_t)
     D pOpt2           s               *   inz(*NULL)
     D doFlags         ds                  likeds(sqOpt_t)
     D                                     based(pOpt2)
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
     D jvm             S              1N   inz(*OFF)
      /free
       Monitor;

       // *** old connection ***
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         return *OFF;
       endif;
       // *** old options attached
       if options = *BLANKS and option1 <> *BLANKS;
         options = option1;
       endif;
       // *** old options
       rc = cacScanOPT(CAC_OPT_ACTIVE:iopt:options:pOpt2);
       // *** new options (default) ***
       if rc = *OFF or pOpt2 = *NULL;
         pOpt2 = %addr(doDefault);
         rc =db2_options_ctor(pOpt2);
       endif;
       rc=cacScanDB2(CAC_CONN_UPDATE:icon:henv:hdbc
                  :conn:options:db:uid:pwd);

       // ** server mode only work private connection **
       // servermode='on' (global env level)
       // A job must set the server mode at the very beginning 
       // of processing before doing anything else. For jobs 
       // that are strictly CLI users, they must use the 
       // SQLSetEnvAttr call to turn on server mode. 
       // Remember to do this right after SQLAllocEnv but 
       // before any other calls. As soon as the server mode is on, 
       // it cannot be turned off.

       // running JVM in process (1.9.2)
       jvm = ipcDoJVM();
       if jvm = *ON;
         sTooLate = *ON;
         // must assure PASE start
         rc = ileStatic(XML_PGM_OPM_FALSE);
       endif;

       if doFlags.sqSrvMode = *ON and sTooLate = *OFF;
         opt = DB2_TRUE;
         DB2_RC=db2SetEnvAttr(henv:DB2_ATTR_SERVER_MODE:pOpt:0);
         if DB2_RC < DB2_SUCCESS;
           // jvm within QSQ ignore (1.9.2)
           if jvm = *OFF;
             rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
             return *OFF;
           endif;
         else;
           sServMode = *ON;
         endif;
       endif;
       sTooLate = *ON;

       // -------------
       // error
       On-error;
         return *OFF;
       Endmon;

       // good
       return *ON;
      /end-free
     P                 E

     P db2_connect_libl...
     P                 B
     D db2_connect_libl...        
     D                 PI             1N
     D  conn                         10A
     D  sqlCode                      10I 0
      * vars
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D desc            s              1N   inz(*OFF)
     D block           s             10i 0 inz(-1)
     D stmt            s             10A   inz('deadbeef')
      * connection
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D hlen            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
     D options         s             10A   inz(*BLANKS)
      * options
     D iopt            s             10i 0 inz(0)
     D pOpt2           s               *   inz(*NULL)
     D doFlags         ds                  likeds(sqOpt_t)
     D                                     based(pOpt2)
      * sql statement
     D tmp             s           2048A   inz(*BLANKS)
     D tmpl            s             10i 0 inz(0)
     D query           s           2048A   inz(*BLANKS)
     D stmt_str        s               *   inz(*NULL)
     D stmt_len        s             10I 0 inz(0)
      /free
       // *** connection ***
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         return *ON;
       endif;
       // *** old options
       rc = cacScanOPT(CAC_OPT_ACTIVE:iopt:option1:pOpt2);
       // *** new options (default) ***
       if rc = *OFF or pOpt2 = *NULL;
         return *ON;
       endif;
       // no chglibl
       if doFlags.sqLIBL = *BLANKS or doFlags.sqLIBLlen < 4;
         return *ON;
       endif;

       // change libl
       tmp = doFlags.sqLIBL;
       tmpl = doFlags.sqLIBLlen;
       if db2_option_is_sql_naming(option1) = *ON;
         query = 'CALL QSYS2.QCMDEXC(''';
       else;
         query = 'CALL QSYS2/QCMDEXC(''';
       endif;
       query = %trim(query) + %trim(tmp) + ''',' + %char(tmpl) + ')';
       stmt_str = %addr(query);
       stmt_len = %len(%trim(query));
       rc =db2_query(conn:stmt_str:stmt_len:stmt:options:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E

     P db2_conn_options...
     P                 B                   export
     D db2_conn_options...        
     D                 PI             1N
     D  conn                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0
      * vars
     D rc              s              1N   inz(*OFF)
     D iopt            s             10i 0 inz(0)
     D pTop            s               *   inz(*NULL)
     D pBeg            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D opt             s             10i 0 inz(0)
     D pOpt            s               *   inz(%addr(opt))
     D len             s             10i 0 inz(0)
     D doCtl1          s           1032A   inz(*BLANKS)
     D doDefault       ds                  likeds(sqOpt_t)
     D pOpt2           s               *   inz(*NULL)
     D doFlags         ds                  likeds(sqOpt_t)
     D                                     based(pOpt2)
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
      /free
       Monitor;

       // *** old connection ***
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         return *OFF;
       endif;
       // *** old options attached
       if options = *BLANKS and option1 <> *BLANKS;
         options = option1;
       endif;
       // *** old options
       rc = cacScanOPT(CAC_OPT_ACTIVE:iopt:options:pOpt2);
       // *** new options (default) ***
       if rc = *OFF or pOpt2 = *NULL;
         pOpt2 = %addr(doDefault);
         rc =db2_options_ctor(pOpt2);
       endif;
       rc=cacScanDB2(CAC_CONN_UPDATE:icon:henv:hdbc
                  :conn:options:db:uid:pwd);

       // *naming='system|sql'
       if doFlags.sqNamSQL  = *ON;
         opt = DB2_FALSE;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DBC_SYS_NAMING:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       else;
         opt = DB2_TRUE;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DBC_SYS_NAMING:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *commit='none|uncomitted|committed|repeatable|serializable'
       if doFlags.sqComNone = *ON;
         opt = DB2_TXNNON;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_TXNISO:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqComUnCom = *ON;
         opt = DB2_TXNUNC;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_TXNISO:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqComCommi = *ON;
         opt = DB2_TXNCOM;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_TXNISO:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqComRepea = *ON;
         opt = DB2_TXNREP;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_TXNISO:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqComSeria = *ON;
         opt = DB2_TXNSER;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_TXNISO:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *autocommit='on|off'
       if doFlags.sqAutoComm = *ON;
         opt = DB2_TRUE;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_AUTOCOMMIT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       else;
         opt = DB2_FALSE;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_AUTOCOMMIT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *datefmt='iso|usa|eur|jis|mdy|dmy|ymd|jul|job'
       if doFlags.sqDFmtJOB = *ON;
         opt = DB2_FMT_JOB;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDFmtISO = *ON;
         opt = DB2_FMT_ISO;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDFmtUSA = *ON;
         opt = DB2_FMT_USA;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDFmtEUR = *ON;
         opt = DB2_FMT_EUR;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDFmtJIS = *ON;
         opt = DB2_FMT_JIS;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDFmtMDY = *ON;
         opt = DB2_FMT_MDY;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDFmtDMY = *ON;
         opt = DB2_FMT_DMY;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDFmtYMD = *ON;
         opt = DB2_FMT_YMD;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDFmtJUL = *ON;
         opt = DB2_FMT_JUL;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *datesep='slash|dash|period|comma|blank|job'
       if doFlags.sqDSepJOB  = *ON;
         opt = DB2_SEP_JOB;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDSepSlas = *OFF;
         opt = DB2_SEP_SLASH;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDSepDash = *ON;
         opt = DB2_SEP_DASH;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDSepDot  = *ON;
         opt = DB2_SEP_PERIOD;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDSepComa = *ON;
         opt = DB2_SEP_COMMA;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqDSepBlk  = *ON;
         opt = DB2_SEP_BLANK;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DATE_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *timefmt='iso|usa|eur|jis|hms|job'
       if doFlags.sqTFmtJOB = *ON;
         opt = DB2_FMT_JOB;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTFmtISO = *ON;
         opt = DB2_FMT_ISO;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTFmtUSA = *ON;
         opt = DB2_FMT_USA;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTFmtEUR = *ON;
         opt = DB2_FMT_EUR;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTFmtJIS = *ON;
         opt = DB2_FMT_JIS;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTFmtHMS = *ON;
         opt = DB2_FMT_HMS;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_FMT:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *timesep='colon|period|comma|blank|job'
       if doFlags.sqTSepJOB  = *ON;
         opt = DB2_SEP_JOB;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTSepColn = *ON;
         opt = DB2_SEP_COLON;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTSepDot  = *ON;
         opt = DB2_SEP_PERIOD;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTSepComa = *ON;
         opt = DB2_SEP_COMMA;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqTSepBlk  = *ON;
         opt = DB2_SEP_BLANK;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_TIME_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *decimalsep='period|comma|blank|job'
       if doFlags.sqPSepJOB  = *ON;
         opt = DB2_SEP_JOB;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DECIMAL_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqPSepDot  = *ON;
         opt = DB2_SEP_PERIOD;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DECIMAL_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqPSepComa = *ON;
         opt = DB2_SEP_COMMA;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DECIMAL_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqPSepBlk  = *ON;
         opt = DB2_SEP_BLANK;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DECIMAL_SEP:pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *optimize='first|all'
       if doFlags.sqOptzFrst = *ON;
         opt = DB2_FIRST_IO;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_QUERY_OPTIMIZE_GOAL:
                                  pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       elseif doFlags.sqOptzAll  = *ON;
         opt = DB2_ALL_IO;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_QUERY_OPTIMIZE_GOAL:
                                  pOpt:DB2_NTS);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // *sqllib='mylib'
       if doFlags.sqLIB <> *BLANKS;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DBC_DEFAULT_LIB:
                           %addr(doFlags.sqLIB):
                           doFlags.sqLIBlen);
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
           return *OFF;
         endif;
       endif;

       // -------------
       // error
       On-error;
         return *OFF;
       Endmon;

       // good
       return *ON;
      /end-free
     P                 E

     P db2_stmt_options...
     P                 B                   export
     D db2_stmt_options...        
     D                 PI             1N
     D  stmt                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0
      * vars
     D rc              s              1N   inz(*OFF)
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D istm            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
     D opt             s             10i 0 inz(0)
     D pOpt            s               *   inz(%addr(opt))
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      * options
     D iopt            s             10i 0 inz(0)
     D doDefault       ds                  likeds(sqOpt_t)
     D pOpt2           s               *   inz(*NULL)
     D doFlags         ds                  likeds(sqOpt_t)
     D                                     based(pOpt2)
      /free
       Monitor;

       // cannot find hstmt active?
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;

       // find old options?
       rc = cacScanOPT(CAC_OPT_ACTIVE:iopt:options:pOpt2);
       // *** options (default) ***
       if rc = *OFF or pOpt2 = *NULL;
         return *ON; // nothing to do
       endif;

       // STMT level ...

       // scrollable='on|off'
       if doFlags.sqScMiss = *OFF;
         if doFlags.sqScroll = *ON;
           opt = DB2_TRUE;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_CURSOR_SCROLLABLE:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         elseif doFlags.sqScroll = *OFF;
           opt = DB2_FALSE;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_CURSOR_SCROLLABLE:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         endif;
       endif;

       // sensitive='unspecified|sensitive|insensitive'
       if doFlags.sqSenMiss = *OFF;
         if doFlags.sqSenUn = *ON;
           opt = DB2_UNSPECIFIED;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_CURSOR_SENSITIVITY:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         elseif doFlags.sqSenOn = *ON;
           opt = DB2_SENSITIVE;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_CURSOR_SENSITIVITY:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         elseif doFlags.sqSenOFF = *ON;
           opt = DB2_INSENSITIVE;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_CURSOR_SENSITIVITY:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         endif;
       endif;

       // cursor='forward|static|dynamic'
       if doFlags.sqCurMiss = *OFF;
         if doFlags.sqCurFwd = *ON;
           opt = DB2_CURSOR_FORWARD_ONLY;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_CURSOR_TYPE:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         elseif doFlags.sqCurStat = *ON;
           opt = DB2_CURSOR_STATIC;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_CURSOR_TYPE:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         elseif doFlags.sqCurDyn = *ON;
           opt = DB2_CURSOR_DYNAMIC;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_CURSOR_TYPE:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         endif;
       endif;

       // fetchonly='on|off'
       doFlags.sqFetMiss         = *ON;
       doFlags.sqFetOnly         = *OFF;
       if doFlags.sqFetMiss = *OFF;
         if doFlags.sqFetOnly = *ON;
           opt = DB2_TRUE;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_FOR_FETCH_ONLY:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         elseif doFlags.sqFetOnly = *OFF;
           opt = DB2_FALSE;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_FOR_FETCH_ONLY:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         endif;
       endif;

       // fullopen='on|off'
       if doFlags.sqFullMiss = *OFF;
         if doFlags.sqFullOpn = *ON;
           opt = DB2_TRUE;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_FULL_OPEN:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         elseif doFlags.sqFullOpn = *OFF;
           opt = DB2_FALSE;
           DB2_RC=db2SetStmtAttr(hstmt
             :DB2_ATTR_FULL_OPEN:pOpt:DB2_NTS);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         endif;
       endif;

       // -------------
       // error
       On-error;
         return *OFF;
       Endmon;

       // good
       return *ON;
      /end-free
     P                 E

     P db2_options_free...
     P                 B                   export
     D db2_options_free...        
     D                 PI             1N
     D  options                      10A   value
      * vars
     D rc              s              1N   inz(*OFF)
     D iopt            s             10i 0 inz(0)
     D pOpt2           s               *   inz(*NULL)
      /free
       // *** old connection ***
       rc = cacScanOPT(CAC_OPT_DELETE:iopt:options:pOpt2);
       return rc; // @ADC error 1.7.1
      /end-free
     P                 E

     P db2_options_free_all...
     P                 B                   export
     D db2_options_free_all...        
     D                 PI             1N
      * vars
     D rc              s              1N   inz(*ON)
     D iopt            s             10i 0 inz(0)
     D label           s             10A   inz(*BLANKS)
     D pOpt2           s               *   inz(*NULL)
      /free
       dow rc = *ON;
         rc = cacScanOPT(CAC_OPT_ANY:iopt:label:pOpt2);
         if rc = *ON;
           rc =db2_options_free(label);
         endif;
       enddo;
       // good
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect
      *****************************************************
     P db2_connect_default...
     P                 B                   export
     D db2_connect_default...        
     D                 PI             1N
     D  conn                         10A
      * vars
     D rc              s              1N   inz(*OFF)
     D options         s             10A   inz(*BLANKS)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D sqlCode         s             10I 0 inz(0)
      /free
       return db2_connect(conn:options:db:uid:pwd:sqlCode);
      /end-free
     P                 E

     P db2_connect...
     P                 B                   export
     D db2_connect...        
     D                 PI             1N
     D  label                        10A
     D  options                      10A
     D  idb                          10A
     D  iuid                         10A
     D  ipwd                         10A
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D rc1             s              1N   inz(*OFF)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
     DDBName           S             18A   inz(*BLANKS)
     DDBNameP          S               *   INZ(%ADDR(DBName))
     DDBUser           S             10A   inz(*BLANKS)
     DDBUserP          S               *   INZ(%ADDR(DBUser))
     DDBPwd            S             10A   inz(*BLANKS)
     DDBPwdP           S               *   INZ(%ADDR(DBPwd))
     DZeroBin          S            128A   INZ(*ALLX'00')
     Dnolabel          S             10A   inz(*BLANKS)
     D jvm             S              1N   inz(*OFF)
     D hstmt           s             10I 0 inz(0)
      /free
       Monitor;
       db  = idb;
       uid = iuid;
       pwd = ipwd;

       // *** old connection (servermode='on') ***
       // server mode can have mutiple connections/transactions
       if sServMode = *ON;
         // exact label match?
         rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
                :label:option1:db:uid:pwd);
         if rc = *ON;
           nolabel = label; // match
         // any db, uid, pwd match?
         else;
           rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
                  :nolabel:option1:db:uid:pwd);
         endif;
       // *** old connection (servermode='na' or default off) ***
       // non-server mode can have one and only one connection/transaction
       else;
         // any db, uid, pwd match?
         rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
                :nolabel:option1:db:uid:pwd);
         if rc = *ON;
           if label = *BLANKS;
             label = nolabel; // match
           endif;
         // any connection at all?
         else;
           rc = cacScanDB2(CAC_CONN_ANY:icon:henv:hdbc
                  :nolabel:option1:db:uid:pwd);
         endif;
       endif;
       // *** old options attached
       if options = *BLANKS and option1 <> *BLANKS;
         options = option1;
       endif;
       if rc = *ON;
         // connection found, with match label
         if nolabel = label;
           // re-apply options (adc think maybe not???)
           rc =db2_conn_options(label:options:sqlCode);
           if rc = *OFF;
             errsSevere(XML_ERROR_SQL_CONN_OPTIONS:
               %trim(label)+':'+%trim(options)+':'+%trim(db)+':'+%trim(uid));
             rc1 =db2_connect_free(label);
             return *OFF;
           endif;
           // apply libl options (adc think maybe not???)
           rc = db2_connect_libl(label:sqlCode);
           if rc = *OFF;
             errsSevere(XML_ERROR_SQL_CONN_OPTIONS:
                %trim(label)+':'+%trim(options)+':'+%trim(db)+':'+%trim(uid));
             rc1=db2_connect_free(label);
             return *OFF;
           endif;
           idb  = db;
           iuid = uid;
           ipwd = pwd;
           sqlCode = SQL_CODE_REUSED;
           return *ON;
         // connection found, but not match label
         else;
           errsSevere(XML_ERROR_SQL_CONN_ACTIVE:
             %trim(label)+':'+%trim(idb)+':'+%trim(iuid)
             +'<>'
             +%trim(nolabel)+':'+%trim(db)+':'+%trim(uid));
           return *OFF;
         endif;
       endif;

       // *** new connection ***
       db  = idb;
       uid = iuid;
       pwd = ipwd;
       rc = cacScanDB2(CAC_CONN_NEW:icon:henv:hdbc
              :label:options:db:uid:pwd);
       if rc = *OFF;
          errsSevere(XML_ERROR_SQL_CONN_MAX:
            %trim(label)+':'+%trim(db)+':'+%trim(uid));
          rc1=db2_connect_free(label);
         return *OFF;
       endif;

       // new/same env (scope application/job)
       DB2_RC=db2AllocEnv(henv);
       if DB2_RC < DB2_SUCCESS;
         errsSevere(XML_ERROR_SQL_CONN_HENV:
            %trim(label)+':'+%trim(db)+':'+%trim(uid));
         rc1=db2_connect_free(label);
         return *OFF;
       endif;
       rc=cacScanDB2(CAC_CONN_UPDATE:icon:henv:hdbc
            :label:options:db:uid:pwd);
       // apply env options
       rc = db2_env_options(label:options:sqlCode);
       if rc = *OFF;
         errsSevere(XML_ERROR_SQL_CONN_OPTIONS:
            %trim(label)+':'+%trim(options)+':'+%trim(db)+':'+%trim(uid));
         rc1=db2_connect_free(label);
         return *OFF;
       endif;

       // running JVM in process (1.9.2)
       jvm = ipcDoJVM();

       if jvm = *OFF; // running JVM in process (1.9.2)
       // new hdbc
       DB2_RC=db2AllocConnect(henv:hdbc);
       if DB2_RC < DB2_SUCCESS;
         errsSevere(XML_ERROR_SQL_CONN_HDBC:
            %trim(label)+':'+%trim(db)+':'+%trim(uid));
         rc1=db2_connect_free(label);
         return *OFF;
       endif;
       else;
         // find active hdbc mr wizard of hack
         for hdbc = 1 to 100; // hack, should be handle 2
           DB2_RC=db2AllocStmt(hdbc:hstmt);
           if DB2_RC = DB2_SUCCESS;
             DB2_RC1=db2_stmt_free_monitor(hstmt);
             leave;
           endif;
         endfor;
       endif;
       rc = cacScanDB2(CAC_CONN_UPDATE:icon:henv:hdbc
              :label:options:db:uid:pwd);

       if jvm = *OFF; // running JVM in process (1.9.2)

       // apply options
       rc =db2_conn_options(label:options:sqlCode);
       if rc = *OFF;
         errsSevere(XML_ERROR_SQL_CONN_OPTIONS:
            %trim(label)+':'+%trim(options)+':'+%trim(db)+':'+%trim(uid));
         rc1=db2_connect_free(label);
         return *OFF;
       endif;

       // new connection
       if db = *BLANKS 
       and uid = *BLANKS 
       and pwd = *BLANKS;
         DB2_RC=db2Connect(hdbc:
                           *NULL:0:
                           *NULL:0:
                           *NULL:0);
       else;
         DBName = %TRIM(db) + Zerobin;
         DBUser = %TRIM(uid) + Zerobin;
         DBPwd  = %TRIM(pwd) + Zerobin;
         DB2_RC=db2Connect(hdbc:
                           DBNameP:DB2_NTS:
                           DBUserP:DB2_NTS:
                           DBPwdP:DB2_NTS);
       endif;
       if DB2_RC < DB2_SUCCESS;
         errsSevere(XML_ERROR_SQL_CONN_FAIL:
           %trim(label)+':'+%trim(db)+':'+%trim(uid));
         rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
         rc1=db2_connect_free(label);
         return *OFF;
       endif;

       endif;

       // apply libl options
       rc = db2_connect_libl(label:sqlCode);
       if rc = *OFF;
         errsSevere(XML_ERROR_SQL_CONN_OPTIONS:
            %trim(label)+':'+%trim(options)+':'+%trim(db)+':'+%trim(uid));
         rc1=db2_connect_free(label);
         return *OFF;
       endif;

       // -------------
       // error
       On-error;
         errsSevere(XML_ERROR_SQL_CONN_EXCEPTION:
           %trim(label)+':'+%trim(db)+':'+%trim(uid));
         return *OFF;
       Endmon;

       // good connection
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI commit or rollback
      *****************************************************
     P db2_end_transaction...
     P                 B                   export
     D db2_end_transaction...        
     D                 PI             1N
     D  conn                         10A
     D  rollback                      1N   value
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D sqlCode         s             10I 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
      /free
       Monitor;
       
       sqlCode = 0;

       // *** old connection ***
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
             :conn:option1:db:uid:pwd);
       if rc = *OFF;
         return *OFF;
       endif;

       // need rollback or commit
       if rollback = *ON;
         DB2_RC=db2EndTran(DB2_HANDLE_DBC:hdbc:DB2_ROLLBACK);
       else;
         DB2_RC=db2EndTran(DB2_HANDLE_DBC:hdbc:DB2_COMMIT);
       endif;

       if DB2_RC < DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
         // rc=db2_connect_free(conn); avoid recursive error
         return *OFF;
       endif;

       // -------------
       // error
       On-error;
         return *OFF;
       Endmon;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI free 
      *****************************************************
     P db2_connect_free...
     P                 B                   export
     D db2_connect_free...        
     D                 PI             1N
     D  conn                         10A   value
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D sqlCode         s             10I 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
     D label           s             10A   inz(*BLANKS)
     D lenv            s             10I 0 inz(0)
      /free
       Monitor;

       // *** old connection ***
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *ON;

         // autocommit=*ON, rollback=*OFF (commit) 
         // autocommit=*OFF, rollback=*ON (rollback)
         if db2_option_is_autocommit(option1) = *ON;
           rc=db2_end_transaction(conn:*OFF);
         else;
           rc=db2_end_transaction(conn:*ON);
         endif;

         // free all statements
         rc =db2_connect_free_stmts(conn);

         // free connection resources 
         DB2_RC1=db2_disconnect_monitor(hdbc);
         DB2_RC1=db2_conn_free_monitor(hdbc);
         lenv = henv; // save env handle

         // remove cache
         rc = cacScanDB2(CAC_CONN_DELETE:icon:henv:hdbc
                :conn:option1:db:uid:pwd);

         // any active connections remaining (keep henv alive)???
         rc = cacScanDB2(CAC_CONN_ANY:icon:henv:hdbc
                :label:option1:db:uid:pwd);
         if rc = *OFF;
           DB2_RC1=db2_env_free_monitor(lenv);
           // once in server mode job cannot
           // return back to inline mode (CLI rule)
           if sServMode = *OFF;
             sTooLate = *OFF;
             sServMode = *OFF;
           endif;
         endif;

       endif;

       // -------------
       // error
       On-error;
         return *OFF;
       Endmon;

       return rc; // @ADC error 1.7.1
      /end-free
     P                 E

     P db2_connect_free_all...
     P                 B                   export
     D db2_connect_free_all...        
     D                 PI             1N
      * vars
     D rc              s              1N   inz(*ON)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D label           s             10A   inz(*BLANKS)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
      /free
       dow rc = *ON;
         rc = cacScanDB2(CAC_CONN_ANY:icon:henv:hdbc
                :label:option1:db:uid:pwd);
         if rc = *ON;
           rc =db2_connect_free(label);
         endif;
       enddo;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement parameter description number
      *****************************************************
     P db2_parm_desc_nbr...
     P                 B                   export
     D db2_parm_desc_nbr...        
     D                 PI             1N
     D  stmt                         10A
     D  nParms                        5I 0
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       nParms = 0;
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;
       // *** old description result columns ***
       if nParms > 0;
         sqlCode = SQL_CODE_REUSED;
         return *ON;
       endif;
       // *** new description result columns ***
       DB2_RC=db2NumParams(hstmt:%addr(nParms));
       if DB2_RC < DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement parameter description
      *****************************************************
     P db2_parm_desc...
     P                 B                   export
     D db2_parm_desc...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;
       // *** old description result columns ***
       if nParms > 0;
         sqlCode = SQL_CODE_REUSED;
         return *ON;
       endif;
       // *** new description result columns ***
       DB2_RC=db2NumParams(hstmt:%addr(nParms));
       if DB2_RC < DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         return *OFF;
       endif;
       // no parms
       if nParms < 1;
         return *ON;
       endif;
       // allocate description area 
       rc = cacScanStm(CAC_STMT_ALLOC_PARMT:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if pparmT1st = *NULL;
         return *OFF;
       endif;
       // get column decription
       for i = 1 to nParms;
         pparmT = pparmT1st + %size(hParm_t) * (i-1);
         DB2_RC=db2DescribeParam(hstmt:i:
                %addr(parmT.type):
                %addr(parmT.size):
                %addr(parmT.scale):
                %addr(parmT.nullable));
         parmT.olen     = 0;
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
           rc = cacScanStm(CAC_STMT_DEALLOC_PARMT
              :istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
           return *OFF;
         endif;
         // *** give it a name ***
         if parmT.nlen < 1;
           parmT.name = %char(i);
           parmT.nlen = %len(%trim(parmT.name));
         endif;
         // *** mapping XML types ****
         parmT.xAttr   = XML_ATTR_VAL_A;
         parmT.xDigits = parmT.size;
         // data values
         select;
         when parmT.type = DB2_CHAR;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_NUMERIC;
           parmT.xAttr = XML_ATTR_VAL_S;
         when parmT.type = DB2_DECIMAL;
           parmT.xAttr = XML_ATTR_VAL_P;
         when parmT.type = DB2_INTEGER;
           parmT.xAttr = XML_ATTR_VAL_I;
           parmT.xDigits = parmT.size * 2;
         when parmT.type = DB2_SMALLINT;
           parmT.xAttr = XML_ATTR_VAL_I;
           parmT.xDigits = parmT.size * 2;
         when parmT.type = DB2_FLOAT;
           parmT.xAttr = XML_ATTR_VAL_F;
           parmT.scale = 2;
         when parmT.type = DB2_REAL;
           parmT.xAttr = XML_ATTR_VAL_F;
           parmT.scale = 2;
         when parmT.type = DB2_DOUBLE;
           parmT.xAttr = XML_ATTR_VAL_D;
           parmT.scale = 2;
         when parmT.type = DB2_DATETIME;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_VARCHAR;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_CLOB;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_BLOB;
           parmT.xAttr = XML_ATTR_VAL_B;
         when parmT.type = DB2_DBCLOB;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_GRAPHIC;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_VARGRAPHIC;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_DATE;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_TIME;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_TIMESTAMP;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_WCHAR;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_WVARCHAR;
           parmT.xAttr = XML_ATTR_VAL_A;
         when parmT.type = DB2_BIGINT;
           parmT.xAttr = XML_ATTR_VAL_I;
           parmT.xDigits = parmT.size * 2;
         when parmT.type = DB2_BINARY;
           parmT.xAttr = XML_ATTR_VAL_B;
         when parmT.type = DB2_VARBINARY;
           parmT.xAttr = XML_ATTR_VAL_B;
         when parmT.type = DB2_BINARY_V6;
           parmT.xAttr = XML_ATTR_VAL_B;
         when parmT.type = DB2_VARBINARY_V6;
           parmT.xAttr = XML_ATTR_VAL_B;
         when parmT.type = DB2_DECFLOAT;
           parmT.xAttr = XML_ATTR_VAL_B;
         //when parmT.type = DB2_XML;
         // other?
         other;
         endsl;

       endfor;
       // update description
       rc = cacScanStm(CAC_STMT_UPDATE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement bind parameter
      *****************************************************
     P db2_parm_bind...
     P                 B                   export
     D db2_parm_bind...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  sqlParm1                       *
      * compiler bug workaround
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     D                                     based(sqlParm1)
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s              5I 0 inz(0)
     D iotype          s              5I 0 inz(0)
     D ctype           s              5I 0 inz(0)
     D ptype           s              5I 0 inz(0)
     D len             s             10I 0 inz(0)
     D scale           s              5I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      * node
     D node            ds                  likeds(xmlNode_t)
     D start           s               *   inz(*NULL)
     D pAtP            s               *   inz(*NULL)
     D pout            s               *   inz(*NULL)
      /free
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF or nCols < 0;
         return *OFF;
       endif;
       // *** new set column binding ***
       i = ileSzParm(start);
       for i = 1 to nParms;
         pparmT = pparmT1st + %size(hParm_t) * (i-1);

         // input parms needed
         if sqlParm(i).rawP <> *NULL;
           sqlParm(i).parmP   = *NULL;
           sqlParm(i).parmlen = 0;
         else;
           return *OFF;
         endif;

         // xml node for push/pop
         xmlCTOR(node);
         if xmlGetCDATA() = *ON;
           node.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
         endif;
         node.xmlPrmRet = XML_IS_PARM;
         node.pgmArgTop = XML_PGM_TOP_FALSE;
         node.xmlStrP   = sqlParm(i).rawP;
         node.xmlStrSz  = sqlParm(i).rawlen;
         node.xmlBy     = XML_BY_VAL;
         node.xmlAttr   = parmT.xAttr;
         node.xmlDigits = parmT.xDigits;
         node.xmlFrac   = parmT.scale;
         parmT.olen     = node.xmlStrSz; // (1.8.4)
         pout           = %addr(parmT.olen);
         iotype         = DB2_PARAM_INPUT_OUTPUT;
         ptype          = parmT.type;
         scale          = parmT.scale;

         // data values
         select;
         when parmT.type = DB2_CHAR
           or parmT.type = DB2_VARCHAR;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = parmT.size;
           ctype= DB2_CHAR;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when parmT.type = DB2_WCHAR
           or parmT.type = DB2_WVARCHAR
           or parmT.type = DB2_GRAPHIC
           or parmT.type = DB2_VARGRAPHIC;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = parmT.size;
           ctype= DB2_CHAR;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when parmT.type = DB2_INTEGER
           or parmT.type = DB2_SMALLINT
           or parmT.type = DB2_BIGINT;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           if parmT.type = DB2_BIGINT;
             len  = 8;
           else;
             len  = parmT.size;
           endif;
           ctype= DB2_DEFAULT;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when parmT.type = DB2_FLOAT
           or parmT.type = DB2_REAL
           or parmT.type = DB2_DOUBLE
           or parmT.type = DB2_DECFLOAT;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = parmT.size;
           ctype= DB2_DEFAULT;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when parmT.type = DB2_DATETIME
           or parmT.type = DB2_DATE
           or parmT.type = DB2_TIME
           or parmT.type = DB2_TIMESTAMP;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = parmT.size;
           ctype= DB2_CHAR;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when parmT.type = DB2_NUMERIC
           or parmT.type = DB2_DECIMAL;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = parmT.size;
           ctype= DB2_DEFAULT;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when parmT.type = DB2_BINARY
           or parmT.type = DB2_VARBINARY
           or parmT.type = DB2_BINARY_V6
           or parmT.type = DB2_VARBINARY_V6;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = parmT.size;
           if parmT.type = DB2_BINARY
           or parmT.type = DB2_VARBINARY;
             ctype= DB2_BINARY;
           else;
             ctype= DB2_BINARY_V6;
           endif;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when parmT.type = DB2_BLOB;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = parmT.size;
           if sV5Binary = *ON;
             ctype= DB2_BINARY;
           else;
             ctype= DB2_BINARY_V6;
           endif;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when parmT.type = DB2_CLOB
           or parmT.type = DB2_DBCLOB;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = parmT.size;
           ctype= DB2_CHAR;
           // bind location
           DB2_RC=db2BindParameter(hstmt:i:iotype:ctype:ptype
                    :len:scale:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         //when parmT.type = DB2_XML;
         // other?
         other;
           return *OFF;
         endsl;

         // output parms needed (possible)
         sqlParm(i).parmP   = pAtP;
         sqlParm(i).parmlen = len;

       endfor;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement column description number
      *****************************************************
     P db2_col_desc_nbr...
     P                 B                   export
     D db2_col_desc_nbr...        
     D                 PI             1N
     D  stmt                         10A
     D  nCols                         5I 0
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       nCols = 0;
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;
       // *** old description result columns ***
       if nCols > 0;
         sqlCode = SQL_CODE_REUSED;
         return *ON;
       endif;
       // *** new description result columns ***
       DB2_RC=db2NumResultCols(hstmt:%addr(nCols));
       if DB2_RC < DB2_SUCCESS or nCols < 1;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI statement column description
      *****************************************************
     P db2_col_desc...
     P                 B                   export
     D db2_col_desc...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;
       // *** old description result columns ***
       if nCols > 0;
         sqlCode = SQL_CODE_REUSED;
         return *ON;
       endif;
       // *** new description result columns ***
       DB2_RC=db2NumResultCols(hstmt:%addr(nCols));
       if DB2_RC < DB2_SUCCESS or nCols < 1;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         return *OFF;
       endif;
       // allocate description area 
       rc = cacScanStm(CAC_STMT_ALLOC_COLT:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if pcolT1st = *NULL;
         return *OFF;
       endif;
       // get column decription
       for i = 1 to nCols;
         pcolT = pcolT1st + %size(hCol_t) * (i-1);
         DB2_RC=db2DescribeCol(hstmt:i:
                %addr(colT.name):%size(colT.name):
                %addr(colT.nlen):
                %addr(colT.type):
                %addr(colT.size):
                %addr(colT.scale):
                %addr(colT.nullable));
         // ignore null terminator
         colT.nlen     = %len(%trim(colT.name));
         if colT.nlen > 1;
           colT.nlen -= 1;
         endif;
         colT.olen     = 0;
         if DB2_RC < DB2_SUCCESS;
           rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
           rc = cacScanStm(CAC_STMT_DEALLOC_COLT
              :istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
           return *OFF;
         endif;
         // *** give it a name ***
         if colT.nlen < 1;
           colT.name = %char(i);
           colT.nlen = %len(%trim(colT.name));
         endif;
         // *** mapping XML types ****
         colT.xAttr   = XML_ATTR_VAL_A;
         colT.xDigits = colT.size;
         // data values
         select;
         when colT.type = DB2_CHAR;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_NUMERIC;
           colT.xAttr = XML_ATTR_VAL_S;
         when colT.type = DB2_DECIMAL;
           colT.xAttr = XML_ATTR_VAL_P;
         when colT.type = DB2_INTEGER;
           colT.xAttr = XML_ATTR_VAL_I;
           colT.xDigits = colT.size * 2;
         when colT.type = DB2_SMALLINT;
           colT.xAttr = XML_ATTR_VAL_I;
           colT.xDigits = colT.size * 2;
         when colT.type = DB2_FLOAT;
           colT.xAttr = XML_ATTR_VAL_F;
           colT.scale = 2;
         when colT.type = DB2_REAL;
           colT.xAttr = XML_ATTR_VAL_F;
           colT.scale = 2;
         when colT.type = DB2_DOUBLE;
           colT.xAttr = XML_ATTR_VAL_D;
           colT.scale = 2;
         when colT.type = DB2_DATETIME;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_VARCHAR;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_CLOB;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_BLOB;
           colT.xAttr = XML_ATTR_VAL_B;
         when colT.type = DB2_DBCLOB;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_GRAPHIC;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_VARGRAPHIC;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_DATE;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_TIME;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_TIMESTAMP;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_WCHAR;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_WVARCHAR;
           colT.xAttr = XML_ATTR_VAL_A;
         when colT.type = DB2_BIGINT;
           colT.xAttr = XML_ATTR_VAL_I;
           colT.xDigits = colT.size * 2;
         when colT.type = DB2_BINARY;
           colT.xAttr = XML_ATTR_VAL_B;
         when colT.type = DB2_VARBINARY;
           colT.xAttr = XML_ATTR_VAL_B;
         when colT.type = DB2_BINARY_V6;
           colT.xAttr = XML_ATTR_VAL_B;
         when colT.type = DB2_VARBINARY_V6;
           colT.xAttr = XML_ATTR_VAL_B;
         when colT.type = DB2_DECFLOAT;
           colT.xAttr = XML_ATTR_VAL_B;
         //when colT.type = DB2_XML;
         // other?
         other;
         endsl;

       endfor;
       // update description
       rc = cacScanStm(CAC_STMT_UPDATE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement bind column
      *****************************************************
     P db2_col_bind...
     P                 B                   export
     D db2_col_bind...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s              5I 0 inz(0)
     D ctype           s              5I 0 inz(0)
     D len             s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      * node
     D node            ds                  likeds(xmlNode_t)
     D start           s               *   inz(*NULL)
     D pAtP            s               *   inz(*NULL)
     D pout            s               *   inz(*NULL)
      /free
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF or nCols < 0;
         return *OFF;
       endif;
       // *** new set column binding ***
       i = ileSzParm(start);
       for i = 1 to nCols;
         pcolT = pcolT1st + %size(hCol_t) * (i-1);

         // xml node for push/pop
         xmlCTOR(node);
         if xmlGetCDATA() = *ON;
           node.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
         endif;
         node.xmlPrmRet = XML_IS_PARM;
         node.pgmArgTop = XML_PGM_TOP_FALSE;
         node.xmlStrP   = *NULL;
         node.xmlStrSz  = 0;
         node.xmlBy     = XML_BY_VAL;
         node.xmlAttr   = colT.xAttr;
         node.xmlDigits = colT.xDigits;
         node.xmlFrac   = colT.scale;
         pout           = %addr(colT.olen);

         // data values
         select;
         when colT.type = DB2_CHAR
           or colT.type = DB2_VARCHAR;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = colT.size;
           ctype= DB2_CHAR;
           // bind location
           DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when colT.type = DB2_WCHAR
           or colT.type = DB2_GRAPHIC
           or colT.type = DB2_VARGRAPHIC
           or colT.type = DB2_WVARCHAR;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = colT.size;
           ctype= DB2_CHAR;
           // bind location
           DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when colT.type = DB2_INTEGER
           or colT.type = DB2_SMALLINT
           or colT.type = DB2_BIGINT;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           if colT.type = DB2_BIGINT;
             len = 8;
           else;
             len  = colT.size;
           endif;
           ctype= DB2_DEFAULT;
           // bind location
           DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when colT.type = DB2_FLOAT
           or colT.type = DB2_REAL
           or colT.type = DB2_DOUBLE
           or colT.type = DB2_DECFLOAT;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = colT.size;
           ctype= DB2_DEFAULT;
           // bind location
           DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when colT.type = DB2_NUMERIC
           or colT.type = DB2_DECIMAL;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = colT.size*256 + colT.scale;
           ctype= DB2_DEFAULT;
           // bind location
           DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when colT.type = DB2_DATETIME
           or colT.type = DB2_TIMESTAMP
           or colT.type = DB2_DATE
           or colT.type = DB2_TIME;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = colT.size;
           ctype= DB2_CHAR;
           // bind location
           DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when colT.type = DB2_BINARY
           or colT.type = DB2_VARBINARY
           or colT.type = DB2_BINARY_V6
           or colT.type = DB2_VARBINARY_V6;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           pAtP = start+node.pgmTruOff;
           len  = colT.size;
           if colT.type = DB2_BINARY
           or colT.type = DB2_VARBINARY;
             ctype= DB2_BINARY;
           else;
             ctype= DB2_BINARY_V6;
           endif;
           // bind location
           DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
           if DB2_RC < DB2_SUCCESS;
             rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
             return *OFF;
           endif;
         when colT.type = DB2_BLOB;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           // lob locator
           if colT.size > 32000;
             colT.lob_loc = 0;
             colT.loc_ind = 0;
             colT.loc_type = DB2_BLOB_LOCATOR;
             colT.loc_off  = node.pgmTruOff;
             // bind location
             ctype = colT.loc_type;
             pAtP  = %addr(colT.lob_loc);
             len = 4;
             pout = %addr(colT.loc_ind);
             DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
             if DB2_RC < DB2_SUCCESS;
               rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
               return *OFF;
             endif;
           // get lob
           else;
             pAtP = start+node.pgmTruOff;
             len  = colT.size;
             // bind location
             DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
             if DB2_RC < DB2_SUCCESS;
               rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
               return *OFF;
             endif;
           endif;
         when colT.type = DB2_CLOB
           or colT.type = DB2_DBCLOB;
           // make location
           rc = ilePushData(node);
           if rc = *OFF;
             return *OFF;
           endif;
           // lob locator
           if colT.size > 32000;
             colT.lob_loc = 0;
             colT.loc_ind = 0;
             if colT.type = DB2_CLOB;
               colT.loc_type = DB2_CLOB_LOCATOR;
             else;
               colT.loc_type = DB2_DBCLOB_LOCATOR;
             endif;
             colT.loc_off  = node.pgmTruOff;
             // bind location
             ctype = colT.loc_type;
             pAtP  = %addr(colT.lob_loc);
             len = 4;
             pout = %addr(colT.loc_ind);
             DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
             if DB2_RC < DB2_SUCCESS;
               rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
               return *OFF;
             endif;
           // get lob
           else;
             pAtP = start+node.pgmTruOff;
             len  = colT.size;
             ctype= DB2_CHAR;
             // bind location
             DB2_RC=db2BindCol(hstmt:i:ctype:pAtP:len:pout);
             if DB2_RC < DB2_SUCCESS;
               rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
               return *OFF;
             endif;
           endif;
         //when colT.type = DB2_XML;
         // other?
         other;
           return *OFF;
         endsl;

       endfor;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI db2Prepare 
      *****************************************************
     P db2_prepare...
     P                 B                   export
     D db2_prepare...        
     D                 PI             1N
     D  conn                         10A
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  stmt                         10A
     D  options                      10A
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D icon            s             10I 0 inz(0)
     D istm            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
     D jvm             S              1N   inz(*OFF)
     D jvmUTF16        S          65000A   inz(*BLANKS)
     D jvm_len         S             10I 0 inz(0)
     D jvm_half        S             10I 0 inz(0)
     D jvm_two         S             10I 0 inz(2)
      /free
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         rc =db2_connect_default(conn);
         if rc = *ON;
           rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
                  :conn:option1:db:uid:pwd);
         endif;
         if rc = *OFF;
           return *OFF;
         endif;
       endif;
       // already have THIS hstmt active?
       // ... then kill it ...
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *ON;
         rc1=db2_stmt_free(stmt);
       endif;
       // *** new statement ***
       rc = cacScanStm(CAC_STMT_NEW:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       DB2_RC=db2AllocStmt(hdbc:hstmt);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       rc = cacScanStm(CAC_STMT_UPDATE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       // set statement options
       rc =db2_stmt_options(stmt:options:sqlCode);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       // running JVM in process (1.9.2)
       jvm = ipcDoJVM();
       if jvm = *OFF;
         // prepare       
         DB2_RC=db2Prepare(hstmt:stmt_str:stmt_len);
       else;
         // convert to utf-16 to match java start
         jvm_len = convUTF16(stmt_str:stmt_len:
           *OFF:%addr(jvmUTF16):%size(jvmUTF16));
         if jvm_len > 1;
           jvm_half = %div(jvm_len:jvm_two);
         else;
           jvm_half = 0;
         endif;
         // prepare       
         DB2_RC=db2Prepare(hstmt:%addr(jvmUTF16):jvm_half);
       endif;
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI db2Execute 
      *****************************************************
     P db2_parm_ctor...
     P                 B                   export
     D db2_parm_ctor...        
     D                 PI             1N
     D  sqlParm1                       *
      * compiler bug workaround
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     D                                     based(sqlParm1)
      * vars
     D i               s             10I 0 inz(0)
      /free
       for i = 1 to SQLMAXPARM;
         sqlParm(i).rawP    = *NULL;
         sqlParm(i).parmP   = *NULL;
         sqlParm(i).rawlen  = 0;
         sqlParm(i).parmlen = 0;
       endfor;
       return *ON;
      /end-free
     P                 E

     P db2_execute...
     P                 B                   export
     D db2_execute...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  sqlParm1                       *
      * compiler bug workaround
     D  sqlParm        ds                  likeds(hBind_t)
     D                                     dim(SQLMAXPARM)
     D                                     based(sqlParm1)
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D icon            s             10I 0 inz(0)
     D istm            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       // cannot find hstmt active?
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;
       // any substitution parms ('call sp(?,?,?)')
       DB2_RC=db2NumParams(hstmt:%addr(nParms));
       if DB2_RC < DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // bind parameters
       if nParms > 0;
         rc =db2_parm_desc(stmt:sqlCode);
         if rc = *OFF;
           return *OFF;
         endif;
         rc =db2_parm_bind(stmt:sqlCode:sqlParm1);
         if rc = *OFF;
           return *OFF;
         endif;
       endif;
       // execute
       DB2_RC=db2Execute(hstmt);
       if DB2_RC < DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI db2Execute fetch parm 
      *****************************************************
     P db2_fetch_parm...
     P                 B                   export
     D db2_fetch_parm...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  colNbr                       10i 0
     D  outPtrP                        *
     D  sqlParm                            likeds(hBind_t)
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s              5I 0 inz(0)
     D rec             s              5I 0 inz(0)
     D len             s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
     D node            ds                  likeds(xmlNode_t)
     D start           s               *   inz(*NULL)
     D icon            s               *   inz(*NULL)
     D pout            s               *   inz(*NULL)
     D retSize         s             10I 0  inz(0)
     D trimSz          s             10I 0  inz(0)
     D forLen          s             10I 0  inz(0)
     D cType           s              5I 0  inz(0)
     D buf             s               *    inz(*NULL)
     D bufLen          s             10I 0  inz(0)
     D outLen          s             10I 0  inz(0)
     D str             s             64A   inz(*BLANKS)
     D strP            s               *   inz(%addr(str))
     D strSz           s             10i 0 inz(0)
     D pWatch          s               *   inz(*NULL)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       // do not have THIS hstmt active?
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;

       if colNbr > nParms; 
         return *OFF;
       endif;

       if sqlParm.parmP <> *NULL;
         pparmT = pparmT1st + %size(hParm_t) * (colNbr-1);

         // xml node for push/pop
         xmlCTOR(node);
         if xmlGetCDATA() = *ON;
           node.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
         endif;
         node.xmlPrmRet = XML_IS_PARM;
         node.pgmArgTop = XML_PGM_TOP_FALSE;
         node.xmlStrP   = *NULL;
         node.xmlStrSz  = 0;
         node.xmlBy     = XML_BY_VAL;
         node.xmlAttr   = parmT.xAttr;
         node.xmlDigits = parmT.xDigits;
         node.xmlFrac   = parmT.scale;
         pout           = %addr(parmT.olen);
         node.xmlIO     = sqlParm.rawIO;

         // data values
         select;
         when parmT.type = DB2_CHAR
           or parmT.type = DB2_VARCHAR;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         when parmT.type = DB2_WCHAR
           or parmT.type = DB2_WVARCHAR
           or parmT.type = DB2_GRAPHIC
           or parmT.type = DB2_VARGRAPHIC;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         when parmT.type = DB2_INTEGER
           or parmT.type = DB2_SMALLINT
           or parmT.type = DB2_BIGINT;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         when parmT.type = DB2_FLOAT
           or parmT.type = DB2_REAL
           or parmT.type = DB2_DOUBLE
           or parmT.type = DB2_DECFLOAT;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         when parmT.type = DB2_NUMERIC
           or parmT.type = DB2_DECIMAL;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         when parmT.type = DB2_DATETIME
           or parmT.type = DB2_DATE
           or parmT.type = DB2_TIME
           or parmT.type = DB2_TIMESTAMP;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         when parmT.type = DB2_BINARY
           or parmT.type = DB2_VARBINARY
           or parmT.type = DB2_BINARY_V6
           or parmT.type = DB2_VARBINARY_V6;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         when parmT.type = DB2_BLOB;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         when parmT.type = DB2_CLOB
           or parmT.type = DB2_DBCLOB;
           // location
           rc = ilePopData(outPtrP:node);
           if rc = *OFF;
             return *OFF;
           endif;
         //when parmT.type = DB2_XML;
         // other?
         other;
           return *OFF;
         endsl;
       endif;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI db2ExecDirect
      *****************************************************
     P db2_query...
     P                 B                   export
     D db2_query...        
     D                 PI             1N
     D  conn                         10A
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  stmt                         10A
     D  options                      10A
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D icon            s             10I 0 inz(0)
     D istm            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
     D jvm             S              1N   inz(*OFF)
     D jvmUTF16        S          65000A   inz(*BLANKS)
     D jvm_len         S             10I 0 inz(0)
     D jvm_half        S             10I 0 inz(0)
     D jvm_two         S             10I 0 inz(2)
      /free
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         rc =db2_connect_default(conn);
         if rc = *ON;
           rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
                  :conn:option1:db:uid:pwd);
         endif;
         if rc = *OFF;
           return *OFF;
         endif;
       endif;
       // already have THIS hstmt active?
       // ... then kill it ...
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *ON;
         rc1=db2_stmt_free(stmt);
       endif;
       // *** new statement ***
       rc = cacScanStm(CAC_STMT_NEW:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       DB2_RC=db2AllocStmt(hdbc:hstmt);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       rc = cacScanStm(CAC_STMT_UPDATE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       // set statement options
       rc =db2_stmt_options(stmt:options:sqlCode);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;



       // running JVM in process (1.9.2)
       jvm = ipcDoJVM();
       if jvm = *OFF;
         // query
         DB2_RC=db2ExecDirect(hstmt:stmt_str:stmt_len);
       else;
         // convert to utf-16 to match java start
         jvm_len = convUTF16(stmt_str:stmt_len:
           *OFF:%addr(jvmUTF16):%size(jvmUTF16));
         if jvm_len > 1;
           jvm_half = %div(jvm_len:jvm_two);
         else;
           jvm_half = 0;
         endif;
         // query
         DB2_RC=db2ExecDirect(hstmt:%addr(jvmUTF16):jvm_half);
       endif;
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI stmt free 
      *****************************************************
     P db2_stmt_free...
     P                 B                   export
     D db2_stmt_free...        
     D                 PI             1N
     D  stmt                         10A   value
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D istm            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       // *** old connection ***
       rc = cacScanStm(CAC_STMT_DELETE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *ON;
         // free stmt resources
         DB2_RC1=db2_stmt_free_monitor(hstmt);
       endif;
       return rc; // @ADC error 1.7.1
      /end-free
     P                 E

     P db2_connect_free_stmts...
     P                 B                   export
     D db2_connect_free_stmts...        
     D                 PI             1N
     D  conn                         10A   value
      * vars
     D rc              s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D label           s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       dow rc = *ON;
         rc = cacScanStm(CAC_STMT_ANY_CONN:istm:hstmt:conn:label
              :nCols:pcolT1st
              :nParms:pparmT1st);
         if rc = *ON;
           rc =db2_stmt_free(label);
         endif;
       enddo;
       // good
       return rc; // @ADC error 1.7.1
      /end-free
     P                 E

     P db2_stmt_free_all...
     P                 B                   export
     D db2_stmt_free_all...        
     D                 PI             1N
      * vars
     D rc              s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
     D label           s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       dow rc = *ON;
         rc = cacScanStm(CAC_STMT_ANY:istm:hstmt:conn:label
              :nCols:pcolT1st
              :nParms:pparmT1st);
         if rc = *ON;
           rc =db2_stmt_free(label);
         endif;
       enddo;
       // good
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement fetch description
      *****************************************************
     P db2_fetch_parm_desc...
     P                 B                   export
     D db2_fetch_parm_desc...        
     D                 PI             1N
     D  stmt                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s              5I 0 inz(0)
     D rec             s              5I 0 inz(0)
     D len             s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
     D node            ds                  likeds(xmlNode_t)
     D start           s               *   inz(*NULL)
     D icon            s               *   inz(*NULL)
     D pout            s               *   inz(*NULL)
     D retSize         s             10I 0  inz(0)
     D trimSz          s             10I 0  inz(0)
     D forLen          s             10I 0  inz(0)
     D cType           s              5I 0  inz(0)
     D buf             s               *    inz(*NULL)
     D bufLen          s             10I 0  inz(0)
     D outLen          s             10I 0  inz(0)
     D str             s             64A   inz(*BLANKS)
     D strP            s               *   inz(%addr(str))
     D strSz           s             10i 0 inz(0)
     D pWatch          s               *   inz(*NULL)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       pWatch = outPtrP;
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;

       // any substitution parms ('call sp(?,?,?)')
       rc =db2_parm_desc(stmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;

       // get updated desc info
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       for i = 1 to nParms;
         pparmT = pparmT1st + %size(hParm_t) * (i-1);

         // <parm>
         // oooooo
         str = '<parm>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <name>
         // oooooo
         str = '<name>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <name>label</name>
         //       ooooo
         cpybytes(outPtrP:%addr(parmT.name):parmT.nlen);
         outPtrP += parmT.nlen;
         // </name>
         // ooooooo
         str = '</name>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <dbtype>
         // oooooooo
         str = '<dbtype>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <dbtype>label</dbtype>
         //         ooooo
         select;
         when parmT.type = DB2_CHAR;
           str = 'CHAR';
         when parmT.type = DB2_NUMERIC;
           str = 'NUMERIC';
         when parmT.type = DB2_DECIMAL;
           str = 'DECIMAL';
         when parmT.type = DB2_INTEGER;
           str = 'INTEGER';
         when parmT.type = DB2_SMALLINT;
           str = 'SMALLINT';
         when parmT.type = DB2_FLOAT;
           str = 'FLOAT';
         when parmT.type = DB2_REAL;
           str = 'REAL';
         when parmT.type = DB2_DOUBLE;
           str = 'DOUBLE';
         when parmT.type = DB2_DATETIME;
           str = 'DATETIME';
         when parmT.type = DB2_VARCHAR;
           str = 'VARCHAR';
         when parmT.type = DB2_CLOB;
           str = 'CLOB';
         when parmT.type = DB2_BLOB;
           str = 'BLOB';
         when parmT.type = DB2_DBCLOB;
           str = 'DBCLOB';
         when parmT.type = DB2_GRAPHIC;
           str = 'GRAPHIC';
         when parmT.type = DB2_VARGRAPHIC;
           str = 'VARGRAPHIC';
         when parmT.type = DB2_DATE;
           str = 'DATE';
         when parmT.type = DB2_TIME;
           str = 'TIME';
         when parmT.type = DB2_TIMESTAMP;
           str = 'TIMESTAMP';
         when parmT.type = DB2_WCHAR;
           str = 'WCHAR';
         when parmT.type = DB2_WVARCHAR;
           str = 'WVARCHAR';
         when parmT.type = DB2_BIGINT;
           str = 'BIGINT';
         when parmT.type = DB2_BINARY;
           str = 'BINARY';
         when parmT.type = DB2_VARBINARY;
           str = 'VARBINARY';
         when parmT.type = DB2_BINARY_V6;
           str = 'BINARY_V6';
         when parmT.type = DB2_VARBINARY_V6;
           str = 'VARBINARY_V6';
         when parmT.type = DB2_DECFLOAT;
           str = 'DECFLOAT';
         //when parmT.type = DB2_XML;
         // other?
         other;
           str = 'UNKNOWN';
         endsl;
         // <dbtype>label</dbtype>
         //         ooooo
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // </dbtype>
         // ooooooooo
         str = '</dbtype>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <size>
         // oooooo
         str = '<size>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <size>value</size>
         //       ooooo
         str = %char(parmT.size);
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // </size>
         // ooooooo
         str = '</size>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <scale>
         // ooooooo
         str = '<scale>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <scale>value</scale>
         //        ooooo
         str = %char(parmT.scale);
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // </scale>
         // oooooooo
         str = '</scale>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <nullable>
         // oooooooooo
         str = '<nullable>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <nullable>value</nullable>
         //           ooooo
         str = %char(parmT.nullable);
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // </nullable>
         // ooooooooooo
         str = '</nullable>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;


         // </parm>
         // ooooooo
         str = '</parm>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

       endfor;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI statement fetch description
      *****************************************************
     P db2_fetch_col_desc...
     P                 B                   export
     D db2_fetch_col_desc...        
     D                 PI             1N
     D  stmt                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s              5I 0 inz(0)
     D rec             s              5I 0 inz(0)
     D len             s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
     D node            ds                  likeds(xmlNode_t)
     D start           s               *   inz(*NULL)
     D icon            s               *   inz(*NULL)
     D pout            s               *   inz(*NULL)
     D retSize         s             10I 0  inz(0)
     D trimSz          s             10I 0  inz(0)
     D forLen          s             10I 0  inz(0)
     D cType           s              5I 0  inz(0)
     D buf             s               *    inz(*NULL)
     D bufLen          s             10I 0  inz(0)
     D outLen          s             10I 0  inz(0)
     D str             s             64A   inz(*BLANKS)
     D strP            s               *   inz(%addr(str))
     D strSz           s             10i 0 inz(0)
     D pWatch          s               *   inz(*NULL)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       pWatch = outPtrP;
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;

       // *** push data
       // set ILE parm builder
       rc = ileStatic(XML_PGM_OPM_TRUE);
       if rc = *OFF;
         return *OFF;
       endif;

       // column descriptio
       rc =db2_col_desc(stmt:sqlCode);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       // get updated desc info
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       for i = 1 to nCols;
         pcolT = pcolT1st + %size(hCol_t) * (i-1);

         // <col>
         // ooooo
         str = '<col>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <name>
         // oooooo
         str = '<name>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <name>label</name>
         //       ooooo
         cpybytes(outPtrP:%addr(colT.name):colT.nlen);
         outPtrP += colT.nlen;
         // </name>
         // ooooooo
         str = '</name>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <dbtype>
         // oooooooo
         str = '<dbtype>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <dbtype>label</dbtype>
         //         ooooo
         select;
         when colT.type = DB2_CHAR;
           str = 'CHAR';
         when colT.type = DB2_NUMERIC;
           str = 'NUMERIC';
         when colT.type = DB2_DECIMAL;
           str = 'DECIMAL';
         when colT.type = DB2_INTEGER;
           str = 'INTEGER';
         when colT.type = DB2_SMALLINT;
           str = 'SMALLINT';
         when colT.type = DB2_FLOAT;
           str = 'FLOAT';
         when colT.type = DB2_REAL;
           str = 'REAL';
         when colT.type = DB2_DOUBLE;
           str = 'DOUBLE';
         when colT.type = DB2_DATETIME;
           str = 'DATETIME';
         when colT.type = DB2_VARCHAR;
           str = 'VARCHAR';
         when colT.type = DB2_CLOB;
           str = 'CLOB';
         when colT.type = DB2_BLOB;
           str = 'BLOB';
         when colT.type = DB2_DBCLOB;
           str = 'DBCLOB';
         when colT.type = DB2_GRAPHIC;
           str = 'GRAPHIC';
         when colT.type = DB2_VARGRAPHIC;
           str = 'VARGRAPHIC';
         when colT.type = DB2_DATE;
           str = 'DATE';
         when colT.type = DB2_TIME;
           str = 'TIME';
         when colT.type = DB2_TIMESTAMP;
           str = 'TIMESTAMP';
         when colT.type = DB2_WCHAR;
           str = 'WCHAR';
         when colT.type = DB2_WVARCHAR;
           str = 'WVARCHAR';
         when colT.type = DB2_BIGINT;
           str = 'BIGINT';
         when colT.type = DB2_BINARY;
           str = 'BINARY';
         when colT.type = DB2_VARBINARY;
           str = 'VARBINARY';
         when colT.type = DB2_BINARY_V6;
           str = 'BINARY_V6';
         when colT.type = DB2_VARBINARY_V6;
           str = 'VARBINARY_V6';
         when colT.type = DB2_DECFLOAT;
           str = 'DECFLOAT';
         //when colT.type = DB2_XML;
         // other?
         other;
           str = 'UNKNOWN';
         endsl;
         // <dbtype>label</dbtype>
         //         ooooo
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // </dbtype>
         // ooooooooo
         str = '</dbtype>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <size>
         // oooooo
         str = '<size>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <size>value</size>
         //       ooooo
         str = %char(colT.size);
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // </size>
         // ooooooo
         str = '</size>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <scale>
         // ooooooo
         str = '<scale>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <scale>value</scale>
         //        ooooo
         str = %char(colT.scale);
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // </scale>
         // oooooooo
         str = '</scale>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         // <nullable>
         // oooooooooo
         str = '<nullable>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // <nullable>value</nullable>
         //           ooooo
         str = %char(colT.nullable);
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;
         // </nullable>
         // ooooooooooo
         str = '</nullable>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;


         // </col>
         // oooooo
         str = '</col>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

       endfor;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI statement get data
      *****************************************************
     P db2_get_data...
     P                 B
     D db2_get_data...        
     D                 PI             1N
     D  stmt                         10A
     D  colnum                        5I 0
     D  ctype                         5I 0
     D  buf                            *
     D  inLen                        10I 0
     D  outLen                       10I 0
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D hlen            s             10I 0 inz(0)
     D istm            s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       outLen = 0;
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;
       DB2_RC=db2GetData(hstmt:colnum:ctype:buf:inLen:%addr(hlen));
       outLen = hlen;
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement LOB LOCATOR column length
      *****************************************************
     P db2_lob_length...
     P                 B
     D db2_lob_length...        
     D                 PI             1N
     D  conn                         10A
     D  lob_loc                      10I 0
     D  loc_ind                      10I 0
     D  loc_type                      5I 0
     D  len                          10I 0
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D hlen            s             10I 0 inz(0)
     D hind            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
      /free
       len = 0;
       loc_ind = 0;
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         rc =db2_connect_default(conn);
         if rc = *ON;
           rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
                  :conn:option1:db:uid:pwd);
         endif;
         if rc = *OFF;
           return *OFF;
         endif;
       endif;
       DB2_RC=db2AllocStmt(hdbc:hstmt);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
         return *OFF;
       endif;
       DB2_RC=db2GetLength(hstmt
              :loc_type
              :lob_loc 
              :%addr(hlen)
              :%addr(hind));
       len = hlen;
       loc_ind = hind;
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         DB2_RC1=db2_stmt_free_monitor(hstmt);
         return *OFF;
       endif;
       DB2_RC1=db2_stmt_free_monitor(hstmt);
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement LOB LOCATOR get substring data
      *****************************************************
     P db2_lob_data...
     P                 B
     D db2_lob_data...        
     D                 PI             1N
     D  conn                         10A
     D  lob_loc                      10I 0
     D  loc_ind                      10I 0
     D  loc_type                      5I 0
     D  forBeg                       10I 0
     D  forLen                       10I 0
     D  cType                         5I 0
     D  buf                            *
     D  bufLen                       10I 0
     D  outLen                       10I 0
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D hlen            s             10I 0 inz(0)
     D hind            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
      /free
       outLen = 0;
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         rc =db2_connect_default(conn);
         if rc = *ON;
           rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
                  :conn:option1:db:uid:pwd);
         endif;
         if rc = *OFF;
           return *OFF;
         endif;
       endif;
       DB2_RC=db2AllocStmt(hdbc:hstmt);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
         return *OFF;
       endif;
       DB2_RC=db2GetSubString(hstmt
                :loc_type
                :lob_loc
                :forBeg
                :forLen
                :cType
                :buf
                :bufLen
                :%addr(hlen));
       outLen = hlen;
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         DB2_RC1=db2_stmt_free_monitor(hstmt);
         return *OFF;
       endif;
       DB2_RC1=db2_stmt_free_monitor(hstmt);
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI statement fetch
      *****************************************************
     P db2_fetch...
     P                 B                   export
     D db2_fetch...        
     D                 PI             1N
     D  stmt                         10A
     D  block                        10i 0
     D  recnbr                       10i 0
     D  desc                          1N
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D blockloop       S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D istm            s             10I 0 inz(0)
     D i               s              5I 0 inz(0)
     D itmp            s              5I 0 inz(0)
     D rec             s              5I 0 inz(0)
     D len             s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
     D node            ds                  likeds(xmlNode_t)
     D start           s               *   inz(*NULL)
     D icon            s               *   inz(*NULL)
     D pout            s               *   inz(*NULL)
     D retSize         s             10I 0  inz(0)
     D trimSz          s             10I 0  inz(0)
     D forBeg          s             10I 0  inz(1)
     D forLen          s             10I 0  inz(0)
     D cType           s              5I 0  inz(0)
     D buf             s               *    inz(*NULL)
     D bufLen          s             10I 0  inz(0)
     D outLen          s             10I 0  inz(0)
     D str             s             64A   inz(*BLANKS)
     D strP            s               *   inz(%addr(str))
     D strSz           s             10i 0 inz(0)
     D pWatch          s               *   inz(*NULL)
      * finish output 
     D rowStart        s              1N   inz(*OFF)
     D colStart        s              1N   inz(*OFF)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       pWatch = outPtrP;
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;

       if block < 1;
         blockloop = 1;
       else;
         blockloop = block;
       endif;

       // *** push data
       // set ILE parm builder
       rc = ileStatic(XML_PGM_OPM_TRUE);
       if rc = *OFF;
         return *OFF;
       endif;

       // column descriptio
       rc =db2_col_desc(stmt:sqlCode);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       // column binding
       rc =db2_col_bind(stmt:sqlCode);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       // get updated bind info
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;

       // size of a row
       // set start to ile parm area
       retSize = ileSzParm(start);

       // block loop
       for rec = 1 to blockloop;
       rowStart = *OFF;
       colStart = *OFF;
       rc = *ON;

       // re-init the row
       memset(start:0:retSize);

       // fetch
       if recnbr < 1 or rec > 1;
         DB2_RC=db2Fetch(hstmt);
       else;
         // ???
         // DB2_RC=db2FetchScroll(hstmt:DB2_FETCH_ABSOLUTE:recnbr);
         // if DB2_RC <> DB2_SUCCESS 
         // and DB2_RC <> DB2_SUCCESS_WITH_INFO;
           DB2_RC=db2FetchScroll(hstmt:DB2_FETCH_FIRST:0);
           if recnbr > 1 
           and (DB2_RC = DB2_SUCCESS or DB2_RC = DB2_SUCCESS_WITH_INFO);
             DB2_RC=db2FetchScroll(hstmt:DB2_FETCH_RELATIVE:recnbr-1);
           endif;
         // endif;
       endif;
       if DB2_RC <> DB2_SUCCESS 
       and DB2_RC <> DB2_SUCCESS_WITH_INFO;
         // no records at all???
         if rec = 1;
           rc1=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
           rc1=db2_stmt_free(stmt);
           return *OFF;
         // one good record minimum
         else;
           rc1=db2_stmt_free(stmt);
           return *ON;
         endif;
       endif;

       // *** pop data
       // <row>
       // ooooo
       if block > 0;
       str = '<row>';
       str = %trim(str);
       strSz = %len(%trim(str));
       cpybytes(outPtrP:strP:strSz);
       outPtrP += strSz;
       rowStart = *ON;
       endif;

       // set ILE parm builder
       rc = ileStatic(XML_PGM_OPM_TRUE);
       if rc = *OFF;
         return *OFF;
       endif;

       for i = 1 to nCols;
         pcolT = pcolT1st + %size(hCol_t) * (i-1);

         // <data desc='label'>
         // ooooooooooooooooooo
         if block > 0;
         if desc = *ON;
           // <data desc='label'>
           // oooooooooooo
           str = '<data desc=''';
           str = %trim(str);
           strSz = %len(%trim(str));
           cpybytes(outPtrP:strP:strSz);
           outPtrP += strSz;
           // <data desc='label'>
           //             ooooo
           cpybytes(outPtrP:%addr(colT.name):colT.nlen);
           outPtrP += colT.nlen;
           // <data desc='label'>
           //                  o
           str = '''';
           str = %trim(str);
           strSz = %len(%trim(str));
           cpybytes(outPtrP:strP:strSz);
           outPtrP += strSz;
         // <data>
         // ooooo
         else;
           str = '<data';
           str = %trim(str);
           strSz = %len(%trim(str));
           cpybytes(outPtrP:strP:strSz);
           outPtrP += strSz;
         endif;
         // check for NULL DATA  (1.8.4)
         if colT.type <> DB2_BLOB
         and colT.type <> DB2_CLOB
         and colT.type <> DB2_DBCLOB;
           // <data null='on'>
           //       oooooooooo     
           if colT.olen = DB2_NULL_DATA; // (1.8.4)
             str = ' null=''on''>';
             strSz = 11;
             cpybytes(outPtrP:strP:strSz);
             outPtrP += strSz;
           // <data>
           //      o
           else;
             str = '>';
             str = %trim(str);
             strSz = %len(%trim(str));
             cpybytes(outPtrP:strP:strSz);
             outPtrP += strSz;
           endif;
         endif;
         colStart = *ON;
         endif;

         // xml node for push/pop
         xmlCTOR(node);
         if xmlGetCDATA() = *ON;
           node.xmlIsCDATA = XML_ATTR_CDATA_TRUE;
         endif;
         node.xmlPrmRet = XML_IS_PARM;
         node.pgmArgTop = XML_PGM_TOP_FALSE;
         node.xmlStrP   = *NULL;
         node.xmlStrSz  = 0;
         node.xmlBy     = XML_BY_VAL;
         node.xmlAttr   = colT.xAttr;
         node.xmlDigits = colT.xDigits;
         node.xmlFrac   = colT.scale;
         pout           = %addr(colT.olen);

         // data values
         // <data> ... </data>
         //       ooooo
         select;
         when colT.type = DB2_CHAR
           or colT.type = DB2_VARCHAR;
           rc = ilePopData(outPtrP:node);
         when colT.type = DB2_WCHAR
           or colT.type = DB2_WVARCHAR
           or colT.type = DB2_GRAPHIC
           or colT.type = DB2_VARGRAPHIC;
           rc = ilePopData(outPtrP:node);
         when colT.type = DB2_INTEGER
           or colT.type = DB2_SMALLINT
           or colT.type = DB2_BIGINT;
           rc = ilePopData(outPtrP:node);
         when colT.type = DB2_FLOAT
           or colT.type = DB2_REAL
           or colT.type = DB2_DOUBLE
           or colT.type = DB2_DECFLOAT;
           rc = ilePopData(outPtrP:node);
         when colT.type = DB2_NUMERIC
           or colT.type = DB2_DECIMAL;
           rc = ilePopData(outPtrP:node);
         when colT.type = DB2_DATETIME
           or colT.type = DB2_DATE
           or colT.type = DB2_TIME
           or colT.type = DB2_TIMESTAMP;
           rc = ilePopData(outPtrP:node);
         when colT.type = DB2_BINARY
           or colT.type = DB2_VARBINARY
           or colT.type = DB2_BINARY_V6
           or colT.type = DB2_VARBINARY_V6;
           rc = ilePopData(outPtrP:node);
         when colT.type = DB2_BLOB
           or colT.type = DB2_CLOB
           or colT.type = DB2_DBCLOB;
           if colT.size > 32000;
             // how long is the lob?
             rc = db2_lob_length(conn
                  :colT.lob_loc:colT.loc_ind:colT.loc_type
                  :forLen
                  :sqlCode);
             // <data null='on'>
             //       oooooooooo     
             if forLen = DB2_NULL_DATA; // (1.8.4)
               str = ' null=''on''>';
               strSz = 11;
               cpybytes(outPtrP:strP:strSz);
               outPtrP += strSz;
             // <data>
             //      o
             else;
               str = '>';
               str = %trim(str);
               strSz = %len(%trim(str));
               cpybytes(outPtrP:strP:strSz);
               outPtrP += strSz;
             endif;
             if rc = *ON and forLen > DB2_NULL_DATA;
               if colT.type = DB2_BLOB;
                 if sV5Binary = *ON;
                   cType= DB2_BINARY;
                 else;
                   cType= DB2_BINARY_V6;
                 endif;
               else;
                 cType = DB2_CHAR;
               endif;
               // write data to row fetch area
               buf    = start + colT.loc_off;
               bufLen = colT.xDigits;
               rc = db2_lob_data(conn
                    :colT.lob_loc:colT.loc_ind:colT.loc_type
                    :forBeg:forLen
                    :cType:buf:bufLen
                    :outLen
                    :sqlCode);
             endif;
           else;
             // <data null='on'>
             //       oooooooooo     
             if colT.olen = DB2_NULL_DATA; // (1.8.4)
               str = ' null=''on''>';
               strSz = 11;
               cpybytes(outPtrP:strP:strSz);
               outPtrP += strSz;
             // <data>
             //      o
             else;
               str = '>';
               str = %trim(str);
               strSz = %len(%trim(str));
               cpybytes(outPtrP:strP:strSz);
               outPtrP += strSz;
             endif;
           endif;
           // must pop data to sync
           // move row out ptr position
           rc1 = ilePopData(outPtrP:node);
           if rc1 = *OFF;
             rc = *OFF;
           endif;
         //when colT.type = DB2_XML;
         // other?
         other;
           rc = *OFF;
         endsl;

         // </data>
         // ooooooo
         if block > 0;
         str = '</data>';
         str = %trim(str);
         strSz = %len(%trim(str));
         cpybytes(outPtrP:strP:strSz);
         outPtrP += strSz;

         if rc = *OFF; // ADC (1.6.2)
           str = '<error>'+XML_MSG_GENERIC_ERROR+'</error>';
           str = %trim(str);
           strSz = %len(%trim(str));
           cpybytes(outPtrP:strP:strSz);
           outPtrP += strSz;
         endif;
         endif;

       endfor;

       // </row>
       // oooooo
       if block > 0;
       str = '</row>'+x'25';
       str = %trim(str);
       strSz = %len(%trim(str));
       cpybytes(outPtrP:strP:strSz);
       outPtrP += strSz;
       endif;

       endfor;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI stmt row count 
      *****************************************************
     P db2_row_count...
     P                 B                   export
     D db2_row_count...        
     D                 PI             1N
     D  stmt                         10A
     D  count                        10I 0
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D istm            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D conn            s             10A   inz(*BLANKS)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       // *** old statement ***
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         return *OFF;
       endif;
       // free stmt resources
       DB2_RC=db2RowCount(hstmt:%addr(count));
       if DB2_RC < DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI connect last insert identity
      *****************************************************
     P db2_last_insert_id...
     P                 B                   export
     D db2_last_insert_id...        
     D                 PI             1N
     D  conn                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D desc            s              1N   inz(*OFF)
     D block           s             10i 0 inz(-1)
     D rec             s             10i 0 inz(0)
     D stmt            s             10A   inz('deadbeef')
      * connection
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hstmt           s             10I 0 inz(0)
     D hlen            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
     D options         s             10A   inz(*BLANKS)
      * sql statement
     D query           s            200A   inz(*BLANKS)
     D stmt_str        s               *   inz(*NULL)
     D stmt_len        s             10I 0 inz(0)
      /free
       // *** connection ***
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         return *OFF;
       endif;
       if db2_option_is_sql_naming(option1) = *ON;
         query = 'SELECT IDENTITY_VAL_LOCAL() AS LASTID FROM SYSIBM.SYSDUMMY1';
       else;
         query = 'SELECT IDENTITY_VAL_LOCAL() AS LASTID FROM SYSIBM/SYSDUMMY1';
       endif;
       stmt_str = %addr(query);
       stmt_len = %len(%trim(query));
       rc =db2_query(conn:stmt_str:stmt_len:stmt:options:sqlCode);
       // fetch result set
       if rc = *ON;
         rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       endif;
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI meta helper
      *****************************************************
     P db2_meta_set...
     P                 B
     D db2_meta_set...        
     D                 PI
     D  p1                             *   options(*nopass)
     D  cb1                           5i 0 options(*nopass)
     D  p2                             *   options(*nopass)
     D  cb2                           5i 0 options(*nopass)
     D  p3                             *   options(*nopass)
     D  cb3                           5i 0 options(*nopass)
     D  p4                             *   options(*nopass)
     D  cb4                           5i 0 options(*nopass)
     D  p5                             *   options(*nopass)
     D  cb5                           5i 0 options(*nopass)
     D  p6                             *   options(*nopass)
     D  cb6                           5i 0 options(*nopass)
      * vars
     D myon_t          DS                  qualified based(Template)
     D  ubufx                       128a
     D  bytex                         1a   overlay(ubufx)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(myon_t) based(pCopy)
      /free
       if %parms >= 2;
         if p1 <> *NULL;
           p1 = *NULL;
           cb1 = 0;
         endif;
       endif;
       if %parms >= 4;
         if p2 <> *NULL;
           pCopy = p2;
           if myCopy.ubufx = *BLANKS;
             p2 = *NULL;
             cb2 = 0;
           else;
             cb2 = %len(%trim(myCopy.ubufx));
           endif;
         endif;
       endif;
       if %parms >= 6;
         if p3 <> *NULL;
           pCopy = p3;
           if myCopy.ubufx = *BLANKS;
             p3 = *NULL;
             cb3 = 0;
           else;
             cb3 = %len(%trim(myCopy.ubufx));
           endif;
         endif;
       endif;
       if %parms >= 8;
         if p4 <> *NULL;
           pCopy = p4;
           if myCopy.ubufx = *BLANKS;
             p4 = *NULL;
             cb4 = 0;
           else;
             cb4 = %len(%trim(myCopy.ubufx));
           endif;
         endif;
       endif;
       if %parms >= 10;
         if p5 <> *NULL;
           pCopy = p5;
           if myCopy.ubufx = *BLANKS;
             p5 = *NULL;
             cb5 = 0;
           else;
             cb5 = %len(%trim(myCopy.ubufx));
           endif;
         endif;
       endif;
       if %parms >= 12;
         if p6 <> *NULL;
           pCopy = p6;
           if myCopy.ubufx = *BLANKS;
             p6 = *NULL;
             cb6 = 0;
           else;
             cb6 = %len(%trim(myCopy.ubufx));
           endif;
         endif;
       endif;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect tables
      *****************************************************
     P db2_ctor_statement...
     P                 B                   export
     D db2_ctor_statement...        
     D                 PI             1N
     D  conn                         10A
     D  stmt                         10A
     D  hstmt                        10I 0
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
      * connection
     D icon            s             10I 0 inz(0)
     D henv            s             10I 0 inz(0)
     D hdbc            s             10I 0 inz(0)
     D hlen            s             10I 0 inz(0)
     D db              s             10A   inz(*BLANKS)
     D uid             s             10A   inz(*BLANKS)
     D pwd             s             10A   inz(*BLANKS)
     D option1         s             10A   inz(*BLANKS)
      * statement
     D istm            s             10I 0 inz(0)
      * col descr
     D nCols           s              5I 0 inz(0)
     D pcolT1st        s               *   inz(*NULL)
     D pcolT           s               *   inz(*NULL)
     D colT            ds                  likeds(hCol_t) based(pcolT)
      *parm desc
     D nParms          s              5I 0 inz(0)
     D pparmT1st       s               *   inz(*NULL)
     D pparmT          s               *   inz(*NULL)
     D parmT           ds                  likeds(hParm_t) based(pparmT)
      /free
       rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
              :conn:option1:db:uid:pwd);
       if rc = *OFF;
         rc =db2_connect_default(conn);
         if rc = *ON;
           rc = cacScanDB2(CAC_CONN_ACTIVE:icon:henv:hdbc
                  :conn:option1:db:uid:pwd);
         endif;
         if rc = *OFF;
           return *OFF;
         endif;
       endif;
       // already have THIS hstmt active?
       // ... then kill it ...
       rc = cacScanStm(CAC_STMT_ACTIVE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *ON;
         rc1=db2_stmt_free(stmt);
       endif;
       // *** new statement ***
       rc = cacScanStm(CAC_STMT_NEW:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       if rc = *OFF;
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       DB2_RC=db2AllocStmt(hdbc:hstmt);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_DBC:hdbc:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       rc = cacScanStm(CAC_STMT_UPDATE:istm:hstmt:conn:stmt
              :nCols:pcolT1st
              :nParms:pparmT1st);
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI errors
      *****************************************************
     P db2_error_rec...
     P                 B                   export
     D db2_error_rec...        
     D                 PI             1N
     D  hType                        10I 0 value
     D  handle                       10I 0 value
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D recNum          s              5I 0 inz(1)
     D sqlState        s              6A   inz(*BLANKS)
     D sqlMsg          s            513A   inz(*BLANKS)
     D sqlMsgSz        s              5I 0 inz(%size(sqlMsg))
     D sqlLen          s              5I 0 inz(0)
     D len             S             10I 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
      /free
       sqlCode = -1;
       DB2_RC1=db2GetDiagRec(hType:handle:recNum
                        :%addr(sqlState)
                        :%addr(sqlCode)
                        :%addr(sqlMsg):sqlMsgSz
                        :%addr(sqlLen));
       if DB2_RC1 <> DB2_SUCCESS;
         return *OFF;
       endif;
       pCopy = %addr(sqlState)+5;
       myCopy.bytex = ' ';
       len = strlen(sqlMsg);
       pCopy = %addr(sqlMsg)+len;
       myCopy.bytex = ' ';
       errsSevere(XML_ERROR_SQL_MESSAGE:
         %trim(sqlState)+':'+%char(sqlCode)+':'+sqlMsg
         :sqlCode:sqlState);
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect tables
      *****************************************************
     P db2_tables...
     P                 B                   export
     D db2_tables...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  itype                       128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pTableName...
     D                 s               *   inz(*NULL)
     D cbTableName...
     D                 s              5i 0 inz(0)
     D pTableType...
     D                 s               *   inz(*NULL)
     D cbTableType...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pTableName  = %addr(itable);
       pTableType  = %addr(itype);
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :pTableType
                :cbTableType);
       DB2_RC=db2Tables(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :pTableType
                :cbTableType);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect table privileges
      *****************************************************
     P db2_table_privileges...
     P                 B                   export
     D db2_table_privileges...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pTableName...
     D                 s               *   inz(*NULL)
     D cbTableName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pTableName  = %addr(itable);
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName);
       DB2_RC=db2TablePrivileges(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect columns
      *****************************************************
     P db2_columns...
     P                 B                   export
     D db2_columns...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pTableName...
     D                 s               *   inz(*NULL)
     D cbTableName...
     D                 s              5i 0 inz(0)
     D pColumnName...
     D                 s               *   inz(*NULL)
     D cbColumnName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pTableName  = %addr(itable);
       pColumnName = %addr(icol);
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :pColumnName
                :cbColumnName);
       DB2_RC=db2Columns(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :pColumnName
                :cbColumnName);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI connect column privileges
      *****************************************************
     P db2_column_privileges...
     P                 B                   export
     D db2_column_privileges...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pTableName...
     D                 s               *   inz(*NULL)
     D cbTableName...
     D                 s              5i 0 inz(0)
     D pColumnName...
     D                 s               *   inz(*NULL)
     D cbColumnName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pTableName  = %addr(itable);
       pColumnName = %addr(icol);
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :pColumnName
                :cbColumnName);
       DB2_RC=db2ColumnPrivileges(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :pColumnName
                :cbColumnName);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI special columns
      *****************************************************
     P db2_special_columns...
     P                 B                   export
     D db2_special_columns...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  iscope                        5i 0
     D  inull                         1N
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
     D uscope          s              5i 0 inz(0)
     D unull           s              5i 0 inz(0)
     D accura          s              5i 0 inz(0)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pTableName...
     D                 s               *   inz(*NULL)
     D cbTableName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pTableName  = %addr(itable);
       if iscope = 0;
          uscope = DB2_SCOPE_CURROW;
       elseif iscope = 1;
          uscope = DB2_SCOPE_TRANSACTION;
       else;
          uscope = DB2_SCOPE_SESSION;
       endif;
       if inull = *ON;
          unull = DB2_INDEX_ALL;
       else;
          unull = DB2_NO_NULLS;
       endif;
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName);
       DB2_RC=db2SpecialColumns(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :uscope:unull);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect procedures
      *****************************************************
     P db2_procedures...
     P                 B                   export
     D db2_procedures...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  iproc                       128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pProcName...
     D                 s               *   inz(*NULL)
     D cbProcName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pProcName   = %addr(iproc);
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pProcName
                :cbProcName);
       DB2_RC=db2Procedures(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pProcName
                :cbProcName);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E


      *****************************************************
      * RPG CLI connect procedure columns
      *****************************************************
     P db2_procedure_columns...
     P                 B                   export
     D db2_procedure_columns...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  iproc                       128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pProcName...
     D                 s               *   inz(*NULL)
     D cbProcName...
     D                 s              5i 0 inz(0)
     D pColumnName...
     D                 s               *   inz(*NULL)
     D cbColumnName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pProcName   = %addr(iproc);
       pColumnName = %addr(icol);
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pProcName
                :cbProcName
                :pColumnName
                :cbColumnName);
       DB2_RC=db2ProcedureColumns(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pProcName
                :cbProcName
                :pColumnName
                :cbColumnName);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect primary keys
      *****************************************************
     P db2_primary_keys...
     P                 B                   export
     D db2_primary_keys...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pTableName...
     D                 s               *   inz(*NULL)
     D cbTableName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pTableName  = %addr(itable);
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName);
       DB2_RC=db2PrimaryKeys(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect foreign keys
      *****************************************************
     P db2_foreign_keys...
     P                 B                   export
     D db2_foreign_keys...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  fqual                       128A
     D  fschema                     128A
     D  ftable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pTableName...
     D                 s               *   inz(*NULL)
     D cbTableName...
     D                 s              5i 0 inz(0)
     D fCatalogName...
     D                 s               *   inz(*NULL)
     D fbCatalogName...
     D                 s              5i 0 inz(0)
     D fSchemaName...
     D                 s               *   inz(*NULL)
     D fbSchemaName...
     D                 s              5i 0 inz(0)
     D fTableName...
     D                 s               *   inz(*NULL)
     D fbTableName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pTableName  = %addr(itable);
       // fCatalogName -- qualifier not used
       fSchemaName = %addr(fschema);
       fTableName  = %addr(ftable);
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :fCatalogName
                :fbCatalogName
                :fSchemaName
                :fbSchemaName
                :fTableName
                :fbTableName);
       DB2_RC=db2ForeignKeys(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :fCatalogName
                :fbCatalogName
                :fSchemaName
                :fbSchemaName
                :fTableName
                :fbTableName);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E

      *****************************************************
      * RPG CLI connect statistics
      *****************************************************
     P db2_statistics...
     P                 B                   export
     D db2_statistics...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  iall                          1N
     D  outPtrP                        *
     D  sqlCode                      10I 0
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     D rc              s              1N   inz(*ON)
     D rc1             s              1N   inz(*ON)
     D block           s             10i 0 inz(SQLMAXFETCH)
     D rec             s             10i 0 inz(0)
     D desc            s              1N   inz(*ON)
     D unique          s              5i 0 inz(0)
     D accura          s              5i 0 inz(0)
      * tables
     D pCatalogName...
     D                 s               *   inz(*NULL)
     D cbCatalogName...
     D                 s              5i 0 inz(0)
     D pSchemaName...
     D                 s               *   inz(*NULL)
     D cbSchemaName...
     D                 s              5i 0 inz(0)
     D pTableName...
     D                 s               *   inz(*NULL)
     D cbTableName...
     D                 s              5i 0 inz(0)
      * statement
     D stmt            s             10A   inz('deadbeef')
     D hstmt           s             10i 0 inz(0)
      /free
       // *** new statement
       rc = db2_ctor_statement(conn:stmt:hstmt:sqlCode);
       if rc = *OFF;
         return *OFF;
       endif;
       // tables meta data
       // pCatalogName -- qualifier not used
       pSchemaName = %addr(ischema);
       pTableName  = %addr(itable);
       if iall = *ON;
          unique = DB2_INDEX_ALL;
       else;
          unique = DB2_INDEX_UNIQUE;
       endif;
       db2_meta_set(
                 pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName);
       DB2_RC=db2Statistics(hstmt
                :pCatalogName
                :cbCatalogName
                :pSchemaName
                :cbSchemaName
                :pTableName
                :cbTableName
                :unique:accura);
       if DB2_RC <> DB2_SUCCESS;
         rc=db2_error_rec(DB2_HANDLE_STMT:hstmt:sqlCode);
         rc1=db2_stmt_free(stmt);
         return *OFF;
       endif;
       // fetch result set
       rc =db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       rc1 =db2_stmt_free(stmt);
       return rc;
      /end-free
     P                 E

