      /if defined(PLUGCLI_H)
      /eof
      /endif
      /define PLUGCLI_H
   
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
      * CLI DB2 database constants
      *****************************************************
     DDB2_TRUE         C                   CONST(1)
     DDB2_FALSE        C                   CONST(0)
     DDB2_ERROR        C                   CONST(-1)
     DDB2_SUCCESS...
     D                 C                   CONST(0)
     DDB2_SUCCESS_WITH_INFO...
     D                 C                   CONST(1)
     DDB2_NO_DATA_FOUND...
     D                 C                   CONST(100)
     DDB2_NEED_DATA...
     D                 C                   CONST(99)
     DDB2_DBMS_NAME...
     D                 C                   CONST(17)
     DDB2_DBMS_VER...
     D                 C                   CONST(18)
     DDB2_NULL_DATA...
     D                 C                   CONST(-1)
     DDB2_DATA_AT_EXEC...
     D                 C                   CONST(-2)

      * SQLSetEnvAttr beg ***************
     DDB2_ATTR_SERVER_MODE...
     D                 C                   CONST(10004)
      * DB2_TRUE, DB2_FALSE (DB2_FALSE)
      * SQLSetEnvAttr beg ***************


      * SQLSetConnAttr beg ***************
     DDB2_ATTR_AUTOCOMMIT...
     D                 C                   const(10003)
      * DB2_TRUE, DB2_FALSE (DB2_FALSE)

      * The DB2_ATTR_COMMIT attribute should be set 
      * before the SQLConnect
     DDB2_TXN_ISOLATION...
     D                 C                   const(0)
     DDB2_ATTR_COMMIT...
     D                 C                   const(0)
     DDB2_TXNISO       C                   const(0)
      * Commitment control is not used      
     DDB2_COMMIT_NONE...
     D                 C                   const(1)
     DDB2_TXN_NO_COMMIT...
     D                 C                   const(1)
     DDB2_TXN_NOCOMMIT...
     D                 C                   const(1)
     DDB2_TXNNON       C                   const(1)
      * Dirty reads, nonrepeatable reads, 
      * and phantoms are possible. 
      * This is the default isolation level
      * DB2_TXN_READ_UNCOMMITTED is uncommitted read
     DDB2_COMMIT_CHG...
     D                 C                   const(2)
     DDB2_COMMIT_UR...
     D                 C                   const(2)
     DDB2_TXN_READ_UNCOMMITTED...
     D                 C                   const(2)
     DDB2_TXNUNC       C                   const(2)
      * Dirty reads are not possible. 
      * Non-repeatable reads and phantoms are possible.
      * DB2_TXN_READ_COMMITTED is cursor stability
     DDB2_COMMIT_CS...
     D                 C                   const(3)
     DDB2_TXN_READ_COMMITTED...
     D                 C                   const(3)
     DDB2_TXNCOM       C                   const(3)
      * Dirty reads and nonrepeatable reads are not possible. 
      * Phantoms are possible.
      * DB2_TXN_REPEATABLE_READ is read stability
     DDB2_COMMIT_ALL...
     D                 C                   const(4)
     DDB2_COMMIT_RS...
     D                 C                   const(4)
     DDB2_TXN_REPEATABLE_READ...
     D                 C                   const(4)
     DDB2_TXNREP       C                   const(4)
      * Transactions are serializable. 
      * Dirty reads, non-repeatable reads, 
      * and phantoms are not possible.
      * DB2_TXN_SERIALIZABLE is repeatable read
     DDB2_COMMIT_RR...
     D                 C                   const(5)
     DDB2_TXN_SERIALIZABLE...
     D                 C                   const(5)
     DDB2_TXNSER       C                   const(5)

      * A character value that indicates the default library 
      * that is used for resolving unqualified file references. 
      * This is not valid if the connection is using 
      * system naming mode
     DDB2_ATTR_DBC_DEFAULT_LIB...
     D                 C                   const(10005)

     DDB2_ATTR_DBC_SYS_NAMING...
     D                 C                   const(10004)
      * DB2_TRUE, DB2_FALSE (DB2_FALSE)

     DDB2_ATTR_QUERY_OPTIMIZE_GOAL...
     D                 C                   const(10045)
     DDB2_FIRST_IO...
     D                 C                   CONST(1)
     DDB2_ALL_IO...
     D                 C                   CONST(2)



     DDB2_ATTR_DATE_FMT...
     D                 C                   const(10020)
     DDB2_ATTR_DATE_SEP...
     D                 C                   const(10021)
     DDB2_ATTR_TIME_FMT...
     D                 C                   const(10022)
     DDB2_ATTR_TIME_SEP...
     D                 C                   const(10023)
     DDB2_ATTR_DECIMAL_SEP...
     D                 C                   const(10024)

     DDB2_FMT_ISO...
     D                 C                   const(1)
     DDB2_FMT_USA...
     D                 C                   const(2)
     DDB2_FMT_EUR...
     D                 C                   const(3)
     DDB2_FMT_JIS...
     D                 C                   const(4)
     DDB2_FMT_MDY...
     D                 C                   const(5)
     DDB2_FMT_DMY...
     D                 c                   const(6)
     DDB2_FMT_YMD...
     D                 C                   const(7)
     DDB2_FMT_JUL...
     D                 C                   const(8)
     DDB2_FMT_HMS...
     D                 C                   const(9)
     DDB2_FMT_JOB...
     D                 C                   const(10)

     DDB2_SEP_SLASH...
     D                 C                   const(1)
     DDB2_SEP_DASH...
     D                 C                   const(2)
     DDB2_SEP_PERIOD...
     D                 C                   const(3)
     DDB2_SEP_COMMA...
     D                 C                   const(4)
     DDB2_SEP_BLANK...
     D                 C                   const(5)
     DDB2_SEP_COLON...
     D                 C                   const(6)
     DDB2_SEP_JOB...
     D                 C                   const(7)
      * SQLSetConnAttr end ***************

      * SQLSetStmtAttr beg ***************
     DDB2_ATTR_CURSOR_SCROLLABLE...
     D                 C                   CONST(10015)
      * DB2_TRUE, DB2_FALSE

     DDB2_ATTR_CURSOR_SENSITIVITY...
     D                 C                   CONST(10051)
     DDB2_UNSPECIFIED...
     D                 C                   CONST(0)
     DDB2_INSENSITIVE...
     D                 C                   CONST(1)
     DDB2_SENSITIVE...
     D                 C                   CONST(2)

     DDB2_ATTR_CURSOR_TYPE...
     D                 C                   CONST(10050)
     DDB2_CURSOR_FORWARD_ONLY...
     D                 C                   CONST(0)
     DDB2_CURSOR_STATIC...
     D                 C                   CONST(1)
      * DB2_CURSOR_DYNAMIC
     DDB2_SCROLLABLE... 
     D                 C                   CONST(2)
     DDB2_CURSOR_DYNAMIC...
     D                 C                   CONST(2)
     DDB2_CURSOR_KEYSET_DRIVEN...
     D                 C                   CONST(3)

     DDB2_ATTR_FOR_FETCH_ONLY...
     D                 C                   const(10014)
      * DB2_TRUE, DB2_FALSE

     DDB2_ATTR_FULL_OPEN...
     D                 C                   const(10018)
      * DB2_TRUE, DB2_FALSE
      * SQLSetStmtAttr end ***************


     DDB2_FETCH_NEXT...
     D                 C                   CONST(1)
     DDB2_FETCH_FIRST...
     D                 C                   CONST(2)
     DDB2_FETCH_LAST...
     D                 C                   CONST(3)
     DDB2_FETCH_PRIOR...
     D                 C                   CONST(4)
     DDB2_FETCH_ABSOLUTE...
     D                 C                   CONST(5)
     DDB2_FETCH_RELATIVE...
     D                 C                   CONST(6)

     DDB2_INDEX_UNIQUE...
     D                 C                   CONST(0)
     DDB2_INDEX_ALL...
     D                 C                   CONST(1)

     DDB2_SCOPE_CURROW...
     D                 C                   CONST(0)
     DDB2_SCOPE_TRANSACTION...
     D                 C                   CONST(1)
     DDB2_SCOPE_SESSION...
     D                 C                   CONST(2)

     DDB2_NO_NULLS...
     D                 C                   CONST(0)
     DDB2_NULLABLE...
     D                 C                   CONST(1)

     DDB2_NTS          C                   CONST(-3)

     DDB2_DROP         C                   CONST(1)

     DDB2_HANDLE_DBC...
     D                 C                   CONST(2)
     DDB2_HANDLE_STMT...
     D                 C                   CONST(3)

     DDB2_PARAM_INPUT...
     D                 C                   CONST(1)
     DDB2_PARAM_OUTPUT...
     D                 C                   CONST(2)
     DDB2_PARAM_INPUT_OUTPUT...
     D                 C                   CONST(3)

     DDB2_COMMIT... 
     D                 C                   CONST(0)
     DDB2_ROLLBACK... 
     D                 C                   CONST(1)
     DDB2_COMMIT_HOLD... 
     D                 C                   CONST(2)
     DDB2_ROLLBACK_HOLD... 
     D                 C                   CONST(3)


     DDB2_CHAR         C                   CONST(1)
     DDB2_NUMERIC...
     D                 C                   CONST(2)
     DDB2_DECIMAL...
     D                 C                   CONST(3)
     DDB2_INTEGER...
     D                 C                   CONST(4)
     DDB2_SMALLINT...
     D                 C                   CONST(5)
     DDB2_FLOAT        C                   CONST(6)
     DDB2_REAL         C                   CONST(7)
     DDB2_DOUBLE       C                   CONST(8)
     DDB2_DATETIME...
     D                 C                   CONST(9)
     DDB2_VARCHAR...
     D                 C                   CONST(12)
     DDB2_BLOB         C                   CONST(13)
     DDB2_CLOB         C                   CONST(14)
     DDB2_DBCLOB       C                   CONST(15)

     DDB2_WCHAR        C                   CONST(17)
     DDB2_WVARCHAR...
     D                 C                   CONST(18)
     DDB2_BIGINT       C                   CONST(19)
     DDB2_BLOB_LOCATOR...
     D                 C                   CONST(20)
     DDB2_CLOB_LOCATOR...
     D                 C                   CONST(21)
     DDB2_DBCLOB_LOCATOR...
     D                 C                   CONST(22)

     DDB2_TYPE_DATE...
     D                 C                   CONST(91)
     DDB2_DATE         C                   CONST(91)

     DDB2_TYPE_TIME...
     D                 C                   CONST(92)
     DDB2_TIME         C                   CONST(92)

     DDB2_TYPE_TIMESTAMP...
     D                 C                   CONST(93)
     DDB2_TIMESTAMP...
     D                 C                   CONST(93)

     DDB2_GRAPHIC      C                   const(95)
     DDB2_VARGRAPHIC...
     D                 C                   const(96)

     DDB2_BINARY       C                   CONST(97)
     DDB2_VARBINARY...
     D                 C                   CONST(98)
     DDB2_BINARY_V6...
     D                 C                   const(-2)
     DDB2_VARBINARY_V6...
     D                 C                   const(-3)
     DDB2_DECFLOAT...
     D                 C                   const(-360)

     DDB2_DEFAULT...
     D                 C                   const(99)

      *****************************************************
      * db2 CLI database
      *****************************************************
     Ddb2Error         PR            10I 0 EXTPROC('SQLError')
     D                               10I 0 VALUE
     D                               10I 0 VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                               10I 0
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                5I 0

     Ddb2GetDiagRec...
     D                 PR            10I 0 EXTPROC('SQLGetDiagRec')
     D                                5I 0 VALUE
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                 *   VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE

     Ddb2AllocEnv...
     D                 PR            10I 0 EXTPROC('SQLAllocEnv')
     D                               10I 0

     Ddb2FreeEnv       PR            10I 0 EXTPROC('SQLFreeEnv')
     D                               10I 0 VALUE

     Ddb2SetEnvAttr...
     D                 PR            10I 0 EXTPROC('SQLSetEnvAttr')
     D                               10I 0 VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                               10I 0 VALUE

     Ddb2AllocConnect...
     D                 PR            10I 0 EXTPROC('SQLAllocConnect')
     D                               10I 0 VALUE
     D                               10I 0

     Ddb2FreeConnect...
     D                 PR            10I 0 EXTPROC('SQLFreeConnect')
     D                               10I 0 VALUE

     Ddb2EndTran       PR            10I 0 EXTPROC('SQLEndTran')
     D                                5I 0 VALUE
     D                               10I 0 VALUE
     D                                5I 0 VALUE

     Ddb2AllocStmt...
     D                 PR            10I 0 EXTPROC('SQLAllocStmt')
     D                               10I 0 VALUE
     D                               10I 0

     Ddb2SetStmtAttr...
     D                 PR            10I 0 EXTPROC('SQLSetStmtAttr')
     D                               10I 0 VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                               10I 0 VALUE


     Ddb2FreeStm       PR            10I 0 EXTPROC('SQLFreeStmt')
     D                               10I 0 VALUE
     D                                5I 0 VALUE

     Ddb2Connect       PR            10I 0 EXTPROC('SQLConnect')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2Disconnect...
     D                 PR            10I 0 EXTPROC('SQLDisconnect')
     D                               10I 0 VALUE

     Ddb2SetConnectAttr...
     D                 PR            10I 0 EXTPROC('SQLSetConnectAttr')
     D                               10I 0 VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                               10I 0 VALUE

     Ddb2Prepare       PR            10I 0 EXTPROC('SQLPrepare')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2Execute       PR            10I 0 EXTPROC('SQLExecute')
     D                               10I 0 VALUE

     Ddb2ExecDirect...
     D                 PR            10I 0 EXTPROC('SQLExecDirect')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                               10I 0 VALUE

     Ddb2RowCount...
     D                 PR            10I 0 EXTPROC('SQLRowCount')
     D                               10I 0 VALUE
     D                                 *   VALUE

     Ddb2NumParams...
     D                 PR            10I 0 EXTPROC('SQLNumParams')
     D                               10I 0 VALUE
     D                                 *   VALUE

     Ddb2DescribeParam...
     D                 PR            10I 0 EXTPROC('SQLDescribeParam')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                 *   VALUE
     D                                 *   VALUE
     D                                 *   VALUE

     Ddb2BindParameter...
     D                 PR            10I 0 EXTPROC('SQLBindParameter')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE

     Ddb2NumResultCols...
     D                 PR            10I 0 EXTPROC('SQLNumResultCols')
     D                               10I 0 VALUE
     D                                 *   VALUE

     Ddb2DescribeCol...
     D                 PR            10I 0 EXTPROC('SQLDescribeCol')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                 *   VALUE
     D                                 *   VALUE
     D                                 *   VALUE
     D                                 *   VALUE

     Ddb2BindCol       PR            10I 0 EXTPROC('SQLBindCol')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE

     Ddb2Fetch         PR            10I 0 EXTPROC('SQLFetch')
     D                               10I 0 VALUE

     Ddb2FetchScroll...
     D                 PR            10I 0 EXTPROC('SQLFetchScroll')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                               10I 0 VALUE

     Ddb2GetLength...
     D                 PR            10I 0 EXTPROC('SQLGetLength')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                 *   VALUE

     Ddb2GetSubString...
     D                 PR            10I 0 EXTPROC('SQLGetSubString')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                               10I 0 VALUE
     D                               10I 0 VALUE
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE

     Ddb2GetData...
     D                 PR            10I 0 EXTPROC('SQLGetCol')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                               10I 0 VALUE
     D                                 *   VALUE

     Ddb2GetInfo...
     D                 PR            10I 0 EXTPROC('SQLGetInfo')
     D                               10I 0 VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE

     Ddb2Tables...
     D                 PR            10I 0 EXTPROC('SQLTables')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2TablePrivileges...
     D                 PR            10I 0 EXTPROC('SQLTablePrivileges')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2Columns...
     D                 PR            10I 0 EXTPROC('SQLColumns')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2ColumnPrivileges...
     D                 PR            10I 0 EXTPROC('SQLColumnPrivileges')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2SpecialColumns...
     D                 PR            10I 0 EXTPROC('SQLSpecialColumns')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE

     Ddb2Procedures...
     D                 PR            10I 0 EXTPROC('SQLProcedures')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2ProcedureColumns...
     D                 PR            10I 0 EXTPROC('SQLProcedureColumns')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2PrimaryKeys...
     D                 PR            10I 0 EXTPROC('SQLPrimaryKeys')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2ForeignKeys...
     D                 PR            10I 0 EXTPROC('SQLForeignKeys')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE

     Ddb2Statistics...
     D                 PR            10I 0 EXTPROC('SQLStatistics')
     D                               10I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                 *   VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE
     D                                5I 0 VALUE

