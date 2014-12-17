      /if defined(PLUGERR_H)
      /eof
      /endif
      /define PLUGERR_H
   
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
      * 0) Optional get diagnostics (1.5.8)
      * <diag [info='joblog|conf' job='job' user='uid' nbr='nbr']/>
      *   example run
      *     <?xml version="1.0"?>
      *     <diag info='joblog'/>
      *     Note: 
      *       The current XMLSERVICE job log is assumed if optional 
      *       attributes job='job' user='uid' nbr='nbr' missing.
      *       if you wish to provide custom diagnostics,
      *       info='conf' calls optional hook in plugconfx (1-3).
      *************************************************************************

      *****************************************************
      * PASE message codes
      *****************************************************
     D QP2_ERROR_START32_FAIL...
     D                 c                   const(1000001)
     D QP2_ERROR_LOAD_LIBC_FAIL...
     D                 c                   const(1000002)
     D QP2_ERROR_MALLOC_FAIL...
     D                 c                   const(1000003)
     D QP2_ERROR_SYMB_FAIL...
     D                 c                   const(1000004)
     D QP2_ERROR_RSLOBJ2_FAIL...
     D                 c                   const(1000005)
     D QP2_ERROR_PGMCALL_FAIL...
     D                 c                   const(1000006)
     D QP2_ERROR_ILELOAD_FAIL...
     D                 c                   const(1000007)
     D QP2_ERROR_ILESYM_FAIL...
     D                 c                   const(1000008)
     D QP2_ERROR_ILECALL_FAIL...
     D                 c                   const(1000009)
     D QP2_ERROR_POPEN_FAIL...
     D                 c                   const(1000010)
     D QP2_ERROR_FGETS_FAIL...
     D                 c                   const(1000011)
     D QP2_ERROR_PCLOSE_FAIL...
     D                 c                   const(1000012)

      *****************************************************
      * XML message codes
      *****************************************************
     D XML_ERROR_SCAN_HEADER...
     D                 c                   const(1001001)
     D XML_ERROR_SCAN_BODY...
     D                 c                   const(1001002)
     D XML_ERROR_SCAN_ONERROR...
     D                 c                   const(1001003)
     D XML_ERROR_PARSE_EXCEPTION...
     D                 c                   const(1100001)
     D XML_ERROR_PARSE_FAIL...
     D                 c                   const(1100002)
     D XML_ERROR_RUN_EXCEPTION...
     D                 c                   const(1100003)
     D XML_ERROR_RUN_FAIL...
     D                 c                   const(1100004)
     D XML_ERROR_GOOP_EXCEPTION...
     D                 c                   const(1100005)
     D XML_ERROR_GOOP_FAIL...
     D                 c                   const(1100006)
     D XML_ERROR_COPYIN_EXCEPTION...
     D                 c                   const(1100007)
     D XML_ERROR_COPYIN_FAIL...
     D                 c                   const(1100008)
     D XML_ERROR_COPYOUT_EXCEPTION...
     D                 c                   const(1100009)
     D XML_ERROR_COPYOUT_FAIL...
     D                 c                   const(1100010)
     D XML_ERROR_RUNCMD_EXCEPTION...
     D                 c                   const(1100011)
     D XML_ERROR_RUNCMD_FAIL...
     D                 c                   const(1100012)
     D XML_ERROR_RUNSH_EXCEPTION...
     D                 c                   const(1100013)
     D XML_ERROR_RUNSH_FAIL...
     D                 c                   const(1100014)
     D XML_ERROR_RUNPGM_EXCEPTION...
     D                 c                   const(1100015)
     D XML_ERROR_RUNPGM_FAIL...
     D                 c                   const(1100016)
     D XML_ERROR_COPYIN_DATA...
     D                 c                   const(1100017)
     D XML_ERROR_COPYOUT_DATA...
     D                 c                   const(1100018)

      *****************************************************
      * client ipc message codes
      *****************************************************
     D IPC_ERROR_SPAWN_FAIL...
     D                 c                   const(1301001)
     D IPC_ERROR_ALIVE_PID_FAIL...
     D                 c                   const(1301002)
     D IPC_ERROR_ALIVE_FAIL...
     D                 c                   const(1301003)
     D IPC_ERROR_GETSHM_FAIL...
     D                 c                   const(1301009)
     D IPC_ERROR_GETSEM_FAIL...
     D                 c                   const(1301010)
     D IPC_ERROR_SHMAT2_FAIL...
     D                 c                   const(1301011)
     D IPC_ERROR_FTOK_BEG_FAIL...
     D                 c                   const(1301021)
     D IPC_ERROR_FTOK_END_FAIL...
     D                 c                   const(1301022)
     D IPC_ERROR_SHM_BEG_FAIL...
     D                 c                   const(1301023)
     D IPC_ERROR_SHM_END_FAIL...
     D                 c                   const(1301024)
     D IPC_ERROR_SHMAT_BEG_FAIL...
     D                 c                   const(1301025)
     D IPC_ERROR_SHMAT_END_FAIL...
     D                 c                   const(1301026)
     D IPC_ERROR_SHMAT_READY_FAIL...
     D                 c                   const(1301027)
     D IPC_ERROR_ALLOC_FAIL...
     D                 c                   const(1301031)
     D IPC_ERROR_DEALLOC_FAIL...
     D                 c                   const(1301031)
     D IPC_ERROR_TIMEOUT_END_BUSY...
     D                 c                   const(1301050)
     D IPC_ERROR_TIMEOUT_END_KILL...
     D                 c                   const(1301051)
     D IPC_ERROR_TIMEOUT_OWN_BUSY...
     D                 c                   const(1301060)

      *****************************************************
      * server ipc message codes
      *****************************************************
     D IPC_ERROR_NOIPC_NOHERE...
     D                 c                   const(1302000)
     D IPC_ERROR_MKDIR_FAIL...
     D                 c                   const(1302001)
     D IPC_ERROR_CRTSEM1_FAIL...
     D                 c                   const(1302002)
     D IPC_ERROR_CRTSEM2_FAIL...
     D                 c                   const(1302003)
     D IPC_ERROR_CRTSHM_FAIL...
     D                 c                   const(1302004)
     D IPC_ERROR_SHMAT1_FAIL...
     D                 c                   const(1302005)
     D IPC_ERROR_CRT_TMP_FAIL...
     D                 c                   const(1302020)
     D IPC_ERROR_DLT_TMP_FAIL...
     D                 c                   const(1302021)

      *****************************************************
      * client or server ipc message codes
      *****************************************************
     D IPC_ERROR_RM_SHMDT_FAIL...
     D                 c                   const(1303001)
     D IPC_ERROR_RM_SHMKEY_FAIL...
     D                 c                   const(1303002)
     D IPC_ERROR_RM_SHMID_FAIL...
     D                 c                   const(1303003)
     D IPC_ERROR_RM_SHMCTL_FAIL...
     D                 c                   const(1303004)
     D IPC_ERROR_RM_SEMKEY_FAIL...
     D                 c                   const(1303006)
     D IPC_ERROR_RM_SEMGET_FAIL...
     D                 c                   const(1303007)
     D IPC_ERROR_RM_SEMCTL_FAIL...
     D                 c                   const(1303008)
     D IPC_ERROR_RM_SEMOP_FAIL...
     D                 c                   const(1303009)

      *****************************************************
      * client message codes
      *****************************************************
     D CALL_ERROR_RUN_FAIL...
     D                 c                   const(1400001)


      *****************************************************
      * conversion message codes
      *****************************************************
     D CALL_ERROR_CONV_FAIL...
     D                 c                   const(1401001)


      *****************************************************
      * XMLCGI errors
      *****************************************************
     D XMLCGI_ERROR_INTERNAL...
     D                 c                   const(1480001)
     D XMLCGI_ERROR_NONE_INVALID...
     D                 c                   const(1480002)

     D YIPS_ERROR_NOT_ALLOWED...
     D                 c                   const(1490001)

      *****************************************************
      * SQL message codes
      *****************************************************
     D XML_ERROR_SQL_MESSAGE...
     D                 c                   const(1500001)
     D XML_ERROR_SQL_EXCEPTION...
     D                 c                   const(1500002)
     D XML_ERROR_SQL_CONN_FAIL...
     D                 c                   const(1500101)
     D XML_ERROR_SQL_CONN_ACTIVE...
     D                 c                   const(1500102)
     D XML_ERROR_SQL_CONN_MAX...
     D                 c                   const(1500103)
     D XML_ERROR_SQL_CONN_HENV...
     D                 c                   const(1500104)
     D XML_ERROR_SQL_CONN_HDBC...
     D                 c                   const(1500105)
     D XML_ERROR_SQL_CONN_OPTIONS...
     D                 c                   const(1500106)
     D XML_ERROR_SQL_CONN_EXCEPTION...
     D                 c                   const(1500107)
     D XML_ERROR_SQL_QUERY_FAIL...
     D                 c                   const(1500201)
     D XML_ERROR_SQL_FETCH_FAIL...
     D                 c                   const(1500301)

      *****************************************************
      * global errors
      *****************************************************
     D errsLast        PR
     D   rec                               likeds(erRec_t)

     D errsGet         PR             1N
     D   idx                         10i 0 value
     D   rec                               likeds(erRec_t)

     D errsIleTxt      PR            64A
     D   errNoIle                    10i 0 value

     D errsMsgTxt      PR            32A
     D   errXml                      10i 0 value

     D errsCritical...
     D                 PR
     D   errXml                      10i 0 value
     D   errHelp                     60A   value options(*nopass)
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)

     D errsSevere...
     D                 PR
     D   errXml                      10i 0 value
     D   errHelp                     60A   value options(*nopass)
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)

     D errsWarning...
     D                 PR
     D   errXml                      10i 0 value
     D   errHelp                     60A   value options(*nopass)
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)

     D errsInformational...
     D                 PR
     D   errXml                      10i 0 value
     D   errHelp                     60A   value options(*nopass)
     D   errSqlCode                  10i 0 value options(*nopass)
     D   errSqlStat                   6A   value options(*nopass)


