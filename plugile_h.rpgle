      /if defined(PLUGILE_H)
      /eof
      /endif
      /define PLUGILE_H
   
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
      * 1) call i CMD:
      * <cmd [exec='cmd|system|rexx' error='on|off|fast'
      *       hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'  (1.6.8)
      *      ]>IBM i command</cmd>
      *      (default exec='cmd')    (default error='off')
      *   These alternate sh exec features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report
      *              off - script continues, job error log (default)
      *              fast - script continues, brief error log
      *   Note:
      *     <cmd>command</cmd> should be all on one line (no LFs)
      *     All <cmd> run in XMLSERVICE job, therefore affect/change
      *     the state of the job (ie. chgjob will change XMLSERVICE job). 
      *       exec='cmd|system|rexx' (1.5.2+)
      *             cmd    - qcmdexe only return true/false       (original)
      *             system - system utility return CPFxxxx        (1.5.2+)
      *                      <cmd exec='system'> ... <error>CPF2103</error></cmd>
      *             rexx   - rexx output parms and return CPFxxxx (1.5.2+)
      *                      <cmd exec='rexx'> ... <error>CPF2103</error></cmd>
      *   example run command (original)
      *     <?xml version="1.0"?>
      *     <cmd>ADDLIBLE LIB(DB2) POSITION(*FIRST)</cmd>
      *     Note: 
      *       syntax looks the same as if typed on a 5250
      *       cmd are executed in XMLSERVICE job (fast)
      *   example output command (via rexx)
      *     <?xml version='1.0'?>
      *     <script>
      *     <cmd exec='rexx'>RTVJOBA USRLIBL(?) SYSLIBL(?)</cmd>
      *     <cmd exec='rexx'>RTVJOBA CCSID(?N) OUTQ(?)</cmd>
      *     <cmd exec='rexx'>RTVSYSVAL SYSVAL(QDATETIME) RTNVAR(?)</cmd>
      *     </script>
      *     Note: 
      *     - All parms are assume to be character unless
      *       (?N) to explicit cast to numeric (rtvjoba). Most
      *       RTVxxxx that ask for a CL variable RTNVAR will
      *       not require the (?N) cast (IBM i manuals).
      *       QTEMP/XMLREXX(HOW) is created on demand
      *       by RPG module plugile (Yips download).
      *       QTEMP/OUTREXX(OUTREXX) is created for
      *       command temp data between RPG and REXX.
      *     - exec='cmd|rexx' return joblog snip (1.6.2+),
      *       exec='system' no joblog (system i limitation)
      *     - Up to four conversions can take place 
      *       for the truly complex ccsid issues (1.6.8)
      *       <cmd hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
      *         flow: 
      *         -> PHP client bin2hex('wild_ascii_raw_chars')
      *         -> xmlservice hex2bin back to 'wild_ascii_raw_chars'
      *         -> xmlservice convert cc1->cc2->cc3->cc4 (before)
      *         -> xmlservice make ILE call
      *         -> xmlservice convert cc4->cc3->cc2->cc1 (after)
      *         -> xmlservice tohex "xml_hex_back"
      *         -> PHP client $chars = pack('H*',"xml_hex_back")
      *         output (incompatible change hex/ccsid 1.7.4+):
      *         <cmd exec='rexx' hex='on' before='819/37' after='37/819'>
      *           <success><![CDATA[+++ success RTVJOBA USRLIBL(?) SYSLIBL(?)]]></success>
      *           <row><data desc='USRLIBL'><hex><![CDATA[5147504C20202020202020]]></hex></data></row>
      *           <row><data desc='SYSLIBL'><hex><![CDATA[5153595320202020202020]]></hex></data></row>
      *         </cmd>
      * 
      *************************************************************************
      * 2) call PASE utility:
      * <sh [rows='on|off' error='on|off|fast'
      *      hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1']
      *      >(PASE utility)</sh>
      *   These alternate sh exec features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report
      *              off - script continues, job error log (default)
      *              fast - script continues, brief error log
      *   example run PASE shell
      *     <?xml version="1.0"?> 
      *     <sh rows='on'>/QOpenSys/usr/bin/system 'wrkactjob'</sh>
      *     Note:
      *     - syntax looks as if typed on console (call qp2term)
      *       <sh>pase utility</sh> runs "slower" because a child job
      *       is created to run each PASE utility (normal Unix behavior).
      *       All other XML/ILE functions run within XMLSERVICE job.
      *     - Using nested shells within this sh shell may 
      *       produce unpredictable results.
      *     - hex='on' before='' after='' -- same as <cmd> (1.7.0)
      *         output (incompatible change hex/ccsid 1.7.4+):
      *         <sh rows='on' hex='on' before='819/37' after='37/819'>
      *           <row><hex>746F74616C2031363636313034</hex></row>
      *         </sh>
      *         output (rows='off' 1.7.4+):
      *         <sh hex='on' before='819/37' after='37/819'>
      *           <hex>746F74616C2031363636313034</hex>
      *         </sh>
      * 
      *************************************************************************
      * 3) call PGM/SRVPGM:
      * <pgm name='' [lib='' func='' mode='opm|ile' error='on|off|fast']></pgm>
      *   These alternate pgm exec features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      *   example run a PGM or SRVPGM
      *     <?xml version="1.0"?> 
      *     <pgm name='ZZCALL'> 
      *      <parm>
      *       <data type='1A'>a</data>
      *      </parm> 
      *      <return>
      *       <data type='10i0'>0</data>
      *      </return> 
      *     </pgm> 
      * use EITHER format (1.6.8)
      * <pgm name='fredflin' ...
      * -or- 
      * names are converted following up to 4 conversions
      * ccsid before attempting to resolve IBM i object name ...
      * <pgm mode='opm|ile' error='on|off|fast'>
      *   <name hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('&fredflin')</name>
      *   <lib hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('omlated')</lib>
      *   <func hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('me&proc')</func>
      *   <parm> ...
      *   pgm parameters:
      *     <parm [io='in|out|both|omit' by='val|ref']>(see below)</parm> 
      *      (omit 1.2.3)
      *      data structure:
      *       <ds [dim='n' dou='label' len='label' data='records']>
      *         (data elements below)
      *       </ds>
      *       (len/setlen 1.5.4)
      *      data elements:
      *       <data type='data types' 
      *          [dim='n' varying='on|off|2|4' enddo='label' setlen='label' offset='label'
      *           hex='on|off' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1' (1.6.8)
      *           trim='on|off'                                                 (1.7.1)
      *           ]>
      *       </data>
      *       (len/setlen 1.5.4)
      *         data types (similar RPG):
      *           type='na' [varying='on|off|2|4'] - character (32A)
      *             <data type='32a'/>
      *             <data type='32a' varying='on'>ranger</data>
      *             <data type='32a'><![CDATA[<i am ranger>]]></data>
      *             <data type='200A' hex='on' before='1208/930' after='930/1208'>
      *             bin2hex($japan_raw_ascii_data)
      *             </data>
      *           type='npn' - packed decimal (12p2)
      *             <data type='12p2'/>
      *             <data type='12p2'>30.29</data>
      *           type='nsn' - zoned decimal (12s2)
      *             <data type='12s2'/>
      *             <data type='12s2'>30.29</data>
      *           type='nin' - signed integer (5i0, 10i0, 20i0)
      *             <data type='20i0'/>
      *             <data type='10i0'>-30</data>
      *           type='nun' - unsigned integer (5u0, 10u0, 20u0)
      *             <data type='20u0'/>
      *             <data type='10u0'>30</data>
      *           type='nfn' - floating point (4f2, 8f4)
      *             <data type='4f2'/>
      *             <data type='4f2'>30.34</data>
      *             <data type='8f4'>30.34</data>
      *           type='nb' - binary HEX char (2b, 400b)
      *             <data type='5b'>F0F1F2CDEF</data>
      *             <data type='2b'>1FBC</data>
      *             <data type='2b'>0F0F</data>
      *             - HEX upper case ('1FBC' not '1fbc')
      *             - high/low bits (HEX='0F0F' not HEX='F0F')
      *    (1.2.3)type='nh' - 'hole' zero in, nothing out (4096h)  
      *             <data type='400h'/>
      *   pgm return:
      *     <return>(see below)</return>
      *      data structure:
      *       <ds [dim='n' dou='label' len='label' data='records']>
      *         (data elements below)
      *       </ds>
      *       (len/setlen 1.5.4)
      *      data elements:
      *       <data type='data types' 
      *          [dim='n' varying='on|off|2|4' enddo='label' setlen='label' offset='label'
      *           hex='on|off' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1' (1.6.8)
      *           trim='on|off'                                                 (1.7.1)
      *           next='nextoff'                                                (1.9.2)
      *           ]>
      *       </data>
      *       (len/setlen 1.5.4)
      *         data types (similar RPG):
      *           type='na' [varying='on|off|2|4'] - character (32A)
      *             <data type='32a'/>
      *             <data type='32a' varying='on'>ranger</data>
      *             <data type='32a'><![CDATA[<i am ranger>]]></data>
      *             <data type='200A' hex='on' before='1208/930' after='930/1208'>
      *             bin2hex($japan_raw_ascii_data)
      *             </data>
      *           type='npn' - packed decimal (12p2)
      *             <data type='12p2'/>
      *             <data type='12p2'>30.29</data>
      *           type='nsn' - zoned decimal (12s2)
      *             <data type='12s2'/>
      *             <data type='12s2'>30.29</data>
      *           type='nin' - signed integer (5i0, 10i0, 20i0)
      *             <data type='20i0'/>
      *             <data type='10i0'>-30</data>
      *           type='nun' - unsigned integer (5u0, 10u0, 20u0)
      *             <data type='20u0'/>
      *             <data type='10u0'>30</data>
      *           type='nfn' - floating point (4f2, 8f4)
      *             <data type='4f2'/>
      *             <data type='4f2'>30.34</data>
      *             <data type='8f4'>30.34</data>
      *           type='nb' - binary HEX char (2b, 400b)
      *             <data type='5b'>F0F1F2CDEF</data>
      *             <data type='2b'>1FBC</data>
      *             <data type='2b'>0F0F</data>
      *             - HEX upper case ('1FBC' not '1fbc')
      *             - high/low bits (HEX='0F0F' not HEX='F0F')
      *    (1.2.3)type='nh' - 'hole' zero in, nothing out (4096h)  
      *             <data type='400h'/>
      * 
      *     Note 1:
      *     1) PGM/SRVPGM calls (<pgm>,<parm>,<data>,<return>) use syntax
      *        that looks like RPG to describe the data parameters 
      *        (type='4b', type='32a', type='4f', type='10i0', type='12p2', 
      *        etc.).
      *     2) <data dim='n'> - dim='n' is new to 1.2 version and beyond, 
      *        older versions did not include this feature.
      *     3) Parameters using dou='label', enddo='label', 
      *        label must match for this to work,
      *        then processing will only return records up to enddo limits.
      *     4) Type 'h' for 'hole' is used to input x'00' fill 'hole' 
      *        in the parameter geometry. It can be used to skip over 
      *        a chunk of complex data that you really did not want to 
      *        deal with or see in output XML. It is also very handy to 
      *        use with overlay when output data is variable 
      *        or unpredictable (1.2.3)
      *        input:
      *        <ds>
      *        <data type='40a'>good stuff</data>     <---offset 0
      *        <data type='400h'/>                    <---400 x'00' input
      *        <data type='32a'>more good stuff</data><---offset 440
      *        </ds>
      *        output:
      *        <ds>
      *        <data type='40a'>stuff back</data>     <--- offset 0
      *        <data type='400h'> </data>             <--- ignored output
      *        <data type='32a'>stuff back</data>     <--- offset 440
      *        </ds>
      *      5) Added parm='omit' for RPG OPTIONS(*OMIT) parameter. A 
      *         *NULL will be passed in this location. 
      *         All parm io='omit' will be excluded from XML
      *         output returned because *NULL parameter has no data (1.2.3).
      *         <parm comment='my name' io='omit'>
      *           <data var='myName' type='10A'>Ranger</data> <--ignore *NULL
      *         </parm>
      *         RPG procedure (SRVPGM function):
      *         D zzomit PI 50A varying
      *         D myName 10A options(*OMIT) <---- optional omitted (*NULL)
      *         D yourName 10A
      *      6) 1.5.4 Added len='label'/setlen='label' to allow for
      *         automatic length calculation for various system
      *         APIs that want a %size(thing) parameter.
      *         This should work across parameters and within
      *         parameters (any order), but nesting len/setlen is
      *         not allowed.
      *          <parm  io="both" comment='Error code'>
      *           <ds comment='Format ERRC0100' len='rec2'>
      *            <data type='10i0' comment='returned'>0</data>
      *            <data type='10i0' comment='available' setlen='rec2'>0</data>
      *            <data type='7A' comment='Exception ID'> </data>
      *            <data type='1A' comment='Reserved'> </data>
      *           </ds>
      *          </parm>
      *      7) Up to four conversions can take place 
      *         for the truly complex ccsid issues (1.6.8)
      *         <data type='A' hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
      *         flow: 
      *         -> PHP client bin2hex('wild_ascii_raw_chars')
      *         -> xmlservice hex2bin back to 'wild_ascii_raw_chars'
      *         -> xmlservice convert cc1->cc2->cc3->cc4 (before)
      *         -> xmlservice make ILE call
      *         -> xmlservice convert cc4->cc3->cc2->cc1 (after)
      *         -> xmlservice tohex "xml_hex_back"
      *         -> PHP client $chars = pack('H*',"xml_hex_back")
      *      8) V5R4 accomidation for OPM programs like CLP (1.6.8)
      *         - mode='opm' uses non-teraspace memory to build parm lists
      *           that are used with _CALLPGMV for a "pure" OPM call mode
      *         - mode='ile' default using teraspace for "mixed" memory
      *           compatible with PASE calls (IBM i possiblilities)
      *      9) Allow trim control character/binary <data ... trim='on|off'>
      *         - trim='on'  -- right trim  (default character type='na')
      *         - trim='off' -- include all (default binary type='nb')
      *     10) see <overlay> for offset='label'
      *         <data offset='label'>            <-- memory location to pop off a 
      *                                              variable/changing offset value 
      *                                              for use in overlay()
      *         <overlay top='n' offset='label'> <-- top='n' overlay parameter 'n', 
      *                                              then add offset='label' pop value 
      *         - offset='label' allows label location to pop off a <data> offset value
      *           at this data location to add position offset <overlay offset='label'>
      *         - 'label' is NOT a position location for <overlay>, it only holds
      *           a offset value in this <data> memory location for things like
      *           system APIs with offset-2-next.
      *     11) data='records' - data follows in record format
      *         fast "many records" i/o big data (see below)  (1.7.5)
      *         <parm comment='wsopstdcnt'>
      *          <data type='3s0' enddo='wsopstdcnt'/>
      *         </parm>
      *         <parm comment='findMe1'>
      *          <ds var='findMe1' data='records'>
      *           <ds var='dcRec1_t' array='on'>
      *            <ds var='dcRec1_t'>
      *             <data var='dcMyName1' type='10A'/>
      *             <ds var='dcRec2_t'>
      *              <data var='dcMyName2' type='10A'/>
      *              <ds var='dcRec3_t'>
      *               <data var='dcMyName3' type='10A'/>
      *               <ds var='dcRec_t' dim='999' dou='wsopstdcnt'>
      *                <data var='dcMyName' type='10A'/>
      *                <data var='dcMyJob' type='4096A'/>
      *                <data var='dcMyRank' type='10i0'/>
      *                <data var='dcMyPay' type='12p2'/>
      *               </ds>
      *              </ds>
      *             </ds>
      *            </ds>
      *           </ds>
      *          </ds>
      *          <records delimit=':'>:Rgr:B:Ok:nd1:nd1:1:1.1:...:</records>
      *         </parm>
      *         Notes:
      *         a) <records delimit=':'> simply match in order input
      *            of any complex structure. Output matches
      *            order input (see above)
      *         b) <records  delimit=':'> delimit can be any character
      *            not in your complex records (see above)
      *         c) works with any <parm> or <return>
      *         d) dou/enddo works, but tricky script to design (be careful)
      *     12) setnext='nextoff' / next='nextoff' - see overlay  (1.9.2)
      *************************************************************************
      *   pgm parameters/return overlay (custom offset='bytes', input/output):
      *     <overlay 
      *       [io='in|out|both' offset='n|label' top='on|off|n'
      *        setnext='nextoff'                             (1.9.2)
      *       ]>
      *      (below)
      *     </overlay>
      *      data structure:
      *       <ds [dim='n' dou='label' len='label']>
      *         (data elements below)
      *       </ds>
      *       (len/setlen 1.5.4)
      *      data elements:
      *       <data type='data types' 
      *          [dim='n' varying='on|off|2|4' enddo='label' setlen='label' offset='label'
      *           hex='on|off' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1' (1.6.8)
      *           trim='on|off'                                                 (1.7.1)
      *          ]>
      *       </data>
      *       (len/setlen 1.5.4)
      *         data types (similar RPG):
      *           type='na' [varying='on|off|2|4'] - character (32A)
      *             <data type='32a'/>
      *             <data type='32a' varying='on'>ranger</data>
      *             <data type='32a'><![CDATA[<i am ranger>]]></data>
      *           type='npn' - packed decimal (12p2)
      *             <data type='12p2'/>
      *             <data type='12p2'>30.29</data>
      *           type='nsn' - zoned decimal (12s2)
      *             <data type='12s2'/>
      *             <data type='12s2'>30.29</data>
      *           type='nin' - signed integer (5i0, 10i0, 20i0)
      *             <data type='20i0'/>
      *             <data type='10i0'>-30</data>
      *           type='nun' - unsigned integer (5u0, 10u0, 20u0)
      *             <data type='20u0'/>
      *             <data type='10u0'>30</data>
      *           type='nfn' - floating point (4f2, 8f4)
      *             <data type='4f2'/>
      *             <data type='4f2'>30.34</data>
      *             <data type='8f4'>30.34</data>
      *           type='nb' - binary HEX char (2b, 400b)
      *             <data type='5b'>F0F1F2CDEF</data>
      *             <data type='2b'>1FBC</data>
      *             <data type='2b'>0F0F</data>
      *             - HEX upper case ('1FBC' not '1fbc')
      *             - high/low bits (HEX='0F0F' not HEX='F0F')
      *    (1.2.3)type='nh' - 'hole' zero in, nothing out (4096h)  
      *             <data type='400h'/>
      * 
      *     <overlay> works "relative" to "previous" <parm> in 
      *               "order of appearance XML"
      *               or absolute position to (top='n')
      *     <pgm>
      *     --->absolute parm             <---relative parm
      *     ---><parm>complex stuff</parm><-------------------
      *     |   <overlay>complex over parm 1   </overlay>____|
      *     |
      *     |--><parm>complex stuff</parm><-------------------
      *     ||  <overlay>complex over parm 2   </overlay>____|
      *     ||  :
      *     ||  <parm>complex stuff</parm><-------------------
      *     ||  <overlay>complex over last parm</overlay>____|
      *     ||  :
      *     |___<overlay top='on'>over top parm</overlay>
      *      |  :
      *      |__<overlay top='2'>over parm 2  </overlay>
      *     </pgm>
      *     Note:
      *      1) top='on|n' allow overlay position to parameter n
      *          ... top='on' absolute parm='1' (1.2.1)
      *          ... top='n' absolute parm='n' (1.2.2)
      *          ... offset='n' bytes offset relative 
      *              to top='n' position (parm 1,2,3, etc)
      *      2) Once the top='n' parm location is etablished, offset='n'
      *         will move overlay to offset within the parameter.
      *         <data offset='label'>            <-- memory location to pop off a 
      *                                              variable/changing offset value 
      *                                              for use in overlay()
      *         <overlay top='n' offset='label'> <-- top='n' overlay parameter 'n', 
      *                                              then add offset='label' pop value 
      *         - offset='label' allows label location to pop off a <data> offset value
      *           at this data location to add position offset <overlay offset='label'>
      *         - 'label' is NOT a position location for <overlay>, it only holds
      *           a offset value in this <data> memory location for things like
      *           system APIs with offset-2-next. 
      *     3) setnext='nextoff' / next='nextoff'  (1.9.2)
      *          <pgm name='QSZRTVPR'>
      *           <parm io='both'>
      *            <ds comment='PRDR0200' len='rec1'>
      *             :
      *             <data type='10i0' offset='myOffset'></data>
      *             :
      *           </ds>   
      *          </parm>
      *           : 
      *           <overlay io='out' top='1' offset='myOffset'>  
      *           <ds>
      *            <data type='10A'></data>
      *            <data type='2A'></data>
      *            <data type='10i0' enddo='prim'></data>
      *            <data type='10i0' offset='myOffset2'></data>
      *           </ds>
      *           </overlay>  
      *           <overlay io='out' top='1' offset='myOffset2' 
      *                    dim='10' dou='prim' setnext='nextoff'>
      *           <ds>
      *            <data type='10i0' next='nextoff'></data>
      *            <data type='10A'></data>
      *            <data type='10A'></data>
      *            <data type='10A'></data>
      *            <data type='10A'></data>
      *            <data type='10A'></data>
      *            <data type='10A'></data>
      *            <data type='10i0'></data>
      *            <data type='10A'></data>
      *           </ds>
      *           </overlay> 
      *************************************************************************

      *****************************************************
      * ILE callable
      *****************************************************
     D ileEZero        PR
     D ileErrno        PR            10I 0
     D ileStatus       PR            10I 0
     D ileMsgId        PR             7A
     D ileStatus2      PR            10I 0
     D ileMsgId2       PR             7A

     D ileDoTest       PR
     D  endTest                       1A   value

     D ileStatic       PR             1N
     D  allOPM                        1A   value

     D ILE_SAVE_START...
     D                 c                   const('S')
     D ILE_RESTORE_TOP...
     D                 c                   const('T')
     D ILE_RESTORE_START...
     D                 c                   const('R')
     D ILE_SAVE_END...
     D                 c                   const('E')
     D ILE_RESTORE_END...
     D                 c                   const('X')
     D ILE_RESTORE_PARM...
     D                 c                   const('P')

     D ileMark         PR
     D   op                           1A   value
     D   wrkWth                       1A   value
     D   offset                      10i 0 value options(*nopass)
     D   parmno                      10i 0 value options(*nopass)

     D ileCmdExc       PR             1N
     D   cmd                           *   value
     D   len                         10i 0 value

     D ileCmdCap       PR             1N
     D   cmd                           *   value
     D   len                         10i 0 value

     D ileSystem       PR             1N
     D   cmd                           *
     D   len                         10i 0

     D ileRexx         PR             1N
     D   setCDATA                     1N   value
     D   cmd                           *
     D   len                         10i 0
     D   datastr                  65000A

     D ileSzArgv       PR            10i 0
     D   start                         *

     D ileSzParm       PR            10i 0
     D   start                         *

     D ileSzRet        PR            10i 0
     D   start                         *

     D ilePushData     PR             1N
     D   node                              likeds(xmlNode_t)
 
     D ilePushLen      PR             1N
     D   node                              likeds(xmlNode_t)

     D ilePopData      PR             1N
     D   outPtrP                       *
     D   node                              likeds(xmlNode_t)
 
     D ilePopVal       PR            10i 0
     D   node                              likeds(xmlNode_t)

     D uintQuad        PR            20U 0
     D   start                       20U 0 value

     D ileQuad         PR              *
     D   start                         *   value
     D   offset                        *   value

     D ileIsV5         PR             1N

     D ileRslv         PR             1N
     D  pgm2                         10A   value
     D  lib2                         10A   value
     D  pSym                           *
     D  sym2                        128A   value options(*nopass)

     D ilePGM          PR             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  piReturn                       *

     D ileSRV          PR             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  sym1                        128A
     D  piReturn                       *
     D  retSize                      10i 0

     D ileAddr         PR              *
     D  isReturn                      1N   value

     D ileDup          PR
     D  isReturn                      1N   value
     D  pdupbeg                        *   value
     D  pdupend                        *   value


