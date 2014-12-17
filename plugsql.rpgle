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
      /copy plugdb2_h
      /copy plugperf_h

      *****************************************************
      * globals
      *****************************************************
     D sDataBase       s              1A   inz(SQL_DATABASE_DB2)

      *****************************************************
     P sqlStatic       B                   export
     D sqlStatic       PI
     D   database                     1A   value
      /free
       sDataBase = database;
       select;
       when sDataBase = SQL_DATABASE_DB2;
         db2Static();
       other;
       endsl;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL any active 
      *****************************************************
     P sql_active_any...
     P                 B                   export
     D sql_active_any...        
     D                 PI             1N
     D  type                          1A   value
     D  label                        10A
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_active_any(type:label);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL connect options
      *****************************************************
     P sql_options_ctor...
     P                 B                   export
     D sql_options_ctor...        
     D                 PI             1N
     D pOpt                            *   value
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_options_ctor(pOpt);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_options_setup...
     P                 B                   export
     D sql_options_setup...        
     D                 PI             1N
     D  label                        10A
     D  sqloptions                 1024A
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_options_setup(label:sqloptions);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E


     P sql_env_options...
     P                 B                   export
     D sql_env_options...        
     D                 PI             1N
     D  conn                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_env_options(conn:options:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_conn_options...
     P                 B                   export
     D sql_conn_options...        
     D                 PI             1N
     D  conn                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_conn_options(conn:options:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_stmt_options...
     P                 B                   export
     D sql_stmt_options...        
     D                 PI             1N
     D  stmt                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_stmt_options(stmt:options:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_options_free...
     P                 B                   export
     D sql_options_free...        
     D                 PI             1N
     D  options                      10A   value
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_options_free(options);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_options_free_all...
     P                 B                   export
     D sql_options_free_all...        
     D                 PI             1N
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_options_free_all();
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL connect
      *****************************************************
     P sql_connect_default...
     P                 B                   export
     D sql_connect_default...        
     D                 PI             1N
     D  label                        10A
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_connect_default(label);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_connect...
     P                 B                   export
     D sql_connect...        
     D                 PI             1N
     D  label                        10A
     D  options                      10A
     D  idb                          10A
     D  iuid                         10A
     D  ipwd                         10A
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_connect(label:options:idb:iuid:ipwd:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL commit or rollback
      *****************************************************
     P sql_end_transaction...
     P                 B                   export
     D sql_end_transaction...        
     D                 PI             1N
     D  conn                         10A
     D  rollback                      1N   value
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_end_transaction(conn:rollback);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * RPG SQL free 
      *****************************************************
     P sql_connect_free...
     P                 B                   export
     D sql_connect_free...        
     D                 PI             1N
     D  conn                         10A   value
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_connect_free(conn);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_connect_free_all...
     P                 B                   export
     D sql_connect_free_all...        
     D                 PI             1N
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_connect_free_all();
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL statement parameter description
      *****************************************************
     P sql_parm_desc_nbr...
     P                 B                   export
     D sql_parm_desc_nbr...        
     D                 PI             1N
     D  stmt                         10A
     D  nParms                        5I 0
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_parm_desc_nbr(stmt:nParms:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL statement parameter description
      *****************************************************
     P sql_parm_desc...
     P                 B                   export
     D sql_parm_desc...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_parm_desc(stmt:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL statement bind parameter
      *****************************************************
     P sql_parm_bind...
     P                 B                   export
     D sql_parm_bind...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  sqlParm                        *
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_parm_bind(stmt:sqlCode:sqlParm);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * RPG SQL statement column description
      *****************************************************
     P sql_col_desc_nbr...
     P                 B                   export
     D sql_col_desc_nbr...        
     D                 PI             1N
     D  stmt                         10A
     D  nCols                         5I 0
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_col_desc_nbr(stmt:nCols:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL statement column description
      *****************************************************
     P sql_col_desc...
     P                 B                   export
     D sql_col_desc...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_col_desc(stmt:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL statement bind column
      *****************************************************
     P sql_col_bind...
     P                 B                   export
     D sql_col_bind...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_col_bind(stmt:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL SQLPrepare 
      *****************************************************
     P sql_prepare...
     P                 B                   export
     D sql_prepare...        
     D                 PI             1N
     D  conn                         10A
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  stmt                         10A
     D  options                      10A
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_prepare(conn:stmt_str:stmt_len
                            :stmt:options:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL SQLExecute 
      *****************************************************
     P sql_parm_ctor...
     P                 B                   export
     D sql_parm_ctor...        
     D                 PI             1N
     D  sqlParm                        *
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_parm_ctor(sqlParm);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_execute...
     P                 B                   export
     D sql_execute...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  sqlParm                        *
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_execute(stmt:sqlCode:sqlParm);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL SQLExecute fetch parm 
      *****************************************************
     P sql_fetch_parm...
     P                 B                   export
     D sql_fetch_parm...        
     D                 PI             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  colNbr                       10i 0
     D  outPtrP                        *
     D  sqlParm                            likeds(hBind_t)
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_fetch_parm(stmt:sqlCode:colNbr:outPtrP:sqlParm);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * RPG SQL SQLExecDirect 
      *****************************************************
     P sql_query...
     P                 B                   export
     D sql_query...        
     D                 PI             1N
     D  conn                         10A
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  stmt                         10A
     D  options                      10A
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_query(conn:stmt_str:stmt_len:stmt
                          :options:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL stmt free 
      *****************************************************
     P sql_stmt_free...
     P                 B                   export
     D sql_stmt_free...        
     D                 PI             1N
     D  stmt                         10A   value
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_stmt_free(stmt);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_connect_free_stmts...
     P                 B                   export
     D sql_connect_free_stmts...        
     D                 PI             1N
     D  conn                         10A   value
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_connect_free_stmts(conn);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

     P sql_stmt_free_all...
     P                 B                   export
     D sql_stmt_free_all...        
     D                 PI             1N
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_stmt_free_all();
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * RPG SQL statement fetch description
      *****************************************************
     P sql_fetch_parm_desc...
     P                 B                   export
     D sql_fetch_parm_desc...        
     D                 PI             1N
     D  stmt                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_fetch_parm_desc(stmt:outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * RPG SQL statement fetch description
      *****************************************************
     P sql_fetch_col_desc...
     P                 B                   export
     D sql_fetch_col_desc...        
     D                 PI             1N
     D  stmt                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_fetch_col_desc(stmt:outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL statement fetch
      *****************************************************
     P sql_fetch...
     P                 B                   export
     D sql_fetch...        
     D                 PI             1N
     D  stmt                         10A
     D  block                        10i 0
     D  rec                          10i 0
     D  desc                          1N
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_fetch(stmt:block:rec:desc:outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * RPG SQL stmt row count 
      *****************************************************
     P sql_row_count...
     P                 B                   export
     D sql_row_count...        
     D                 PI             1N
     D  stmt                         10A
     D  count                        10I 0
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_row_count(stmt:count:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL conn last insert id 
      *****************************************************
     P sql_last_insert_id...
     P                 B                   export
     D sql_last_insert_id...        
     D                 PI             1N
     D  conn                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_last_insert_id(conn:outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL errors
      *****************************************************
     P sql_error_rec...
     P                 B                   export
     D sql_error_rec...        
     D                 PI             1N
     D  hType                        10I 0 value
     D  handle                       10I 0 value
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_error_rec(hType:handle:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * RPG SQL tables
      *****************************************************
     P sql_tables...
     P                 B                   export
     D sql_tables...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  itype                       128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_tables(conn
                  :iqual:ischema:itable:itype
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL table privileges
      *****************************************************
     P sql_table_privileges...
     P                 B                   export
     D sql_table_privileges...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_table_privileges(conn
                  :iqual:ischema:itable
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL columns
      *****************************************************
     P sql_columns...
     P                 B                   export
     D sql_columns...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_columns(conn
                  :iqual:ischema:itable:icol
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL column privileges
      *****************************************************
     P sql_column_privileges...
     P                 B                   export
     D sql_column_privileges...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_column_privileges(conn
                  :iqual:ischema:itable:icol
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL special columns
      *****************************************************
     P sql_special_columns...
     P                 B                   export
     D sql_special_columns...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  iscope                        5i 0
     D  inull                         1N
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_special_columns(conn
                  :iqual:ischema:itable:iscope:inull
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL procedures
      *****************************************************
     P sql_procedures...
     P                 B                   export
     D sql_procedures...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  iproc                       128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_procedures(conn
                  :iqual:ischema:iproc
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL procedure columns
      *****************************************************
     P sql_procedure_columns...
     P                 B                   export
     D sql_procedure_columns...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  iproc                       128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_procedure_columns(conn
                  :iqual:ischema:iproc:icol
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL primary keys
      *****************************************************
     P sql_primary_keys...
     P                 B                   export
     D sql_primary_keys...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_primary_keys(conn
                  :iqual:ischema:itable
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL foreign keys
      *****************************************************
     P sql_foreign_keys...
     P                 B                   export
     D sql_foreign_keys...        
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
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_foreign_keys(conn
                  :iqual:ischema:itable
                  :fqual:fschema:ftable
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * RPG SQL statistics
      *****************************************************
     P sql_statistics...
     P                 B                   export
     D sql_statistics...        
     D                 PI             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  iall                          1N
     D  outPtrP                        *
     D  sqlCode                      10I 0
      /free
       select;
       when sDataBase = SQL_DATABASE_DB2;
         return db2_statistics(conn
                  :iqual:ischema:itable:iall
                  :outPtrP:sqlCode);
       other;
       endsl;
       return *OFF;
      /end-free
     P                 E

