      /if defined(PLUGXML_H)
      /eof
      /endif
      /define PLUGXML_H
   
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
      * global vars
      *****************************************************
     D XML_PGM_TOP_TRUE...
     D                 c                   const(x'01')
     D XML_PGM_TOP_FALSE...
     D                 c                   const(x'00')

     D XML_PGM_OPM_TRUE...
     D                 c                   const(x'01')
     D XML_PGM_OPM_FALSE...
     D                 c                   const(x'00')

     D XML_PGM_ERROR_TRUE...
     D                 c                   const(x'01')
     D XML_PGM_ERROR_FALSE...
     D                 c                   const(x'00')

     D XML_OVR_TOP_TRUE...
     D                 c                   const(x'01')
     D XML_OVR_TOP_FALSE...
     D                 c                   const(x'00')


     D XML_PARM_OMIT_TRUE...
     D                 c                   const(x'01')
     D XML_PARM_OMIT_FALSE...
     D                 c                   const(x'00')

     D XML_ATTR_HEX_TRUE...
     D                 c                   const(x'01')
     D XML_ATTR_HEX_FALSE...
     D                 c                   const(x'00')

     D XML_ATTR_TRIM_TRUE...
     D                 c                   const(x'01')
     D XML_ATTR_TRIM_FALSE...
     D                 c                   const(x'02')
     D XML_ATTR_TRIM_DEFAULT...
     D                 c                   const(x'00')

     D XML_ATTR_CDATA_TRUE...
     D                 c                   const(x'01')
     D XML_ATTR_CDATA_FALSE...
     D                 c                   const(x'00')

     D XML_FUNC_PGM...
     D                 c                   const(x'00')
     D XML_FUNC_SRVPGM...
     D                 c                   const('S')

     D XML_IS_PARM...
     D                 c                   const(x'00')
     D XML_IS_RETURN...
     D                 c                   const('R')

     D XML_BY_VAL...
     D                 c                   const('V')
     D XML_BY_REF...
     D                 c                   const(x'00')
     D XML_BY_MBR...
     D                 c                   const('M')

     D XML_PTR_ILE...
     D                 c                   const('I')
     D XML_PTR_PASE...
     D                 c                   const('P')
     D XML_PTR_NADA...
     D                 c                   const(x'00')

     D XML_IO_INPUT...
     D                 c                   const('I')
     D XML_IO_OUTPUT...
     D                 c                   const('O')
     D XML_IO_BOTH...
     D                 c                   const(x'00')

     D XML_VARY_4...
     D                 c                   const(x'04')
     D XML_VARY_ON...
     D                 c                   const(x'02')
     D XML_VARY_OFF...
     D                 c                   const(x'00')

     D XML_ATTR_VAL_NADA...
     D                 c                   const(x'00')
     D XML_ATTR_VAL_A...
     D                 c                   const('A')
     D XML_ATTR_VAL_I...
     D                 c                   const('I')
     D XML_ATTR_VAL_U...
     D                 c                   const('U')
     D XML_ATTR_VAL_P...
     D                 c                   const('P')
     D XML_ATTR_VAL_S...
     D                 c                   const('S')
     D XML_ATTR_VAL_F...
     D                 c                   const('F')
     D XML_ATTR_VAL_D...
     D                 c                   const('D')
     D XML_ATTR_VAL_B...
     D                 c                   const('B')
     D XML_ATTR_VAL_H...
     D                 c                   const('H')

     D XML_ELEMENT_OPEN...
     D                 c                   const('O')
     D XML_ELEMENT_CONN...
     D                 c                   const('C')
     D XML_ELEMENT_STMT...
     D                 c                   const('S')
     D XML_ELEMENT_BOTH...
     D                 c                   const('B')
     D XML_ELEMENT_CLOSE...
     D                 c                   const('E')
     D XML_ELEMENT_CLOSE_NOLF...
     D                 c                   const('N')

     D XML_IS_RECORDS_FALSE...
     D                 c                   const(x'00')
     D XML_IS_RECORDS_TRUE...
     D                 c                   const('R')
     D XML_IS_RECORDS_DS...
     D                 c                   const('S')
     D XML_IS_RECORDS_DATA...
     D                 c                   const('D')


      *****************************************************
      * global xml
      *****************************************************
     D xmlStatic       PR
     D   aCtlP                         *   value

     D xmlOutUsed      PR            10i 0
     D xmlOutRoom      PR            10i 0
     D xmlOutReset     PR

     D xmlSetCDATA     PR
     D   setCDATA                     1N   value
     D xmlGetCDATA     PR             1N
     D xmlcCDATA1      PR             9A
     D xmlcCDATA2      PR             3A

     D xmlCTOR         PR
     D   node                              likeds(xmlNode_t) 

     D xmlCOPY         PR
     D   node                              likeds(xmlNode_t) 
     D   node2                             likeds(xmlNode_t) 

     D xmlSetHead      PR
     D   data                          *   value
     D   dataSz                      10i 0 value

     D xmlGetHead      PR          2048A

     D xmlPreSbm       PR             1N
     
     D xmlPreRun       PR             1N

     D xmlRun          PR             1N

     D xmlHack         PR             1N

     D xmlTerm         PR             1N

     D xmlLic          PR             1N

     D xmlSess         PR             1N
     D   addHead                      1N   value options(*nopass)
     D   addJobNbr                    1N   value options(*nopass)

     D xmlPerf         PR             1N
     D   ipcCtl                            likeds(ipcRec_t)

     D xmlPerfRpt      PR
     D   pData                         *   value
     D   report                   32000A

     D xmlError        PR             1N
     D   isfull                       1N   value
     D   isjoblog                     1N   value
     D   ijobName                    10A   value options(*nopass)
     D   ijobUserID                  10A   value options(*nopass)
     D   ijobNbr                      6A   value options(*nopass)
     D   ifast                        1N   value options(*nopass)

     D xmlOutput       PR
     D   string                        *   value
     D   stringLen                   10i 0 value
     D   addLF                        1N   value
     D   subSlash                     1N   value options(*nopass)

     D xmlDump         PR
     D   msg                         15A   value
     D   pTop                          *   value
     D   pBot                          *   value
     D   isHex                        1N   value

     D xmlExec32       PR             1N
     D cmd                             *   value
     D cmdLen                        10i 0 value
     D isRows                         1N   value
     D keepBottom                     1N   value
     D isCDATA                        1N   value
     D out                             *   value
     D outLen                        10i 0 value
     D retLen                        10i 0


      *****************************************************
      * global batch slots
      *****************************************************
     D xmlBatAny       PR            10i 0

     D xmlBatCopy      PR             1N
     D   runMemP                       *   value

     D xmlBatXML       PR             1N
     D   runMemP                       *

     D xmlBatGet       PR             1N
     D   runMemP                       *   value

     D xmlBatDone      PR
     D   runMemP                       *   value



