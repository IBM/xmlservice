      /if defined(PLUGSQL_H)
      /eof
      /endif
      /define PLUGSQL_H
   
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
      * Run XML SQL statements:
      *  <sql>...</sql> - start/end run XML SQL statements
      *
      * Example easy way (chglibl, default connection, default statement):
      *  Input:
      *   <?xml version='1.0'?>
      *   <script>
      *   <cmd>CHGLIBL LIBL(XMLSERVTST QTEMP) CURLIB(XMLSERVTST)</cmd>
      *   <sql>
      *   <query>select breed, name from animal</query>
      *   <fetch block='all' desc='on'/>
      *   </sql>
      *   </script>
      *   Note: You only need chglibl once for all scripts because
      *         XMLSERVICE jobs remain active until killed (*immed).
      *         XMLSERVICE default is system naming (not sql naming), 
      *         so library list is significant for unqualified 
      *         statements (see options below).
      *  Output:
      *   <?xml version='1.0'?>
      *   <script>
      *   <cmd>+++ success CHGLIBL LIBL(XMLSERVTST QTEMP) CURLIB(XMLSERVTST)</cmd>
      *   <sql>
      *   <query conn='conn1' stmt='stmt1'>
      *   +++ success select breed, name from animal</query>
      *   <fetch block='all' desc='on' stmt='stmt1'>
      *   <row><data desc='BREED'>cat</data><data desc='NAME'>Pook</data></row>
      *   <row><data desc='BREED'>dog</data><data desc='NAME'>Peaches</data></row>
      *   <row><data desc='BREED'>horse</data><data desc='NAME'>Smarty</data></row>
      *   <row><data desc='BREED'>gold fish</data><data desc='NAME'>Bubbles</data></row>
      *   <row><data desc='BREED'>budgerigar</data><data desc='NAME'>Gizmo</data></row>
      *   <row><data desc='BREED'>goat</data><data desc='NAME'>Rickety Ride</data></row>
      *   <row><data desc='BREED'>llama</data><data desc='NAME'>Sweater</data></row>
      *   <row><data desc='BREED'>frog</data><data desc='NAME' null='on'></data></row>
      *   </fetch>
      *   </sql>
      *   </script>
      *
      * Reserved SQL words (syntax):
      * <sql>
      *
      * Connect to DB2 (optional):
      * <connect [conn='label' db='x' uid='x' pwd='x' options='label']/>
      * 
      * Options template (optional):
      * <options [options='label' error='on|off|fast'
      *  Environment level (SQLSetEnvAttr) ...
      *   servermode='on'                               (default=off)
      *  Connection level (SQLSetConnAttr) ...
      *   autocommit='on|off'                           (default=on)
      *   commit='none|uncommitted|committed|repeatable|serializable'
      *                                         (default=uncommitted)
      *   naming='system|sql'                           (default=system)
      *   sqllib='mylib'                                (default=na)
      *   libl='curlib1 mylib2 mylib3'                  (default=na)
      *   datefmt='iso|usa|eur|jis|mdy|dmy|ymd|jul|job' (default=na)
      *   datesep='slash|dash|period|comma|blank|job'   (default=na)
      *   timefmt='iso|usa|eur|jis|hms|job'             (default=na)
      *   timesep='colon|period|comma|blank|job'        (default=na)
      *   decimalsep='period|comma|blank|job'           (default=na)
      *   optimize='first|all'                          (default=na)
      *  Statement level (SQLSetStmtAttr) (version 1.5.1+) ...
      *   scrollable='on|off'                           (default=off)
      *   sensitive='unspecified|sensitive|insensitive' (default=unspecified)
      *   cursor='forward|static|dynamic'               (default=forward)
      *   fetchonly='on|off'                            (deafult=on)
      *   fullopen='on|off'                             (deafult=off)
      * ]/>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      * Note:
      *  commit sets transaction-isolation level
      *  - none         - no commit        (*NONE)
      *  - uncommitted  - uncommitted read (*CHG)
      *  - committed    - cursor stability (*CS)
      *  - repeatable   - read stability   (*RS, *ALL)
      *  - serializable - repeatable read  (*RR, *ALL)
      *
      * Commit or rollback transaction (optional): 
      * <commit [conn='label' action='rollback' error='on|off|fast']/>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      *
      * Execute statement directly (SQLExecDirect):
      * <query [conn='label' stmt='label' options='label' error='on|off|fast']>
      *  call storedproc('fred flinrock',42.42)
      *    -- or --
      *  select * from table where abc = 'abc'
      *    -- or (use CDATA if xml trouble special characters) --
      *  <![CDATA[select * from animal where ID < 5 and weight > 10.0]]>
      * </query>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      * Note:
      * - options='label' (version 1.5.1+)
      * 
      * Prepare a statement (SQLPrepare/SQLExecute):
      * <prepare [conn='label' stmt='label' options='label' error='on|off|fast']>
      *  call storedproc(?,?)
      *    -- or --
      *  select * from table where abc = ?
      *    -- or (use CDATA if xml trouble special characters) --
      *  <![CDATA[select * from animal where ID < ? and weight > ?]]>
      * </prepare>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      * Note:
      * - options='label' (version 1.5.1+)
      *
      * Execute a prepared statement (SQLPrepare/SQLExecute):
      * <execute [stmt='label'  error='on|off|fast']>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      *   <parm [io='in|out|both']>my string</parm>
      *   <parm [io='in|out|both']>42.42</parm>
      * </execute>
      * Note:
      * - substitution parameters '?' are taken in order of
      *   appearence with data types decided internally in
      *   XMLSERVICE (SQLNumParams/SQLDescribeParam)
      *   and bound at call time (SQLBindParameter)
      *
      * Fetch result(s) of a statement:
      * <fetch [stmt='label' block='all|n' rec='n' desc='on|off' error="on|off|fast"/>
      *                      (default=all)         (default=on)  (default='off')
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report
      *              off - script continues, job error log (default)
      *              fast - script continues, brief error log
      *   Output (column description included via desc='on'):
      *   <fetch>
      *    <row><data desc='NAME'>Rip</data><data desc='ID'>9</data></row>
      *    <row><data desc='NAME'>Bee</data><data desc='ID'>3</data></row>
      *    <row><data desc='NAME' null='on'></data><data desc='ID'>21</data></row>
      *   </fetch>
      * Note:
      * - result set column types and descriptions are 
      *   decided internally in XMLSERVICE (SQLNumResultCols/SQLDescribeCol)
      *   and bound at call time (SQLBindCol)
      * - rec='n' (version 1.5.1+)
      * - Fetch len=SQL_NULL_DATA return null='on' attr (1.8.4+)
      *   <row><data null='on'></data></row>
      *
      * After query/execute statement:
      * Statment rows affected by change (SQLRowCount):
      * <rowcount [stmt='label' error='on|off']/>
      *                         (default=off)
      *  Output:
      *   <rowcount ...>24</rowcount>
      *
      * After insert of identity id:
      * Statment last identity id (IDENTITY_VAL_LOCAL):
      * <identity [conn='label' error='on|off']/>
      *                         (default=off)
      *  Output:
      *   <identity ...>23</identity>
      *
      * Statment describe parms (SQLNumParams/SQLDescribeParam):
      *                   columns (SQLNumResultCols/SQLDescribeCol):
      * <describe [stmt='label' desc='col|parm|both' error='on|off']/>
      *                                              (default=off)
      *  Output (parm):
      *   <describe ...>
      *    <parm> or <col>
      *      <name>FRED</name>
      *      <dbtype>DECIMAL</dbtype>
      *      <size>12</size>
      *      <scale>2</scale>
      *      <nullable>0</nullable>
      *    </parm> or </col>
      *   </describe>
      *
      * Statment count parms (SQLNumParams):            (1.7.6)
      *                columns (SQLNumResultCols):
      * <count [stmt='label' desc='col|parm|both' error='on|off']/>
      *                                           (default=off)
      *  Output (parm):
      *   <count ...>
      *    <colcount>nbr</colcount>
      *    <parmcount>nbr</parmcount>
      *   </count>
      *
      * Free resources:
      * <free [conn='all|label' 
      *        cstmt='label' 
      *        stmt='all|label' 
      *        options='all|label' 
      *        error='on|off|fast']/>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report
      *              off - script continues, job error log (default)
      *              fast - script continues, brief error log
      *
      * Meta data - tables:
      * <tables [conn='label' error='on|off|fast'>
      *                       (default=off)
      *   <parm>qualifier or catalog<parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>table type</parm>
      * </tables>
      * Output (desc varies V5R4 to V6+):
      *   <tables ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL</data>
      *       <data desc='TABLE_TYPE'>BASE TABLE</data>
      *       <data desc='REMARKS'></data>
      *     </row>
      *   </tables>
      *
      * Meta data - table privileges:
      * <tablepriv [conn='label' error='on|off|fast'>
      *                       (default=off)
      *   <parm>qualifier or catalog<parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      * </tablepriv>
      * Output (desc varies V5R4 to V6+):
      *   <tablepriv ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL</data>
      *       <data desc='GRANTOR'></data>
      *       <data desc='GRANTEE'>PUBLIC</data>
      *       <data desc='PRIVILEGE'>SELECT</data>
      *       <data desc='IS_GRANTABLE'>NO</data>
      *       <data desc='DBNAME'></data>
      *     </row>
      *   </tablepriv>
      *
      * Meta data - columns:
      * <columns [conn='label' error='on|off|fast'>
      *                        (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>column name</parm>
      * </columns>
      * Output (desc varies V5R4 to V6+):
      *   <columns ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL</data>
      *       <data desc='COLUMN_NAME'>BREED</data>
      *       <data desc='DATA_TYPE'>12</data>
      *       <data desc='TYPE_NAME'>VARCHAR</data>
      *       <data desc='LENGTH_PRECISION'>0</data>
      *       <data desc='BUFFER_LENGTH'>34</data>
      *       <data desc='NUM_SCALE'>0</data>
      *       <data desc='NUM_PREC_RADIX'>0</data>
      *       <data desc='NULLABLE'>1</data>
      *       <data desc='REMARKS'></data>
      *       <data desc='COLUMN_DEF'>
      *       </data><data desc='DATETIME_CODE'>0</data>
      *       <data desc='CHAR_OCTET_LENGTH'>32</data>
      *       <data desc='ORDINAL_POSITION'>2</data>
      *     </row>
      *   </columns>
      *
      * Meta data - special columns:
      * <special [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>row|transaction|session</parm>
      *   <parm>no|nullable</parm>
      * </special>
      *
      * Meta data - column privileges:
      * <columnpriv [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>column name</parm>
      * </columnpriv>
      * Output (desc varies V5R4 to V6+):
      *   <columnpriv ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       data desc='TABLE_NAME'>ANIMAL</data>
      *       <data desc='COLUMN_NAME'>BREED</data>
      *       <data desc='GRANTOR'></data>
      *       <data desc='GRANTEE'>PUBLIC</data>
      *       <data desc='PRIVILEGE'>SELECT</data>
      *       <data desc='IS_GRANTABLE'>NO</data>
      *       <data desc='DBNAME'></data>
      *     </row>
      *   </columnpriv>
      *
      * Meta data - procedures:
      * <procedures [conn='label' error='on|off|fast'>
      *                        (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>procedure name</parm>
      * </procedures>
      * Output (desc varies V5R4 to V6+):
      *   <procedures ...>
      *     <row>
      *       <data desc='PROCEDURE_CAT'>LP0164D</data>
      *       <data desc='PROCEDURE_SCHEM'>XMLSERVTST</data>
      *       <data desc='PROCEDURE_NAME'>MATCH1</data>
      *       <data desc='NUM_INPUT_PARAMS'>2</data>
      *       <data desc='NUM_OUTPUT_PARAMS'>1</data>
      *       <data desc='NUM_RESULT_SETS'>1</data>
      *       <data desc='REMARKS'></data>
      *     </row>
      *
      * Meta data - procedure columns:
      * <pcolumns [conn='label' error='on|off|fast'>
      *                        (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>proc name</parm>
      *   <parm>column name</parm>
      * </pcolumns>
      * Output (desc varies V5R4 to V6+):
      *   <pcolumns ...>
      *     <row>
      *       <data desc='PROCEDURE_CAT'>LP0164D</data>
      *       <data desc='PROCEDURE_SCHEM'>XMLSERVTST</data>
      *       <data desc='PROCEDURE_NAME'>MATCH1</data>
      *       <data desc='COLUMN_NAME'>FIRST_NAME</data>
      *       <data desc='COLUMN_TYPE'>1</data>
      *       <data desc='DATA_TYPE'>12</data>
      *       <data desc='TYPE_NAME'>CHARACTER VARYING</data>
      *       <data desc='PRECISION'>0</data>
      *       <data desc='LENGTH'>128</data>
      *       <data desc='SCALE'>0</data>
      *       <data desc='RADIX'>0</data>
      *       <data desc='NULLABLE'>YES</data>
      *       <data desc='REMARKS'></data>
      *       <data desc='COLUMN_DEF'>0</data>
      *       <data desc='SQL_DATA_TYPE'>12</data>
      *       <data desc='SQL_DATETIME_SUB'>0</data>
      *       <data desc='CHAR_OCTET_LENGTH'>128</data>
      *       <data desc='ORDINAL_POSITION'>1</data>
      *       <data desc='IS_NULLABLE'>YES</data>
      *     </row>
      *   </pcolumns>
      *
      * Meta data - primary keys:
      * <primarykeys [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      * </primarykeys>
      * Output (desc varies V5R4 to V6+):
      *   <primarykeys ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL2</data>
      *       <data desc='COLUMN_NAME'>NOTEID</data>
      *       <data desc='KEY_SEQ'>1</data>
      *       <data desc='PK_NAME'>Q_XMLSERVTST_ANIMAL2_NOTEID_00001</data>
      *     </row>
      *   </primarykeys>
      *
      * Meta data - foreign keys:
      * <foreignkeys [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>primary qualifier or catalog</parm>
      *   <parm>primary schema name</parm>
      *   <parm>primary table name</parm>
      *   <parm>foreign qualifier or catalog</parm>
      *   <parm>foreign schema name</parm>
      *   <parm>foreign table name</parm>
      * </foreignkeys>
      * Output (desc varies V5R4 to V6+):
      *   <foreignkeys ...>
      *     <row>
      *       <data desc='PKTABLE_CAT'>LP0164D</data>
      *       <data desc='PKTABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='PKTABLE_NAME'>ANIMAL2</data>
      *       <data desc='PKCOLUMN_NAME'>NOTEID</data>
      *       <data desc='FKTABLE_CAT'>LP0164D</data>
      *       <data desc='FKTABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='FKTABLE_NAME'>FKEY2</data>
      *       <data desc='FKCOLUMN_NAME'>IDF</data>
      *       <data desc='KEY_SEQ'>1</data>
      *       <data desc='UPDATE_RULE'>3</data>
      *       <data desc='DELETE_RULE'>3</data>
      *       <data desc='FK_NAME'>Q_XMLSERVTST_FKEY2_IDF_00001</data>
      *       <data desc='PK_NAME'>Q_XMLSERVTST_ANIMAL2_NOTEID_00001</data>
      *     </row>
      *   </foreignkeys>
      *
      * Meta data - statistics:
      * <statistics [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>all|unique</parm>
      * </statistics>
      * Output (desc varies V5R4 to V6+):
      *   <statistics ...>
      *     <row>
      *       <data desc='TABLE_CAT'></data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL2</data>
      *       <data desc='NON_UNIQUE'>1</data>
      *       <data desc='00005'>XMLSERVTST</data>
      *       <data desc='00006'>INDEX2</data>
      *       <data desc='TYPE'>3</data>
      *       <data desc='ORDINAL_POSITION'>1</data>
      *       <data desc='00009'>ANIMALID</data>
      *       <data desc='COLLATION'>A</data>
      *       <data desc='CARDINALITY'>0</data>
      *       <data desc='PAGES'>0</data>
      *     </row>
      *   </statistics>
      *
      * </sql>
      *
      * NOTES:
      *
      * The XMLSERVICE sql rules:
      * > Connection rules:
      *   - if connect is omitted, then XMLSERVICE will open
      *     a default connection under the current profile.
      *   - if servermode missing (off default), ONLY ONE connection
      *     allowed for the XMLSERVICE job. This is a DB2 rule of
      *     one activation equals one active connection/transaction,
      *     so you must free/commit a connection/transaction before
      *     attempting to create a new connection/transaction 
      *     (or connect another profile). This is the correct
      *     mode for sharing QTEMP with XMLSERVICE called
      *     PGMs/SRVPGMs, so it is also the XMLSERVICE default.
      *   - if servermode='on', XMLSERVICE may have multiple
      *     connection/transactions active, BUT each connection
      *     will be running in a seperate QSQSRVR job. This means
      *     QTEMP in XMLSERVICE job will NOT BE USEABLE to communicate
      *     between XMLSERVICE called PGM/SRVPGM, etc. (QTEMP useless).
      *     Once an XMLSERVICE job enters servermode='on',
      *     it will NEVER stop using server mode until the
      *     process is ended (choose wisely).
      *     ** server mode only work private connection **
      * > Commit rules (see options):
      *   - default is autocommit='on', where all create, insert,
      *     delete actions will be committed at operation time.
      *   - if autocommit='off', commit action may be delayed 
      *     across multiple requests to XMLSERVICE and you
      *     may also rollback the transaction.
      * > Statement rules:
      *   - if stmt='label' is omitted (normal), the first active
      *     statement available will be used for a sql operation 
      *     such as fetch or describe. Therefore it is not wise
      *     to mix stmt='label' and omitted in the same XMLSERVICE
      *     task.
      *   - if a stmt is left active (no free), and a subsequent
      *     'label'/omitted is attempted, the active statement will
      *     be released along with all result sets, etc. (free),
      *     and the new statement will become the active statement.
      *     Therefore if you are attempting to use multiple result
      *     sets from different queries, you should manually
      *     specify stmt='label' to avoid fetching from the
      *     wrong result set.
      * > Options rules:
      *   -Using servermode='on' universally executes statements
      *    in child process (QSQSRVR jobs), not XMLSERVICE job. 
      *    Once servermode='on', it stays 'on' for all connections
      *    for the life of the XMLSERVICE job, therefore you cannot
      *    expect to share QTEMP between PGM calls/DB2 SQL, etc. 
      *    (ie. think very careful before you use this option)
      *   -Default mode is servermode='na' (off), or 'normal mode',
      *    which means a single connect/transaction is allowed
      *    active at any given time. Therefore, you must end
      *    any transation with <commit> and <free conn='all'>,
      *    before attempting to switch between connection profiles.
      *    (normal CLI rules transaction/connect in a single process)  
      *   -System vs. SQL naming libl, where:
      *    - naming='system' with libl='curlib1 mylib2' (list)
      *      example: select * from mylib3/table (specific library)
      *               select * from table (uses library list)
      *      (system naming is the default naming mode XMLSERVICE)
      *    - naming='sql' with *sqllib='mylib' (one)
      *      example: select * from mylib3.table (specific schema)
      *               select * from table (uses *sqllib='schema')
      *    Do not try to mix these two modes in the same
      *    connection as this always leads to program errors
      *    (ie. make up your mind before you write your scripts).
      * > Connection/statements/options label rules (optional labels):
      *   conn='label'    - unique name connection (optional)
      *   stmt='label'    - unique name statement (optional)
      *   options='label' - unique name options template (optional)
      *   - a label is ten characters or less
      *   - a unique 'label' is used as XMLSERVICE/DB2 routing 'key'
      *     thereby allowing multiple XML <sql> calls to XMLSERVICE 
      *     routing back to open/active DB2 connection(s)/statement(s)
      *   - If optional conn/stmt 'label' is omitted, XMLSERVICE
      *     will return a unique 'label' attribute in output XML
      *     for subsequent sql prepare, execute, fetch, etc.
      *   - If optional conn/stmt 'label' is omitted, XMLSERVICE
      *     will attempt to use any active conn/stmt. No 'label(s)'
      *     works just fine with less XML, but you need to be very careful
      *     that other scripts do not introduce additional conn/stmt
      *     'label(s)' that spoil your generic XML DB2 statements.
      * > Connection/statements/options free rules (optional free): 
      *   - Connections/statements remain active/open until released:
      *     <free/>                 - release all
      *     <free options='label'/> - release options template
      *     <free options='all'/>   - release all options template
      *     <free conn='label'/>    - release connection (and statements)
      *     <free conn='all'/>      - release all connections (and statements)
      *     <free cstmt='label'/>   - release all statements 'label' connection
      *     <free stmt='label'/>    - release this statement
      *     <free stmt='all'/>      - release all statements
      *   - conn='all'   : free all connections, 
      *                    also frees all statements
      *   - cstmt='label': free all statements under 'label' connection, 
      *                    other connections/statements remain active
      *   - stmt='all'   : free all statements, 
      *                    connections remain active
      * > These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      *
      *****************************************************

      *****************************************************
      * Special sqlCode status
      *****************************************************
     DSQL_CODE_REUSED...
     D                 C                   CONST(1010101)
     DSQL_DATABASE_DB2...
     D                 C                   CONST('2')

     DsqOpt_t          ds                  qualified based(Template)
     D sqUsed                        10i 0
     D sqLabel                       10A
      * ENV level ...
      *   servermode='on' (global env level)
     D sqSrvMode                      1N
      * CONN level ...
      *   naming='system|sql'
     D sqNamSQL                       1N
      *   *commit='none|uncommitted|committed|repeatable|serializable'
     D sqComMiss                      1N
     D sqComNone                      1N
     D sqComUnCom                     1N
     D sqComCommi                     1N
     D sqComRepea                     1N
     D sqComSeria                     1N
      *   autocommit='on|off'
     D sqAutoComm                     1N
      *   datefmt='iso|usa|eur|jis|mdy|dmy|ymd|jul|job'
     D sqDFmtMiss                     1N
     D sqDFmtISO                      1N
     D sqDFmtUSA                      1N
     D sqDFmtEUR                      1N
     D sqDFmtJIS                      1N
     D sqDFmtMDY                      1N
     D sqDFmtDMY                      1N
     D sqDFmtYMD                      1N
     D sqDFmtJUL                      1N
     D sqDFmtJOB                      1N
      *   datesep='slash|dash|period|comma|blank|job'
     D sqDSepMiss                     1N
     D sqDSepSlas                     1N
     D sqDSepDash                     1N
     D sqDSepDot                      1N
     D sqDSepComa                     1N
     D sqDSepBlk                      1N
     D sqDSepJOB                      1N
      *   timefmt='iso|usa|eur|jis|hms|job'
     D sqTFmtMiss                     1N
     D sqTFmtISO                      1N
     D sqTFmtUSA                      1N
     D sqTFmtEUR                      1N
     D sqTFmtJIS                      1N
     D sqTFmtHMS                      1N
     D sqTFmtJOB                      1N
      *   timesep='colon|period|comma|blank|job'
     D sqTSepMiss                     1N
     D sqTSepColn                     1N
     D sqTSepDot                      1N
     D sqTSepComa                     1N
     D sqTSepBlk                      1N
     D sqTSepJOB                      1N
      *   decimalsep='period|comma|blank|job'
     D sqPSepMiss                     1N
     D sqPSepDot                      1N
     D sqPSepComa                     1N
     D sqPSepBlk                      1N
     D sqPSepJOB                      1N
      *   optimize='first|all'
     D sqOptzMiss                     1N
     D sqOptzFrst                     1N
     D sqOptzAll                      1N
      *   lib='mylib'
     D sqLIB                         10A
     D sqLIBlen                      10i 0
      *   libl='curlib1 mylib2 mylib3'
     D sqLIBL                      1024A
     D sqLIBLlen                     10i 0
      * STMT level ...
      *   scrollable='on|off'
     D sqScMiss                       1N
     D sqScroll                       1N
      *   sensitive='unspecified|sensitive|insensitive'
     D sqSenMiss                      1N
     D sqSenUn                        1N
     D sqSenOn                        1N
     D sqSenOFF                       1N
      *   cursor='forward|static|dynamic'
     D sqCurMiss                      1N
     D sqCurFwd                       1N
     D sqCurStat                      1N
     D sqCurDyn                       1N
      *   fetchonly='on|off'
     D sqFetMiss                      1N
     D sqFetOnly                      1N
      *   fullopen='on|off'
     D sqFullMiss                     1N
     D sqFullOpn                      1N

     DhConn_t          ds                  qualified based(Template)
     D hused                         10i 0
     D henv                          10i 0
     D hdbc                          10i 0
     D label                         10A
     D options                       10A
     D hDB                           10A
     D hUID                          10A
     D hPWD                          10A

     DhCol_t           ds                  qualified based(Template)
     D name                          64A
     D nlen                          10I 0
     D type                           5I 0
     D size                          10I 0
     D scale                          5I 0
     D nullable                       5I 0
     D olen                          10I 0
     D xAttr                          1A
     D xDigits                       10i 0
     D lob_loc                       10I 0
     D loc_ind                       10I 0
     D loc_type                       5I 0
     D loc_off                       10I 0

     DhParm_t          ds                  qualified based(Template)
     D name                          64A
     D nlen                          10I 0
     D type                           5I 0
     D size                          10I 0
     D scale                          5I 0
     D nullable                       5I 0
     D olen                          10I 0
     D xAttr                          1A
     D xDigits                       10i 0

     DhStmt_t          ds                  qualified based(Template)
     D hused                         10i 0
     D hstmt                         10i 0
     D conn                          10A
     D label                         10A
     D ncolT                          5i 0
     D colT                          10i 0
     D nparmT                         5i 0
     D parmT                         10i 0

     DhBind_t          ds                  qualified based(Template)
     D rawP                            *
     D parmP                           *
     D rawlen                        10i 0
     D parmlen                       10i 0
     D rawIO                          1A
     D pad01                         15A

      *****************************************************
      * database
      *****************************************************
     D sqlStatic       PR
     D   database                     1A   value

     D SQL_ACTIVE_CONN...
     D                 c                   const('C')
     D SQL_ACTIVE_STMT...
     D                 c                   const('S')
     D SQL_ACTIVE_OPTIONS...
     D                 c                   const('O')

     D sql_active_any...        
     D                 PR             1N
     D  type                          1A   value
     D  label                        10A

     D sql_options_setup...        
     D                 PR             1N
     D  label                        10A
     D  setoptions                 1024A

     D sql_options_free...        
     D                 PR             1N
     D  options                      10A   value

     D sql_options_free_all...        
     D                 PR             1N

     D sql_connect_default...        
     D                 PR             1N
     D  label                        10A

     D sql_connect...        
     D                 PR             1N
     D  label                        10A
     D  options                      10A
     D  idb                          10A
     D  iuid                         10A
     D  ipwd                         10A
     D  sqlCode                      10I 0

     D sql_connect_free...        
     D                 PR             1N
     D  conn                         10A   value

     D sql_connect_free_all...        
     D                 PR             1N

     D sql_connect_free_stmts...        
     D                 PR             1N
     D  conn                         10A   value

     D sql_end_transaction...        
     D                 PR             1N
     D  conn                         10A
     D  rollback                      1N   value

     D sql_prepare...        
     D                 PR             1N
     D  conn                         10A
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  stmt                         10A
     D  options                      10A
     D  sqlCode                      10I 0

     D sql_parm_ctor...        
     D                 PR             1N
     D  sqlParm                        *

     D sql_execute...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  sqlParm                        *

     D sql_fetch_parm_desc...        
     D                 PR             1N
     D  stmt                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_fetch_parm...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  colNbr                       10i 0
     D  outPtrP                        *
     D  sqlParm                            likeds(hBind_t)

     D sql_query...        
     D                 PR             1N
     D  conn                         10A
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  stmt                         10A
     D  options                      10A
     D  sqlCode                      10I 0

     D sql_stmt_free...        
     D                 PR             1N
     D  stmt                         10A   value

     D sql_stmt_free_all...        
     D                 PR             1N

     D sql_fetch...        
     D                 PR             1N
     D  stmt                         10A
     D  block                        10i 0
     D  rec                          10i 0
     D  desc                          1N
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_fetch_col_desc...        
     D                 PR             1N
     D  stmt                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_row_count...        
     D                 PR             1N
     D  stmt                         10A
     D  count                        10I 0
     D  sqlCode                      10I 0


     D sql_last_insert_id...        
     D                 PR             1N
     D  conn                         10A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_tables...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  itype                       128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_table_privileges...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_columns...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_column_privileges...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_special_columns...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  iscope                        5i 0
     D  inull                         1N
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_procedures...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  iproc                       128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_procedure_columns...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  iproc                       128A
     D  icol                        128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_primary_keys...        
     D                 PR             1N
     D  conn                         10A
     D  iqual                       128A
     D  ischema                     128A
     D  itable                      128A
     D  outPtrP                        *
     D  sqlCode                      10I 0

     D sql_foreign_keys...        
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

     D sql_statistics...        
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
     D sql_options_ctor...        
     D                 PR             1N
     D pOpt                            *   value

     D sql_env_options...        
     D                 PR             1N
     D  conn                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0

     D sql_conn_options...        
     D                 PR             1N
     D  conn                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0

     D sql_stmt_options...        
     D                 PR             1N
     D  stmt                         10A
     D  options                      10A   value
     D  sqlCode                      10I 0

     D sql_error_rec...        
     D                 PR             1N
     D  hType                        10I 0 value
     D  handle                       10I 0 value
     D  sqlCode                      10I 0

     D sql_col_desc_nbr...        
     D                 PR             1N
     D  stmt                         10A
     D  nCols                         5I 0
     D  sqlCode                      10I 0

     D sql_col_desc...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0

     D sql_col_bind...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0

     D sql_parm_desc_nbr...        
     D                 PR             1N
     D  stmt                         10A
     D  nParms                        5I 0
     D  sqlCode                      10I 0

     D sql_parm_desc...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0

     D sql_parm_bind...        
     D                 PR             1N
     D  stmt                         10A
     D  sqlCode                      10I 0
     D  sqlParm                        *



