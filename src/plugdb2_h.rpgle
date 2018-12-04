      /if defined(PLUGDB2_H)
      /eof
      /endif
      /define PLUGDB2_H
   
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

      *****************************************************
      * database
      *****************************************************
     D db2Static       PR

     D db2_active_any...        
     D                 PR             1N
     D  type                          1A   value
     D  label                        10A

     D db2_options_setup...        
     D                 PR             1N
     D  label                        10A
     D  setoptions                 1024A

     D db2_options_free...        
     D                 PR             1N
     D  options                      10A   value

     D db2_options_free_all...        
     D                 PR             1N

     D db2_connect_default...        
     D                 PR             1N
     D  conn                         10A

     D db2_connect...        
     D                 PR             1N
     D  label                        10A
     D  options                      10A
     D  idb                          10A
     D  iuid                         10A
     D  ipwd                         10A
     D  sqlCode                      10I 0

     D db2_connect_free...        
     D                 PR             1N
     D  conn                         10A   value

     D db2_connect_free_all...        
     D                 PR             1N

     D db2_connect_free_stmts...        
     D                 PR             1N
     D  conn                         10A   value

     D db2_end_transaction...        
     D                 PR             1N
     D  conn                         10A
     D  rollback                      1N   value

     D db2_prepare...        
     D                 PR             1N
     D  conn                         10A
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  stmt                         10A
     D  options                      10A
     D  sqlCode                      10I 0

     D db2_parm_ctor...        
     D                 PR             1N
     D  sqlParm                        *

     D db2_execute...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  sqlParm                        *

     D db2_fetch_parm_desc...        
     D                 PR             1N
     D  stmt                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_fetch_parm...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  colNbr                       10i 0
     D  outPtrP                        *
     D  sqlParm                            likeds(hBind_t)

     D db2_query...        
     D                 PR             1N
     D  conn                         10A
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  stmt                         10A
     D  options                      10A
     D  sqlCode                      10I 0

     D db2_stmt_free...        
     D                 PR             1N
     D  stmt                         10A   value

     D db2_stmt_free_all...        
     D                 PR             1N

     D db2_fetch...        
     D                 PR             1N
     D  stmt                         10A
     D  block                        10i 0
     D  rec                          10i 0
     D  desc                          1N
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_fetch_col_desc...        
     D                 PR             1N
     D  stmt                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0


     D db2_row_count...        
     D                 PR             1N
     D  stmt                         10A
     D  count                        10I 0
     D  sqlCode                      10I 0


     D db2_last_insert_id...        
     D                 PR             1N
     D  conn                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_tables...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  itype                       128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_table_privileges...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_columns...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_column_privileges...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_special_columns...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  iscope                        5i 0
     D  inull                         1N
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_procedures...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  iproc                       128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_procedure_columns...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  iproc                       128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_primary_keys...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_foreign_keys...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  fqual                       128A
     D  fschema                     128A
     D  ftable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D db2_statistics...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  iall                          1N
     D  outPtrP                        *
     D  sqlCode                      10I 0

      *****************************************************
      * database helpers
      *****************************************************
     D db2_options_ctor...        
     D                 PR             1N
     D pOpt                            *   value

     D db2_env_options...        
     D                 PR             1N
     D  conn                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0

     D db2_conn_options...        
     D                 PR             1N
     D  conn                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0

     D db2_stmt_options...        
     D                 PR             1N
     D  stmt                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0

     D db2_error_rec...        
     D                 PR             1N
     D  hType                        10I 0 value
     D  handle                       10I 0 value
     D  sqlCode                      10I 0

     D db2_col_desc_nbr...        
     D                 PR             1N
     D  stmt                         10A
     D  nCols                         5I 0
     D  sqlCode                      10I 0

     D db2_col_desc...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0

     D db2_col_bind...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0

     D db2_parm_desc_nbr...        
     D                 PR             1N
     D  stmt                         10A
     D  nParms                        5I 0
     D  sqlCode                      10I 0

     D db2_parm_desc...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0

     D db2_parm_bind...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  sqlParm                        *


