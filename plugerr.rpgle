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
      /copy plugpase_h
      /copy plugile_h
      /copy plugxml_h
      /copy plugbug_h
      /copy plugcach_h
      /copy plugperf_h
      /copy plugerr_h


      *****************************************************
      * errsGet
      * return (NA)
      *****************************************************
     P errsGet         B                   export
     D errsGet         PI             1N
     D   idx                         10i 0 value
     D   rec                               likeds(erRec_t)
      /free
       return cacScanErr(idx:rec);
      /end-free
     P                 E

      *****************************************************
      * errsLast
      * return (NA)
      *****************************************************
     P errsLast        B                   export
     D errsLast        PI
     D   rec                               likeds(erRec_t)
      * vars
     D rc              s              1N   inz(*OFF)
      /free
       rc = cacScanErr(ERRSPRV:rec);
      /end-free
     P                 E

      *****************************************************
      * errsCritical
      * return (NA)
      *****************************************************
     P errsCritical...
     P                 B                   export
     D errsCritical...
     D                 PI
     D   errXml                      10i 0 value
     D   errHelp                     60A   value options(*nopass)
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)
      * vars
     D rc              S             10i 0 inz(0)
     D errText         S             60A   inz(*BLANKS)
      /free
       if %parms >= 2;
         errText = errHelp;
       endif;
       // stop on error
       if PLUGSTOPONERROR = *ON;
         DebugMe(DEBUG_ON_ERROR);
       endif;
       if %parms >= 4;
         cacAddErr(errXml:errText:errSqlCode:errSqlStat);
       elseif %parms >= 3;
         cacAddErr(errXml:errText:errSqlCode);
       else;
         cacAddErr(errXml:errText);
       endif;
       // @ADC (1.7.1)
       if perfLogOn() = *ON;
         confLogPop(PERF_LOG_L_ERROR 
                   + ' ' + errsMsgTxt(errXml) 
                   + ' ' + errText);
       endif;
      /end-free
     P                 E

      *****************************************************
      * errsSevere
      * return (NA)
      *****************************************************
     P errsSevere...
     P                 B                   export
     D errsSevere...
     D                 PI
     D   errXml                      10i 0 value
     D   errHelp                     60A   value options(*nopass)
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)
      * vars
     D rc              S             10i 0 inz(0)
     D errText         S             60A   inz(*BLANKS)
      /free
       if %parms >= 2;
         errText = errHelp;
       endif;
       // stop on error
       if PLUGSTOPONERROR = *ON;
         DebugMe(DEBUG_ON_ERROR);
       endif;
       if %parms >= 4;
         cacAddErr(errXml:errText:errSqlCode:errSqlStat);
       elseif %parms >= 3;
         cacAddErr(errXml:errText:errSqlCode);
       else;
         cacAddErr(errXml:errText);
       endif;
       // @ADC (1.7.1)
       if perfLogOn() = *ON;
         confLogPop(PERF_LOG_L_ERROR 
                   + ' ' + errsMsgTxt(errXml) 
                   + ' ' + errText);
       endif;
      /end-free
     P                 E

      *****************************************************
      * errsWarning
      * return (NA)
      *****************************************************
     P errsWarning...
     P                 B                   export
     D errsWarning...
     D                 PI
     D   errXml                      10i 0 value
     D   errHelp                     60A   value options(*nopass)
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)
      * vars
     D rc              S             10i 0
     D errText         S             60A   inz(*BLANKS)
      /free
       if %parms >= 2;
         errText = errHelp;
       endif;
       if %parms >= 4;
         cacAddErr(errXml:errText:errSqlCode:errSqlStat);
       elseif %parms >= 3;
         cacAddErr(errXml:errText:errSqlCode);
       else;
         cacAddErr(errXml:errText);
       endif;
      /end-free
     P                 E

      *****************************************************
      * errsInformational
      * return (NA)
      *****************************************************
     P errsInformational...
     P                 B                   export
     D errsInformational...
     D                 PI
     D   errXml                      10i 0 value
     D   errHelp                     60A   value options(*nopass)
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)
      * vars
     D rc              S             10i 0 inz(0)
     D errText         S             60A   inz(*BLANKS)
      /free
       if %parms >= 2;
         errText = errHelp;
       endif;
       if %parms >= 4;
         cacAddErr(errXml:errText:errSqlCode:errSqlStat);
       elseif %parms >= 3;
         cacAddErr(errXml:errText:errSqlCode);
       else;
         cacAddErr(errXml:errText);
       endif;
      /end-free
     P                 E

      *****************************************************
      * errsIleTxt
      * return (ile errno message)
      *****************************************************
     P errsIleTxt      B                   export
     D errsIleTxt      PI            64A
     D   errNoIle                    10i 0 value
      * vars
     D msgOut          S             64A   inz(*BLANKS)
      /free
       Monitor;
       msgOut = %str(StrError(errNoIle):%size(msgOut));
       // -------------
       // error
       On-error;
       Endmon;
       return msgOut;
      /end-free
     P                 E

      *****************************************************
      * errsMsgTxt
      * return (message)
      *****************************************************
     P errsMsgTxt      B                   export
     D errsMsgTxt      PI            32A
     D   errXml                      10i 0 value
      * vars
     D msgOut          S             32A   inz(*BLANKS)
      /free
       select;

       when errXml = QP2_ERROR_START32_FAIL;
         msgOut =  QP2_MSG_START32_FAIL;
       when errXml = QP2_ERROR_LOAD_LIBC_FAIL;
         msgOut =  QP2_MSG_LOAD_LIBC_FAIL;
       when errXml = QP2_ERROR_MALLOC_FAIL;
         msgOut =  QP2_MSG_MALLOC_FAIL;
       when errXml = QP2_ERROR_SYMB_FAIL;
         msgOut =  QP2_MSG_SYMB_FAIL;
       when errXml = QP2_ERROR_RSLOBJ2_FAIL;
         msgOut =  QP2_MSG_RSLOBJ2_FAIL;
       when errXml = QP2_ERROR_PGMCALL_FAIL;
         msgOut =  QP2_MSG_PGMCALL_FAIL;
       when errXml = QP2_ERROR_ILELOAD_FAIL;
         msgOut =  QP2_MSG_ILELOAD_FAIL;
       when errXml = QP2_ERROR_ILESYM_FAIL;
         msgOut =  QP2_MSG_ILESYM_FAIL;
       when errXml = QP2_ERROR_ILECALL_FAIL;
         msgOut =  QP2_MSG_ILECALL_FAIL;
       when errXml = QP2_ERROR_POPEN_FAIL;
         msgOut =  QP2_MSG_POPEN_FAIL;
       when errXml = QP2_ERROR_FGETS_FAIL;
         msgOut =  QP2_MSG_FGETS_FAIL;
       when errXml = QP2_ERROR_PCLOSE_FAIL;
         msgOut =  QP2_MSG_PCLOSE_FAIL;

       when errXml = XML_ERROR_SCAN_HEADER;
         msgOut =  XML_MSG_SCAN_HEADER;
       when errXml = XML_ERROR_SCAN_BODY;
         msgOut =  XML_MSG_SCAN_BODY;
       when errXml = XML_ERROR_SCAN_ONERROR;
         msgOut =  XML_MSG_SCAN_ONERROR;
       when errXml = XML_ERROR_PARSE_EXCEPTION;
         msgOut =  XML_MSG_PARSE_EXCEPTION;
       when errXml = XML_ERROR_PARSE_FAIL;
         msgOut =  XML_MSG_PARSE_FAIL;
       when errXml = XML_ERROR_RUN_EXCEPTION;
         msgOut =  XML_MSG_RUN_EXCEPTION;
       when errXml = XML_ERROR_RUN_FAIL;
         msgOut =  XML_MSG_RUN_FAIL;
       when errXml = XML_ERROR_GOOP_EXCEPTION;
         msgOut =  XML_MSG_GOOP_EXCEPTION;
       when errXml = XML_ERROR_GOOP_FAIL;
         msgOut =  XML_MSG_GOOP_FAIL;
       when errXml = XML_ERROR_COPYIN_EXCEPTION;
         msgOut =  XML_MSG_COPYIN_EXCEPTION;
       when errXml = XML_ERROR_COPYIN_FAIL;
         msgOut =  XML_MSG_COPYIN_FAIL;
       when errXml = XML_ERROR_COPYIN_DATA;
         msgOut =  XML_MSG_COPYIN_DATA;
       when errXml = XML_ERROR_COPYOUT_EXCEPTION;
         msgOut =  XML_MSG_COPYOUT_EXCEPTION;
       when errXml = XML_ERROR_COPYOUT_DATA;
         msgOut =  XML_MSG_COPYOUT_DATA;
       when errXml = XML_ERROR_COPYOUT_FAIL;
         msgOut =  XML_MSG_COPYOUT_FAIL;
       when errXml = XML_ERROR_RUNCMD_EXCEPTION;
         msgOut =  XML_MSG_RUNCMD_EXCEPTION;
       when errXml = XML_ERROR_RUNCMD_FAIL;
         msgOut =  XML_MSG_RUNCMD_FAIL;
       when errXml = XML_ERROR_RUNSH_EXCEPTION;
         msgOut =  XML_MSG_RUNSH_EXCEPTION;
       when errXml = XML_ERROR_RUNSH_FAIL;
         msgOut =  XML_MSG_RUNPGM_EXCEPTION;
       when errXml = XML_ERROR_RUNPGM_EXCEPTION;
         msgOut =  XML_MSG_RUNPGM_EXCEPTION;
       when errXml = XML_ERROR_RUNPGM_FAIL;
         msgOut =  XML_MSG_RUNPGM_FAIL;

       when errXml = IPC_ERROR_SPAWN_FAIL;
         msgOut =  IPC_MSG_SPAWN_FAIL;
       when errXml = IPC_ERROR_ALIVE_PID_FAIL;
         msgOut =  IPC_MSG_ALIVE_PID_FAIL;
       when errXml = IPC_ERROR_ALIVE_FAIL;
         msgOut =  IPC_MSG_ALIVE_FAIL;
       when errXml = IPC_ERROR_GETSHM_FAIL;
         msgOut =  IPC_MSG_GETSHM_FAIL;
       when errXml = IPC_ERROR_GETSEM_FAIL;
         msgOut =  IPC_MSG_GETSEM_FAIL;
       when errXml = IPC_ERROR_SHMAT2_FAIL;
         msgOut =  IPC_MSG_SHMAT2_FAIL;
       when errXml = IPC_ERROR_FTOK_BEG_FAIL;
         msgOut =  IPC_MSG_FTOK_BEG_FAIL;
       when errXml = IPC_ERROR_FTOK_END_FAIL;
         msgOut =  IPC_MSG_FTOK_END_FAIL;
       when errXml = IPC_ERROR_SHM_BEG_FAIL;
         msgOut =  IPC_MSG_SHM_BEG_FAIL;
       when errXml = IPC_ERROR_SHM_END_FAIL;
         msgOut =  IPC_MSG_SHM_END_FAIL;
       when errXml = IPC_ERROR_SHMAT_BEG_FAIL;
         msgOut =  IPC_MSG_SHMAT_BEG_FAIL;
       when errXml = IPC_ERROR_SHMAT_END_FAIL;
         msgOut =  IPC_MSG_SHMAT_END_FAIL;
       when errXml = IPC_ERROR_SHMAT_READY_FAIL;
         msgOut =  IPC_MSG_SHMAT_READY_FAIL;
       when errXml = IPC_ERROR_ALLOC_FAIL;
         msgOut =  IPC_MSG_ALLOC_FAIL;
       when errXml = IPC_ERROR_DEALLOC_FAIL;
         msgOut =  IPC_MSG_DEALLOC_FAIL;
       when errXml = IPC_ERROR_NOIPC_NOHERE;
         msgOut =  IPC_MSG_NOIPC_NOHERE;
       when errXml = IPC_ERROR_MKDIR_FAIL;
         msgOut =  IPC_MSG_MKDIR_FAIL;
       when errXml = IPC_ERROR_CRTSEM1_FAIL;
         msgOut =  IPC_MSG_CRTSEM1_FAIL;
       when errXml = IPC_ERROR_CRTSEM2_FAIL;
         msgOut =  IPC_MSG_CRTSEM2_FAIL;
       when errXml = IPC_ERROR_CRTSHM_FAIL;
         msgOut =  IPC_MSG_CRTSHM_FAIL;
       when errXml = IPC_ERROR_SHMAT1_FAIL;
         msgOut =  IPC_MSG_SHMAT1_FAIL;
       when errXml = IPC_ERROR_CRT_TMP_FAIL;
         msgOut =  IPC_MSG_CRT_TMP_FAIL;
       when errXml = IPC_ERROR_DLT_TMP_FAIL;
         msgOut =  IPC_MSG_DLT_TMP_FAIL;
       when errXml = IPC_ERROR_RM_SHMDT_FAIL;
         msgOut =  IPC_MSG_RM_SHMDT_FAIL;
       when errXml = IPC_ERROR_RM_SHMKEY_FAIL;
         msgOut =  IPC_MSG_RM_SHMKEY_FAIL;
       when errXml = IPC_ERROR_RM_SHMID_FAIL;
         msgOut =  IPC_MSG_RM_SHMID_FAIL;
       when errXml = IPC_ERROR_RM_SHMCTL_FAIL;
         msgOut =  IPC_MSG_RM_SHMCTL_FAIL;
       when errXml = IPC_ERROR_RM_SEMKEY_FAIL;
         msgOut =  IPC_MSG_RM_SEMKEY_FAIL;
       when errXml = IPC_ERROR_RM_SEMGET_FAIL;
         msgOut =  IPC_MSG_RM_SEMGET_FAIL;
       when errXml = IPC_ERROR_RM_SEMCTL_FAIL;
         msgOut =  IPC_MSG_RM_SEMCTL_FAIL;
       when errXml = IPC_ERROR_RM_SEMOP_FAIL;
         msgOut =  IPC_MSG_RM_SEMOP_FAIL;
       when errXml = IPC_ERROR_TIMEOUT_END_BUSY;
         msgOut =  IPC_MSG_TIMEOUT_END_BUSY;
       when errXml = IPC_ERROR_TIMEOUT_END_KILL;
         msgOut =  IPC_MSG_TIMEOUT_END_KILL;
       when errXml = IPC_ERROR_TIMEOUT_OWN_BUSY;
         msgOut =  IPC_MSG_TIMEOUT_OWN_BUSY;

       when errXml = CALL_ERROR_RUN_FAIL;
         msgOut =  CALL_MSG_RUN_FAIL;

       when errXml = XMLCGI_ERROR_INTERNAL;
         msgOut = XMLCGI_MSG_INTERNAL;
       when errXml = CALL_ERROR_CONV_FAIL;
         msgOut = CALL_MSG_CONV_FAIL;

       when errXml = YIPS_ERROR_NOT_ALLOWED;
         msgOut = YIPS_MSG_NOT_ALLOWED;
       when errXml = XMLCGI_ERROR_NONE_INVALID;
         msgOut = XMLCGI_MSG_NONE_INVALID;

       when errXml = XML_ERROR_SQL_MESSAGE;
         msgOut =  XML_MSG_SQL_FAIL;
       when errXml = XML_ERROR_SQL_EXCEPTION;
         msgOut =  XML_MSG_SQL_EXCEPTION;
       when errXml = XML_ERROR_SQL_CONN_FAIL;
         msgOut =  XML_MSG_SQL_CONN_FAIL;
       when errXml = XML_ERROR_SQL_CONN_ACTIVE;
         msgOut =  XML_MSG_SQL_CONN_ACTIVE;
       when errXml = XML_ERROR_SQL_CONN_MAX;
         msgOut =  XML_MSG_SQL_CONN_MAX;
       when errXml = XML_ERROR_SQL_CONN_HENV;
         msgOut =  XML_MSG_SQL_CONN_HENV;
       when errXml = XML_ERROR_SQL_CONN_HDBC;
         msgOut =  XML_MSG_SQL_CONN_HDBC;
       when errXml = XML_ERROR_SQL_CONN_OPTIONS;
         msgOut =  XML_MSG_SQL_CONN_OPTIONS;
       when errXml = XML_ERROR_SQL_CONN_EXCEPTION;
         msgOut =  XML_MSG_SQL_CONN_EXCEPTION;
       when errXml = XML_ERROR_SQL_QUERY_FAIL;
         msgOut =  XML_MSG_SQL_QUERY_FAIL;
       when errXml = XML_ERROR_SQL_FETCH_FAIL;
         msgOut =  XML_MSG_SQL_FETCH_FAIL;

       // ???
       other;
         msgOut =  QP2_MSG_ERROR_UNKNOWN;
       endsl;
       return msgOut;
      /end-free
     P                 E

